import Foundation

protocol MainViewModeling {
    var modeling: [MainModel] { get }
    func getRequest(callback: @escaping () -> Void)
    func postRequest(body: Body, callback: @escaping (Result<ResponseBody, Error>) -> Void)
}

final class MainViewModel {
    // MARK: - Properties
    private var model: [MainModel]
    private let service: MainServicingProtocol
    
    // MARK: - Properties
    init(
        model: [MainModel] = [],
        service: MainServicingProtocol = MainService()
    ) {
        self.model = model
        self.service = service
    }
}

// MARK: - MainViewModeling
extension MainViewModel: MainViewModeling {
    func getRequest(callback: @escaping () -> Void) {
        service.getRequest { [weak self] result in
            switch result {
            case let .success(model):
                self?.model = model
                callback()
            case .failure:
                break
            }
        }
    }
    
    func postRequest(body: Body, callback: @escaping (Result<ResponseBody, Error>) -> Void) {
        service.postRequest(body: body) { result in
            switch result {
            case let .success(model):
                callback(.success(model))
            case .failure:
                break
            }
        }
    }

    var modeling: [MainModel] {
        return model
    }
}
