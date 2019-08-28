import Foundation

protocol APIClient {
    func request<T: Decodable>(_ request: Endpoint, completion: @escaping (Result<T, QuizError>) -> Void)
}

public enum QuizError: Error, Equatable {
    case apiError(statusCode: Int?, errorMessage: String)
    case genericError
    
    var localizedDescription: String {
        switch self {
        case .genericError:
            return "Something went wrong... :/ \n We're trying to solve the problem!"
            
        case .apiError(_, let errorMessage):
            return errorMessage
        }
    }
}

class APIClientImpl: APIClient {
    
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
        self.urlSession = urlSession
    }
    
    private func tryMap<T: Decodable>(_ data: Data, forEndpoint endpoint: Endpoint) -> Result<T, QuizError> {
        guard let object: T = try? JSONDecoder().decode(T.self, from: data) else {
            return Result.failure(QuizError.genericError)
        }
        
        return .success(object)
    }
    
    private func handleResponse<T: Decodable>(_ endpoint: Endpoint, data: Data?, response: URLResponse?, error: Error?) -> Result<T, QuizError> {
        if error != nil {
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            return Result.failure(.apiError(statusCode: statusCode, errorMessage: endpoint.errorMessage(with: statusCode)))
        }
        
        
        if let response = response as? HTTPURLResponse {
            if let data = data, 200...299 ~= response.statusCode {
                return self.tryMap(data, forEndpoint: endpoint)
            } else {
                let statusCode = response.statusCode
                return Result.failure(.apiError(statusCode: statusCode, errorMessage: endpoint.errorMessage(with: statusCode)))
            }
        } else {
            return Result.failure(QuizError.genericError)
            
        }
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, QuizError>) -> Void) {
        let request = urlRequest(from: endpoint)
        self.urlSession.dataTask(with: request as URLRequest) {  (data, response, error) -> Void in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                completion(self.handleResponse(endpoint, data: data, response: response, error: error))
            }
        }.resume()
    }
    
    private func urlRequest(from endpoint: Endpoint) -> URLRequest {
        var request = URLRequest(url: endpoint.fullPath)
        request.httpMethod = endpoint.method.rawValue
        
        if let headers = endpoint.headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
}
