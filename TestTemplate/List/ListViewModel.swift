//
//  ListViewModel.swift
//  template
//
//  Created by Eduardo Nieto.
//

import Foundation
class ListViewModel {
    var posts = [PostViewModel]()
    private var userList = [User]()
    private var postList = [Post]()
    private var postService: PostServiceType
    private var userService: UserServiceType

    init(postService: PostServiceType, userService: UserServiceType) {
        self.postService = postService
        self.userService = userService
    }
    
    func fetchPosts(success: @escaping (_ posts: [PostViewModel]) -> Void, failure: @escaping (_ error: String) -> Void) {

        var postList = [Post]()
        var userList = [User]()

        let group = DispatchGroup()

        group.enter()
        postService.fetchPosts { result in
            switch result {
            case let .success(posts):
                postList = posts
            case let .failure(error):
                failure(error.localizedDescription)
            }
            group.leave()
        }
        
        group.enter()
        userService.fetchUsers { result in
            switch result {
            case let .success(users):
                userList = users
            case let .failure(error):
                failure(error.localizedDescription)
            }
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            
            var result = [PostViewModel]()

            for post in postList {
                guard let user =  userList.first(where: { $0.id == post.userId }) else { continue }
                result.append(PostViewModel(post: post, user: user))
            }
            self?.posts = result
           
            success(result)
        }
    }
}
