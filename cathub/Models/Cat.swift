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
    var width: Int = 0
    var height: Int = 0
    fileprivate var path: String = ""

    var url: URL? {
        return URL(string: path)
    }

    init(json: JSON) {
        id = json["id"].stringValue
        path = json["url"].stringValue
        
        width = 2000
        height = .random(between: 1000, and: 2000)
    }
    
}
 
