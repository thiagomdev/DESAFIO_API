import Foundation

enum APIRequest: Request {
    case reason
    case cancel(Body)
    
    var endpoint: String {
        switch self {
        case .reason:
            return Path.reason.description
        case .cancel:
            return Path.cancel.description
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .reason:
            return .get
        case .cancel:
            return .post
        }
    }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
 
    var body: Data? {
        switch self {
        case .reason:
            return nil
        case let .cancel(body):
            return try? JSONEncoder().encode(body)
        }
    }
    
    var parameters: [String : String]? { [:] }
}
