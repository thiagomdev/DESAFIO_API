import Foundation

protocol Request {
    var baseUrl: String { get }
    var endpoint: String { get }
    var method: HttpMethod { get }
    
    var parameters: [String: String]? { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}

protocol Task {
    var request: Request { get }
    func resume()
    func cancel()
}

extension Request {
    var baseUrl: String {
        "https://9a1c098c-8f75-47ad-a938-ad3f9179490a.mock.pstmn.io"
    }
    
    var url: String {
        var components = URLComponents()
        if let parameters = parameters {
            var queryItems: [URLQueryItem] = []
            parameters.forEach { key, value in
                queryItems.append(
                    URLQueryItem(
                        name: key,
                        value: value.addingPercentEncoding(
                            withAllowedCharacters: .urlQueryAllowed))
                )
            }
            components.queryItems = queryItems
            return baseUrl + endpoint + components.path
        }
        return baseUrl + endpoint
    }
}
