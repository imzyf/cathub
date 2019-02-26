//
//  EnumDict.swift
//  cathub
//
//  Created by  moma on 2019/2/16.
//  Copyright © 2019 yifans. All rights reserved.
//

import Foundation

enum SizeType: String {
    case full
    case med
    case small
    case thumb
}

enum MimeType {
    case all
    case normal
    case animated
    
    var type: String {
        switch self {
        case .all:
            return "jpg,png,gif"
        case .normal:
            return "jpg,png"
        case .animated:
            return "gif"
        }
    }
}

enum OrderType: String {
    case asc = "ASC"
    case desc = "DESC"
    case random = "RANDOM"
}
