//
//  TvShowDetailsView.swift
//  tmdb-mvvm-pure
//
//  Created by Valerii Biliarchyk on 30.03.2022.
//  Copyright © 2022 tailec. All rights reserved.
//

import Nuke

final class TvShowDetailsView: UIView {
    @IBOutlet private weak var showNameLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        Bundle.main.loadNibNamed("TvShowDetailsView", owner: self, options: nil)
        addSubview(contentView)
        
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        posterImageView.layer.cornerRadius = 8
    }
}

extension TvShowDetailsView {
    func configure(with data: TvShowDetailsData) {
        showNameLabel.text = data.name
        releaseDateLabel.text = data.releaseDate
        Nuke.loadImage(with: URL(string: data.posterUrl)!, into: posterImageView)
    }
}

