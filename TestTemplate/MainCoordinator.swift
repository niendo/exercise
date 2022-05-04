//
//  MainCoordinator.swift
//  template
//
//  Created by Eduardo Nieto.
//

import UIKit

final class MainCoordinator: NSObject {

    var navigationController: UINavigationController
    let networkService = NetworkService()
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        showListVC()
    }
    func showListVC() {
        let vc = ListViewController(coordinator: self, viewModel: ListViewModel(postService: PostService(networkService: networkService), userService: UserService(networkService: networkService)))
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showDetailVC(_ postViewModel: PostViewModel) {
        let vc = DetailViewController(coordinator: self, viewModel: DetailViewModel(commentService: CommentService(networkService: networkService), postViewModel: postViewModel))
        navigationController.pushViewController(vc, animated: true)
    }
    
    func dismissVC() {
        navigationController.dismiss(animated: true)
    }
}

extension MainCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromVC = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(fromVC) {
            return
        }
    }
}
