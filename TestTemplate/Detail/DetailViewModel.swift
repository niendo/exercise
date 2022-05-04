//
//  DetailViewModel.swift
//  template
//
//  Created by Eduardo Nieto.
//

import Foundation
class DetailViewModel {

    private let commentService: CommentServiceType
    let postViewModel: PostViewModel
    init(commentService: CommentServiceType, postViewModel: PostViewModel) {
        self.commentService = commentService
        self.postViewModel = postViewModel
    }
    
    func fetchDetail(post: PostViewModel, success: @escaping (_ posts: [CommentViewModel]) -> Void, failure: @escaping (_ error: String) -> Void) {
      
        commentService.fetchComments(postId: post.id) { result in
            
            DispatchQueue.main.async {
                switch result {
                case let .success(posts):
                    success(posts.map{ CommentViewModel(comment: $0) })
                case let .failure(error):
                    failure(error.localizedDescription)
                }
                
            }
            
        }
    }
}

struct CommentViewModel {
    private let comment: Comment
    init(comment: Comment) {
        self.comment = comment
    }
}

extension CommentViewModel {
    var text: String {
        "\(comment.email): \(comment.body)"
    }
}
