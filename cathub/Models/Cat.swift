//
//  Cat.swift
//  cathub
//
//  Created by  moma on 2019/2/14.
//  Copyright © 2019 yifans. All rights reserved.
//

import SwiftyJSON

class Cat: NSObject {
    var breeds: [Breed]?
    var categories: [Category]?
    var id: String = ""
    var width: Int = UIScreen.main.bounds.width.int
    var height: Int = .random(between: UIScreen.main.bounds.width.int, and: UIScreen.main.bounds.width.int * 2)
    fileprivate var path: String = ""

    var url: URL? {
        return URL(string: path)
    }

    init(json: JSON) {
        id = json["id"].stringValue
        path = json["url"].stringValue
    }
    
}
 
