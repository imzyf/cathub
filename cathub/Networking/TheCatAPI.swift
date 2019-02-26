//
//  TheCatAPI.swift
//  cathub
//
//  Created by  moma on 2019/2/16.
//  Copyright © 2019 yifans. All rights reserved.
//

import Foundation
import Moya

enum TheCatAPI {
    case imagesSearch(size: SizeType, mimeType: MimeType, order: OrderType, limit: Int, page: Int, categoryIds: [Int], breedId: String)
}

extension TheCatAPI: TargetType {
    var baseURL: URL {
        switch self {
        default:
            return Configs.Network.theCatBaseURL
        }
    }
    
    var path: String {
        switch self {
        case .imagesSearch:
            return "/images/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .imagesSearch:
            return .get
        }
    }
    
    var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        default:
            if let parameters = parameters {
                return .requestParameters(parameters: parameters, encoding: parameterEncoding)
            }
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        let headers = ["x-api-key": Keys.theCat.apiKey]
        return headers
    }
    
}

extension TheCatAPI {
    var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        switch self {
        case .imagesSearch(let size, let  mimeType, let order, let limit, let page, let categoryIds, let breedId):
            params["size"] = size.rawValue
            params["mime_types"] = mimeType.type
            params["order"] = order.rawValue
            params["limit"] = limit
            params["page"] = page
            params["category_ids"] = categoryIds
            params["breed_id"] = breedId
        }
        return params
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .imagesSearch:
            return URLEncoding.default
        }
    }
}
