//
//  SearchSectionController.swift
//  cathub
//
//  Created by  moma on 2019/2/14.
//  Copyright © 2019 yifans. All rights reserved.
//

import IGListKit

final class SearchSectionController: ListSectionController {
        private var object: Cat?

    override init() {
        super.init()
        inset = UIEdgeInsets(horizontal: 16 * 2, vertical: 12 * 2)
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let collectionContext = collectionContext else {
            return .zero
        }
        let width = collectionContext.containerSize.width - inset.horizontal
        return CGSize(width: width, height: width)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext?.dequeueReusableCell(of: SearchCell.self, for: self, at: index) as! SearchCell  
        return cell
    }

    override func didUpdate(to object: Any) {
        self.object = object as? Cat
    }

}
