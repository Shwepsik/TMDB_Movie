//
//  DiscoverNavigator.swift
//  tmdb-mvvm-pure
//
//  Created by krawiecp-home on 27/01/2019.
//  Copyright © 2019 tailec. All rights reserved.
//

import UIKit

protocol DiscoverNavigatable {
    func navigateToMovieDetailScreen(withMovieId id: Int, api: TMDBApiProvider)
    func navigateToPeopleDetailsScreen(name: String, profileUrl: String)
    func navigateToShowDetailScreen()
}

final class DiscoverNavigator: DiscoverNavigatable {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func navigateToMovieDetailScreen(withMovieId id: Int, api: TMDBApiProvider) {
        let movieDetailNavigator = MovieDetailNavigator(navigationController: navigationController)
        let movieDetailViewModel = MovieDetailViewModel(dependencies: MovieDetailViewModel.Dependencies(id: id,
                                                                                                        api: api,
                                                                                                        navigator: movieDetailNavigator))
        let movieDetailViewController = UIStoryboard.main.movieDetailViewController
        movieDetailViewController.viewModel = movieDetailViewModel
        movieDetailViewController.hidesBottomBarWhenPushed = true

        navigationController.show(movieDetailViewController, sender: nil)
    }
    
    func navigateToPeopleDetailsScreen(name: String, profileUrl: String) {
        let peopleDetailsNavigator = PeopleDetailsNavigator(navigationController: navigationController)
        let peopleDetailsViewModel = PeopleDetailsViewModel(dependencies: PeopleDetailsViewModel.Dependencies(name: name, prifileUrl: profileUrl, navigator: peopleDetailsNavigator))
        let peopleDetailsViewController = UIStoryboard.main.peopleDetailsViewController
        peopleDetailsViewController.viewModel = peopleDetailsViewModel
        peopleDetailsViewController.hidesBottomBarWhenPushed = true
        
        navigationController.show(peopleDetailsViewController, sender: nil)
    }
    
    func navigateToShowDetailScreen() {
        
    }
}
