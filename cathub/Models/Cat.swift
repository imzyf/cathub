//
//  Cat.swift
//  cathub
//
//  Created by  moma on 2019/2/14.
//  Copyright © 2019 yifans. All rights reserved.
//

import IGListKit

class Cat: NSObject {
    var breeds: [Breed]?
    var categories: [Category]?
    var id: String = ""
    fileprivate var path: String = ""

    var url: URL? {
        return URL(string: path)
    }

}

extension Cat: ListDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self === object ? true : self.isEqual(object)
    }
}
