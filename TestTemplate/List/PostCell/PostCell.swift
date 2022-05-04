//
//  PostCell.swift
//  TestTemplate
//
//  Created by Eduardo Nieto.
//

import UIKit

public final class PostCell: UITableViewCell {

    private lazy var title = UILabel()
    private lazy var username = UILabel()
    private lazy var stackView = makeStackView()
    
    private var viewModel: PostViewModel?
    
    static var reuseIdentifier: String {
        String(describing: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        buildUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: PostViewModel) {
        self.viewModel = viewModel
        setupUI()
    }
}

private extension PostCell {
    
    func buildUI() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            title.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            title.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            username.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            username.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),


        ])
        
    }
    
    func setupUI() {
        title.text = viewModel?.title
        username.text = viewModel?.username
    }
    
    func makeStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [title, username])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 15
        return stackView
    }
}

