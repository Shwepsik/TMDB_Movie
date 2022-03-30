//
//  Session.swift
//  tmdb-mvvm-pure
//
//  Created by Valerii Biliarchyk on 25.03.2022.
//  Copyright © 2022 tailec. All rights reserved.
//

import Foundation

protocol SessionStorage: AnyObject {
    var isAuthorized: Bool { get set }
}

final class Session: SessionStorage {
    var isAuthorized: Bool {
        get {
            UserDefaults.standard.bool(forKey: "isAuthorized")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "isAuthorized")
        }
    }
}
