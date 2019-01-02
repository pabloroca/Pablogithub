//
//  DebugConstants.swift
//  Pablogithub
//
//  Created by Pablo Roca on 31/12/2018.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import Foundation

struct ServiceFactory {

    static func TrendingService() -> TrendingService {
        #if STUBS
        return TrendingServiceStubs()
        #else
        return TrendingServiceRemote()
        #endif
    }

    static func UserInfoService() -> UserInfoService {
        #if STUBS
        return UserInfoServiceStubs()
        #else
        return UserInfoServiceRemote()
        #endif
    }

    static func ReadmeService() -> ReadmeService {
        #if STUBS
        return ReadmeServiceStubs()
        #else
        return ReadmeServiceRemote()
        #endif
    }

}
