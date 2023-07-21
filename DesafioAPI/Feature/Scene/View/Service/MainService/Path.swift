enum Path {
    case reason
    case cancel
    
    var description: String {
        switch self {
        case .reason:
            return "/reasons"
        case .cancel:
            return "/cancel/reason"
        }
    }
}
