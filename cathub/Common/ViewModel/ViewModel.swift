//
//  ViewModel.swift
//  cathub
//
//  Created by  moma on 2019/2/21.
//  Copyright © 2019 yifans. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ViewModel: NSObject {
    
    let provider: HubApi
    
    var page = 1
 
    init(provider: HubApi) {
        self.provider = provider
        super.init()
    }
    
    deinit {
//        logDebug("\(type(of: self)): Deinited")
    }
}
