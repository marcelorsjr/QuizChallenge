import Foundation

class KeywordsEndpoint: Endpoint {
    var baseUrl: URL = URL(string: "https://codechallenge.arctouch.com/")!
    
    lazy var fullPath: URL = {
        return baseUrl.appendingPathComponent(path)
    }()
    
    var method: MethodHTTP = .get
    
    var path: String = "quiz/java-keywords"
    
    var parameters: [String : Any]?
    
    var headers: [String : String]?
    
    func errorMessage(with statusCode: Int?) -> String {
       return "Something went wrong... :/ \n We're trying to solve the problem!"
    }
}
