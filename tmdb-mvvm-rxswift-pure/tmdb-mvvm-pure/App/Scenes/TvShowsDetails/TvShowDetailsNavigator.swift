//
//  TvShowDetailsNavigator.swift
//  tmdb-mvvm-pure
//
//  Created by Valerii Biliarchyk on 29.03.2022.
//  Copyright © 2022 tailec. All rights reserved.
//

import UIKit

protocol TvShowDetailsNavigatable {
    func goBack()
}

final class TvShowDetailsNavigator: TvShowDetailsNavigatable {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
