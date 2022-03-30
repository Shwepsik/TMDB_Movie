//
//  PeopleDetailsViewController.swift
//  tmdb-mvvm-pure
//
//  Created by Valerii Biliarchyk on 26.03.2022.
//  Copyright © 2022 tailec. All rights reserved.
//

import RxSwift
import RxCocoa

final class PeopleDetailsViewController: UIViewController {
    var viewModel: PeopleDetailsViewModel!
    
    @IBOutlet private weak var peopleDetailsView: PeopleDetailsView!
    @IBOutlet private weak var backButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func bindViewModel() {
        let input = PeopleDetailsViewModel.Input(
            ready: rx.viewWillAppear.asDriver(),
            backTrigger: backButton.rx.tap.asDriver()
        )
        
        let output = viewModel.transform(input: input)
        
        output.data
            .drive(onNext: { [weak self] data in
                guard let data = data,
                    let strongSelf = self else { return }
                strongSelf.peopleDetailsView.configure(with: data)
            })
            .disposed(by: disposeBag)
        
        output.back
            .drive()
            .disposed(by: disposeBag)
    }
}
