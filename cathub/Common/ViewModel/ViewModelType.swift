//
//  ViewModelType.swift
//  cathub
//
//  Created by  moma on 2019/2/21.
//  Copyright © 2019 yifans. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
