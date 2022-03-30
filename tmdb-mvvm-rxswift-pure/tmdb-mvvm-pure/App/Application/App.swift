//
//  App.swift
//  tmdb-mvvm-pure
//
//  Created by krawiecp-home on 30/01/2019.
//  Copyright © 2019 tailec. All rights reserved.
//

import UIKit

final class App {
    static let shared = App()
    
    func startInterface(in window: UIWindow) {
        window.rootViewController = rootViewController(for: Session())
        window.makeKeyAndVisible()
    }
    
    func updateWindowRootViewController(for session: SessionStorage) {
        guard let window = UIApplication.shared.keyWindow else { return }
        let controller = rootViewController(for: session)
        window.rootViewController = controller
        UIView.transition(
            with: window,
            duration: 0.6,
            options: .transitionCrossDissolve,
            animations: nil
        )
    }
}

// MARK: - Private

private extension App {
    
    func rootViewController(for session: SessionStorage) -> UIViewController {
        session.isAuthorized ? tabBarController() : authorizationController()
    }
    
    func authorizationController() -> UIViewController {
        let loginNavigationController = UINavigationController()
        let loginNavigator = LoginNavigator(navigationController: loginNavigationController)
        let loginViewModel = LoginViewModel(dependencies: LoginViewModel.Dependencies(api: TMDBApi(), navigator: loginNavigator, session: Session()))
        let loginViewController = UIStoryboard.main.loginViewController
        loginViewController.viewModel = loginViewModel
        loginNavigationController.viewControllers = [loginViewController]
        return loginViewController
    }
    
    func tabBarController() -> UIViewController {
        let discoverNavigationController = UINavigationController()
        let discoverNavigator = DiscoverNavigator(navigationController: discoverNavigationController)
        let discoverViewModel = DiscoverViewModel(dependencies: DiscoverViewModel.Dependencies(api: TMDBApi(), navigator: discoverNavigator))
        let discoverViewController = UIStoryboard.main.discoverViewController
        discoverViewController.viewModel = discoverViewModel
        
        let searchNavigationController = UINavigationController()
        let searchNavigator = SearchNavigator(navigationController: searchNavigationController)
        let searchViewModel = SearchViewModel(dependencies: SearchViewModel.Dependencies(api: TMDBApi(), navigator: searchNavigator))
        let searchViewController = UIStoryboard.main.searchViewController
        searchViewController.viewModel = searchViewModel
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.barTintColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1.0)
        tabBarController.tabBar.tintColor = .white

        discoverNavigationController.tabBarItem = UITabBarItem(title: "Discover", image: nil, selectedImage: nil)
        discoverNavigationController.viewControllers = [discoverViewController]
        
        searchNavigationController.viewControllers = [searchViewController]
        searchNavigationController.tabBarItem = UITabBarItem(title: "Search", image: nil, selectedImage: nil)
        
        tabBarController.viewControllers = [
            discoverNavigationController,
            searchNavigationController
        ]
        
        return tabBarController
    }
}
