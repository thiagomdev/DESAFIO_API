import UIKit

protocol TableViewCellProtocol {
    func setupCell(from data: MainModel)
}

final class TableViewCell: UITableViewCell {
    // MARK: - Identifier
    static var identifier: String {
        String(describing: self)
    }
    
    // MARK: - Components
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Life Cycle
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
        setPin()
        extraConfig()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - TableViewCellProtocol
extension TableViewCell: TableViewCellProtocol {
    func setupCell(from data: MainModel) {
        idLabel.text = data.id
        descriptionLabel.text = data.description
    }
}

// MARK: - ViewConfiguration
extension TableViewCell {
    private func buildView() {
        contentView.addSubview(idLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    private func setPin() {
        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            
            idLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 8
            ),
            
            descriptionLabel.topAnchor.constraint(
                equalTo: idLabel.bottomAnchor,
                constant: 3
            ),
            
            descriptionLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 8
            ),
        ])
    }
    
    private func extraConfig() {
        contentView.backgroundColor = .systemBackground
    }
}
