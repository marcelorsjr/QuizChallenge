import Foundation

class KeywordsEndpoint: Endpoint {
    var baseUrl: URL {
        get {
            guard let url = URL(string: Constants.api.baseURL) else {
                fatalError("Error creating baseURL with: \(Constants.api.baseURL)")
            }
            return url
        }
    }
    
    lazy var fullPath: URL = {
        return baseUrl.appendingPathComponent(path)
    }()
    
    var method: MethodHTTP = .get
    
    var path: String = Constants.api.keywordsPath
    
    var parameters: [String : Any]?
    
    var headers: [String : String]?
    
    func errorMessage(with statusCode: Int?) -> String {
       return Constants.api.genericError
    }
}
