//
//  HomeViewCellModel.swift
//  cathub
//
//  Created by  moma on 2019/2/21.
//  Copyright © 2019 yifans. All rights reserved.
//

import Foundation
import RxSwift

protocol HomeViewCellModelInput {
 
}

protocol HomeViewCellModelOutput {
    var photo: Observable<Cat> { get }
    var photoSize: Observable<(Double, Double)> { get }
    var id: Observable<String> { get }
}

protocol HomeViewCellModelType {
    var inputs: HomeViewCellModelInput { get }
    var outputs: HomeViewCellModelOutput { get }
}

class HomeViewCellModel: HomeViewCellModelType, HomeViewCellModelInput, HomeViewCellModelOutput {
    
    var inputs: HomeViewCellModelInput { return self }
    var outputs: HomeViewCellModelOutput { return self }
    
    // MARK: Outputs
    let photo: Observable<Cat>
    let photoSize: Observable<(Double, Double)>
    var id: Observable<String>
    
    // MARK: Init
    init(
        cat: Cat,
        sceneCoordinator: SceneCoordinatorType = SceneCoordinator.shared
        ) {
        self.photo = Observable.just(cat)
        photoSize = Observable.combineLatest(
            self.photo.map { $0.width }.unwrap().map { Double($0) },
            self.photo.map { $0.height }.unwrap().map { Double($0) }
        )
        id = photo.map { $0.id }
    }
}
