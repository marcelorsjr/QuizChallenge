import Foundation

protocol APIClient {
    func request<T: Decodable>(_ request: Endpoint, completion: @escaping (Result<T, QuizError>) -> Void)
}

public enum QuizError: Error, Equatable {
    case apiError(statusCode: Int, errorMessage: String)
    case genericError(errorMessage: String)
    
    var localizedDescription: String {
        switch self {
        case .genericError(let errorMessage):
            return errorMessage
            
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
    
    private func handleResponse<T: Decodable>(_ data: Data, forEndpoint endpoint: Endpoint) -> Result<T, QuizError> {
        guard let object: T = try? JSONDecoder().decode(T.self, from: data) else {
            return Result.failure(QuizError.genericError(errorMessage: endpoint.errorMessage(with: nil)))
        }
        
        return .success(object)
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, QuizError>) -> Void) {
        let request = urlRequest(from: endpoint)
        urlSession.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            
            if error != nil {
                if let response = response as? HTTPURLResponse {
                    let statusCode = response.statusCode
                    DispatchQueue.main.async {
                        return completion(Result.failure(.apiError(statusCode: statusCode, errorMessage: endpoint.errorMessage(with: statusCode))))
                    }
                } else {
                    DispatchQueue.main.async {
                        return completion(Result.failure(.genericError(errorMessage: endpoint.errorMessage(with: nil))))
                    }
                }
                
            }
            
            
            if let response = response as? HTTPURLResponse {
                if let data = data, 200...299 ~= response.statusCode {
                    DispatchQueue.main.async {
                        return completion(self.handleResponse(data, forEndpoint: endpoint))
                    }
                } else {
                    let statusCode = response.statusCode
                    DispatchQueue.main.async {
                        return completion(Result.failure(.apiError(statusCode: statusCode, errorMessage: endpoint.errorMessage(with: statusCode))))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    return completion(Result.failure(.genericError(errorMessage: endpoint.errorMessage(with: nil))))
                }
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
