//
//  DetailViewController.swift
//  template
//
//  Created by Eduardo Nieto.
//

import UIKit
class DetailViewController: UIViewController {
    //TODO implement view components
    private lazy var textView = makeTextView()
    private lazy var errorView = makeErrorLabel()
    private lazy var opaqueView = makeOpaqueView()
    
    private weak var coordinator: MainCoordinator!
    private let viewModel: DetailViewModel
    
    init(coordinator: MainCoordinator, viewModel: DetailViewModel) {
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
        viewModel.fetchDetail(post: viewModel.postViewModel, success: showComments, failure: showError)
        buildUI()
    }
}

private extension DetailViewController {
    
    func buildUI() {
        view.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textView.widthAnchor.constraint(equalTo: view.widthAnchor),
            textView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    func showComments(_ comments: [CommentViewModel]) {
        for comment in comments {
            textView.text = textView.text + " \n\n \(comment.text)"
        }
    }
    
    func showError(_ error: String) {
        view.addSubview(opaqueView)
        view.addSubview(errorView)
        textView.isHidden = true
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
    
    func makeTextView() -> UITextView {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 16)

        return view
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
