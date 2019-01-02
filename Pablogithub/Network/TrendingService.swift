//
//  TrendingService.swift
//  Pablogithub
//
//  Created by Pablo Roca on 26/12/2018.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import Foundation
import PR2StudioSwift

public protocol TrendingService {

    func getTrending(completion: @escaping (Result<[Trending]>) -> Void)

}
