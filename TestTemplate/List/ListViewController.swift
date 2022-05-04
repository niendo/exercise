//
//  ListViewController.swift
//  template
//
//  Created by Eduardo Nieto.
//

import UIKit
class ListViewController: UITableViewController {
    
    private lazy var dataSource = makeDataSource(viewModel: viewModel)
    private lazy var errorView = makeErrorLabel()
    private lazy var opaqueView = makeOpaqueView()

    private weak var coordinator: MainCoordinator!
    private let viewModel: ListViewModel
    
    init(coordinator: MainCoordinator, viewModel: ListViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let post = dataSource.itemIdentifier(for: indexPath) else { return }
        coordinator.showDetailVC(post)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

private extension ListViewController {

    func configure() {
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseIdentifier)
        tableView.dataSource = dataSource
        viewModel.fetchPosts(success: update, failure: showError)
    }
    
    func makeDataSource(viewModel: ListViewModel) -> UITableViewDiffableDataSource<Section, PostViewModel> {
        let dataSource = UITableViewDiffableDataSource<Section, PostViewModel>(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseIdentifier, for: indexPath) as! PostCell
            cell.configure(viewModel: viewModel.posts[indexPath.row])
            return cell
        }
        dataSource.defaultRowAnimation = .fade
        return dataSource
    }

    func primeSnapshot() {
        let snapshot = NSDiffableDataSourceSnapshot<Section, PostViewModel>()
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    func update(with list: [PostViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, PostViewModel>()
        snapshot.appendSections([.posts])
        snapshot.appendItems(list, toSection: .posts)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func remove(_ post: PostViewModel, animate: Bool = true) {
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems([post])
        dataSource.apply(snapshot, animatingDifferences: animate)
    }
    
    func showError(_ error: String) {
        view.addSubview(opaqueView)
        view.addSubview(errorView)
        errorView.text = error
        NSLayoutConstraint.activate([
            opaqueView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            opaqueView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            opaqueView.heightAnchor.constraint(equalTo: view.heightAnchor),
            opaqueView.widthAnchor.constraint(equalTo: view.widthAnchor),
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func removeError() {
        errorView.removeFromSuperview()
        opaqueView.removeFromSuperview()
    }
    
    func makeOpaqueView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = .black.withAlphaComponent(0.5)
        return view
    }
    func makeErrorLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .red
        return label
    }
    


}

extension ListViewController {
    enum Section: CaseIterable {
        case posts
        case comments
        case users
    }
}
