//
//  TrendingServiceStubs.swift
//  Pablogithub
//
//  Created by Pablo Roca on 28/12/2018.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import Foundation
import PR2StudioSwift

private let defaultDataBundle = "Stubs"

struct TrendingServiceStubs: TrendingService {

    // MARK: - Properties

    var dataBundle: Bundle = {
        let bundle = Bundle(url: Bundle(for: AppDelegate.self).url(forResource: defaultDataBundle, withExtension: "bundle")!)!
        return bundle
    }()

    func getTrending(completion: @escaping (Result<[Trending]>) -> Void) {
        ParseToCodableType.asynchronous(toType: [Trending].self, key: "\(#function)".components(separatedBy: "(")[0], bundle: dataBundle) { result in
            completion(result)
        }
    }
}
