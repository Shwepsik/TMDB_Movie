//
//  PeopleDetailsView.swift
//  tmdb-mvvm-pure
//
//  Created by Valerii Biliarchyk on 29.03.2022.
//  Copyright © 2022 tailec. All rights reserved.
//

import Nuke

final class PeopleDetailsView: UIView {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var profileImageView: UIImageView!
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
        Bundle.main.loadNibNamed("PeopleDetailsView", owner: self, options: nil)
        addSubview(contentView)
        
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        profileImageView.layer.cornerRadius = 8
    }
}

extension PeopleDetailsView {
    func configure(with data: PeopleDetailsData) {
        nameLabel.text = data.name
        Nuke.loadImage(with: URL(string: data.profileUrl)!, into: profileImageView)
    }
}

