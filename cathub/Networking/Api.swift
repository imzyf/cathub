//
//  Api.swift
//  cathub
//
//  Created by  moma on 2019/2/21.
//  Copyright © 2019 yifans. All rights reserved.
//

import Moya
import RxSwift
import SwiftyJSON

protocol HubApi {
    func imagesSearch(size: SizeType, mimeType: MimeType, order: OrderType, limit: Int, page: Int, categoryIds: [Int], breedId: String) -> Observable<Result<[Cat], String>>
}

class Api {
    
    static let shared = Api()
    
    let provider: MoyaProvider<TheCatAPI>

    private init() {
        provider = MoyaProvider<TheCatAPI>(manager: defaultAlamofireManager, plugins: plugins)
    }
}

extension Api: HubApi {
    
    func imagesSearch(size: SizeType = .thumb, mimeType: MimeType = .normal,
                      order: OrderType = .random,
                      limit: Int = 20, page: Int = 0,
                      categoryIds: [Int] = [], breedId: String = "") -> Observable<Result<[Cat], String>> {
        
        return provider.rx.request(.imagesSearch(size: size, mimeType: mimeType, order: order, limit: limit, page: page, categoryIds: categoryIds, breedId: breedId))
            .map({ response -> [Cat] in
                return JSON(response.data).arrayValue.map { Cat(json: $0) }
            })
            .asObservable()
            .map(Result.success)
            .catchError { _ in
                return .just(.error("Failed"))
            }
    }
}

extension ObservableType where Self.E == Moya.Response {
    
}

extension Api {
//    private func requestArray<T>(_ target: TheCatAPI, type: T.Type) -> Single<[T]> {
//        let actualRequest = provider.rx.request(target)
//        let doo = actualRequest.filterSuccessfulStatusCodes().do(onSuccess: { (response) in
//        }, onError: { (error) in
//        })
//        doo.asObservable().
//    }
}

private var defaultAlamofireManager: Manager {
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
    configuration.timeoutIntervalForRequest = 30
    configuration.timeoutIntervalForResource = 30
    let manager = Manager(configuration: configuration)
    manager.startRequestsImmediately = false
    return manager
}

private var plugins: [PluginType] {
    var plugins: [PluginType] = []
    plugins.append(activityPlugin)
    if Configs.Network.loggingEnabled == true {
        plugins.append(NetworkLoggerPlugin(verbose: true))
    }
    return plugins
}

/// 状态栏网络情况
private let activityPlugin = NetworkActivityPlugin(networkActivityClosure: { changeType, targetType in
    guard targetType.method != .get else {
        return
    }
    switch changeType {
    case .began:
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
    case .ended:
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
})
