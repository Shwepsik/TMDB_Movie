//
//  PeopleDetailsViewModel.swift
//  tmdb-mvvm-pure
//
//  Created by Valerii Biliarchyk on 26.03.2022.
//  Copyright © 2022 tailec. All rights reserved.
//

import RxSwift
import RxCocoa

final class PeopleDetailsViewModel: ViewModelType {
    struct Input {
        let ready: Driver<Void>
        let backTrigger: Driver<Void>
    }
    
    struct Output {
        let data: Driver<PeopleDetailsData?> // nil means TMDB API errored out
        let back: Driver<Void>
    }
    
    struct Dependencies {
        let name: String
        let prifileUrl: String
        let navigator: PeopleDetailsNavigatable
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func transform(input: PeopleDetailsViewModel.Input) -> PeopleDetailsViewModel.Output {
        let data = input.ready
            .asObservable()
            .map { [weak self] _ -> PeopleDetailsData? in
                guard let strongSelf = self else { return nil }
                return PeopleDetailsData(name: strongSelf.dependencies.name, profileUrl: strongSelf.dependencies.prifileUrl)
            }
            .asDriver(onErrorJustReturn: nil)
        
        let back = input.backTrigger
            .do(onNext: { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.dependencies.navigator.goBack()
                
            })
        
        return Output(data: data, back: back)
    }
}

struct PeopleDetailsData {
    let name: String
    let profileUrl: String
    
    init(name: String, profileUrl: String) {
        self.name = name
        self.profileUrl = "http://image.tmdb.org/t/p/w780" + profileUrl
    }
}
