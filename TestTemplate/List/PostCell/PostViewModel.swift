//
//  PostViewModel.swift
//  TestTemplate
//
//  Created by Eduardo Nieto.
//

import Foundation
class PostViewModel: Hashable {

    private let post: Post
    private let user: User
    init(post: Post, user: User) {
        self.post = post
        self.user = user
    }
    
    static func == (lhs: PostViewModel, rhs: PostViewModel) -> Bool {
        lhs.post.id == rhs.post.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(post.id)
    }
}

extension PostViewModel {
    var id: Int {
        post.id
    }
    var username: String {
        "username: \(user.username)"
    }
    
    var title: String {
        "Post: \(post.title)"
    }
    
    var body: String {
        post.body
    }
}
