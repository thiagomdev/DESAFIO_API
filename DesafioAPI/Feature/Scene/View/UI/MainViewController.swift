import UIKit

final class MainViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: MainViewModeling
    private var body: Body?
    
    // MARK: - Components
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 80
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Initializers
    init(viewModel: MainViewModeling = MainViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
        setPin()
        extraConfig()
        getData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods
extension MainViewController {
    private func getData() {
        viewModel.getRequest { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func showAlert(message: String) {
        DispatchQueue.main.sync {
            let alert = UIAlertController(title: "ALERT 🚨", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Fechar", style: .default))
            present(alert, animated: true)
        }
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.modeling[indexPath.row]
        viewModel.postRequest(body: .init(reason: model.description)) { [weak self] result in
            switch result {
            case let .success(value):
                self?.showAlert(message: "\(value)\n\(model.description).")
            case let .failure(failure):
                print(failure)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.modeling.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TableViewCell.identifier,
            for: indexPath
        ) as? TableViewCell else { return UITableViewCell() }
        
        cell.setupCell(from: viewModel.modeling[indexPath.row])
        return cell
    }
}

// MARK: - ViewConfiguration
extension MainViewController {
    private func buildView() {
        view.addSubview(tableView)
    }
    
    private func setPin() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func extraConfig() {
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
    }
}
