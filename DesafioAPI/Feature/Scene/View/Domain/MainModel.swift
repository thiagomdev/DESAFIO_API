import Foundation

struct ResponseBody: Codable, Equatable {
    let success: Bool
}

struct Body: Codable, Equatable {
    let reason: String
}

struct MainModel: Codable, Equatable {
    let id: String
    let description: String
}
