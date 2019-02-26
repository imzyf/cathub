//
//  Configs.swift
//  cathub
//
//  Created by  moma on 2019/2/16.
//  Copyright © 2019 yifans. All rights reserved.
//

import Foundation

enum Keys {
    case theCat
    
    var apiKey: String {
        switch self {
        case .theCat:
            return "bd8d91e2-a51a-442d-bb34-7fd644125533"
        }
    }
    
    var uuid: String {
        switch self {
        case .theCat:
            return "upddit"
        }
    }
}

struct Configs {
    struct App {
//        static let theCat
    }
    
    struct Network {
        static let useStaging = false  // set true for tests and generating screenshots with fastlane
        static let loggingEnabled = true
        
        static var theCatBaseURL: URL {
            return URL(string: "https://api.thecatapi.com/v1")!
        }
    }
}
