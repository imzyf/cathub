//
//  CollectionViewCell.swift
//  cathub
//
//  Created by  moma on 2019/2/14.
//  Copyright © 2019 yifans. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    func setupUI() {

    }

}
