//
//  SearchViewModel.swift
//  cathub
//
//  Created by  moma on 2019/2/21.
//  Copyright © 2019 yifans. All rights reserved.
//

import Foundation
import RxSwift

protocol HomeViewModelType {
    var inputs: HomeViewModelInput { get }
    var outputs: HomeViewModelOutput { get }
}

protocol HomeViewModelInput {
    
    /// Call when the bottom of the list is reached
    var loadMore: BehaviorSubject<Bool> { get }
 
    /// Call when pull-to-refresh is invoked
    func refresh()
}

protocol HomeViewModelOutput {
    
    /// Emits an array of photos for the collectionView
    var cats: Observable<[Cat]>! { get }
    
    /// Emits a boolean when the pull-to-refresh control is refreshing or not.
    var isRefreshing: Observable<Bool>! { get }
    
    /// Emites the child viewModels
    var homeViewCellModelTypes: Observable<[HomeViewCellModelType]> { get }
}

class HomeViewModel: HomeViewModelType, HomeViewModelInput, HomeViewModelOutput {
 
    // MARK: Inputs & Outputs
    var inputs: HomeViewModelInput { return self }
    var outputs: HomeViewModelOutput { return self }
    
    private let refreshProperty = BehaviorSubject<Bool>(value: true)
 
    // MARK: Output
    var cats: Observable<[Cat]>!
    var isRefreshing: Observable<Bool>!
    var homeViewCellModelTypes: Observable<[HomeViewCellModelType]> {
        return cats.map { cats -> [Cat] in
            return cats
        }
            .mapMany { HomeViewCellModel(cat: $0) }
    }
 
    init() {
        var currentPageNumber = 1
        var catArray = [Cat]()
 
        isRefreshing = refreshProperty.asObservable()
        isRefreshing.subscribe { event in
            print(event)
        }
  
        let requestFirst = isRefreshing
            .flatMapLatest { isRefreshing -> Observable<[Cat]> in
                guard isRefreshing else { return .empty() }
                return Api.shared.imagesSearch()
                    .flatMap { [unowned self] result -> Observable<[Cat]> in
                        switch result {
                        case let .success(cats):
                            return .just(cats)
                        case let .error(error):
                            self.refreshProperty.onNext(false)
                            return .empty()
                        }
                    }
            }
            .do (onNext: { _ in
                catArray = []
                currentPageNumber = 1
            })
  
        cats = requestFirst
            .map { [unowned self] cats -> [Cat] in
                cats.forEach { cat in
                    catArray.append(cat)
                }
                self.refreshProperty.onNext(false)
                return catArray
            }
    }
}

extension HomeViewModel {
    var loadMore: BehaviorSubject<Bool> {
        return BehaviorSubject<Bool>(value: false)
    }
    
    func refresh() {
        refreshProperty.onNext(true)
    }
}
