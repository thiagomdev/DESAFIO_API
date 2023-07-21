import Foundation

protocol MainServicingProtocol {
    func getRequest(callback: @escaping (Result<[MainModel], Error>) -> Void)
    func postRequest(body: Body, callback: @escaping (Result<ResponseBody, Error>) -> Void)
}

final class MainService {
    // MARK: - Properties
    private var task: Task?
    private let networking: NetworkingProtocol
    
    // MARK: - Initializers
    init(
        networking: NetworkingProtocol = Networking()
    ) {
        self.networking = networking
    }
}

// MARK: - MainServicingProtocol
extension MainService: MainServicingProtocol {
    func getRequest(callback: @escaping (Result<[MainModel], Error>) -> Void) {
        task = networking.execute(request: APIRequest.reason, responseType: [MainModel].self, callback: { result in
            switch result {
            case let .success(model):
                callback(.success(model))
            case let .failure(err):
                callback(.failure(err))
            }
        })
        task?.resume()
    }
    
    func postRequest(body: Body, callback: @escaping (Result<ResponseBody, Error>) -> Void) {
        task = networking.execute(request: APIRequest.cancel(body), responseType: ResponseBody.self, callback: { result in
            switch result {
            case let .success(value):
                callback(.success(value))
            case let .failure(err):
                callback(.failure(err))
            }
        })
        task?.resume()
    }
}
