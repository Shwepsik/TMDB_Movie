//
//  PeopleDetailsNavigator.swift
//  tmdb-mvvm-pure
//
//  Created by Valerii Biliarchyk on 26.03.2022.
//  Copyright © 2022 tailec. All rights reserved.
//

import UIKit

protocol PeopleDetailsNavigatable {
    func goBack()
}

final class PeopleDetailsNavigator: PeopleDetailsNavigatable {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
