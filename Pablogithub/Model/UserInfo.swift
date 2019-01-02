//
//  UserInfo.swift
//  Pablogithub
//
//  Created by Pablo Roca on 27/12/2018.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import Foundation

public struct UserInfo: Decodable {
    let login: String
    let avatar_url: String
}

public struct UserInfoResponse: Decodable {
    let items: [UserInfo]
}
