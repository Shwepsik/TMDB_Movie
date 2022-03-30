//
//  TvShowDetailsViewModel.swift
//  tmdb-mvvm-pure
//
//  Created by Valerii Biliarchyk on 29.03.2022.
//  Copyright © 2022 tailec. All rights reserved.
//

import RxSwift
import RxCocoa

final class TvShowDetailsViewModel: ViewModelType {
    struct Input {
        let ready: Driver<Void>
        let backTrigger: Driver<Void>
    }
    
    struct Output {
        let data: Driver<TvShowDetailsData?> // nil means TMDB API errored out
        let back: Driver<Void>
    }
    
    struct Dependencies {
        let id: Int
        let api: TMDBApiProvider
        let navigator: TvShowDetailsNavigatable
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func transform(input: TvShowDetailsViewModel.Input) -> TvShowDetailsViewModel.Output {
        let data = input.ready
            .asObservable()
            .flatMap { _ in
                self.dependencies.api.fetchShowDetails(forShowId: self.dependencies.id)
            }
            .map { show -> TvShowDetailsData? in
                guard let show = show else { return nil }
                return TvShowDetailsData(show: show)
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

struct TvShowDetailsData {
    let name: String
    let posterUrl: String
    let releaseDate: String
}

extension TvShowDetailsData {
    init(show: Show) {
        self.name = show.name
        self.posterUrl = "http://image.tmdb.org/t/p/w780/" + show.posterUrl
        self.releaseDate = show.releaseDate
    }
}
