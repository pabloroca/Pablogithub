//
//  UserInfoServiceStubs.swift
//  Pablogithub
//
//  Created by Pablo Roca on 02/01/2019.
//  Copyright © 2019 PR2Studio. All rights reserved.
//

import Foundation
import PR2StudioSwift

private let defaultDataBundle = "Stubs"

struct UserInfoServiceStubs: UserInfoService {

    // MARK: - Properties

    var dataBundle: Bundle = {
        let bundle = Bundle(url: Bundle(for: AppDelegate.self).url(forResource: defaultDataBundle, withExtension: "bundle")!)!
        return bundle
    }()
    
    func getUserInfo(login: String, completion: @escaping (Result<UserInfo>) -> Void) {
        ParseToCodableType.asynchronous(toType: UserInfo.self, key: "\(#function)".components(separatedBy: "(")[0], bundle: dataBundle) { result in
            completion(result)
        }
    }

}
