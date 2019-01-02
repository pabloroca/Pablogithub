//
//  UserInfoService.swift
//  Pablogithub
//
//  Created by Pablo Roca on 27/12/2018.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import Foundation
import PR2StudioSwift

public protocol UserInfoService {

    func getUserInfo(login: String, completion: @escaping (Result<UserInfo>) -> Void)

}
