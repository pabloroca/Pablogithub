//
//  Trending.swift
//  Pablogithub
//
//  Created by Pablo Roca on 26/12/2018.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import Foundation

public struct Trending: Decodable {
    let author: String
    let name: String
    let url: URL
    let description: String
    let stars: Int
    let forks: Int
    let currentPeriodStars: Int
}
