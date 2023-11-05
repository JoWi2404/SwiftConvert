//
//  API.swift
//  Custom_TabBar
//
//  Created by Joey Wiryawan on 16/05/23.
//

import Foundation
import Alamofire

struct API: Codable {
    var success: Bool
    var base: String
    var date: String
    var rates = [String: Double]()
}

func apiRequest(url: String, completion: @escaping (API) -> ()) {
    Session.default.request(url).responseDecodable(of: API.self) { response in
        switch response.result {
        case .success(let currency):
            print(currency)
            completion(currency)
        case .failure(let error):
            print(error)
        }
    }
}
