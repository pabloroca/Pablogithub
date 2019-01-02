//
//  TrendingServiceRemote.swift
//  Pablogithub
//
//  Created by Pablo Roca on 26/12/2018.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import Foundation
import PR2StudioSwift

struct TrendingServiceRemote: TrendingService {

    func getTrending(completion: @escaping (Result<[Trending]>) -> Void) {
        let arrKeyString = String(data: Data(bytes: aesKey()), encoding: .utf8)
        let url = APIConstants.EPTrending.aesDecryptWithKey(arrKeyString ?? "")

        let trendingTask = PR2NetworkTask(method: "GET", url: url, params: nil, headers: nil, priority: Operation.QueuePriority.normal, pollforUTC: 0) { (success, response) in
            if success && response.result.isSuccess && response.data != nil {
                do {
                    let model = try JSONDecoder().decode([Trending].self, from:
                        response.data!)
                    completion(.success(model))
                } catch {
                    completion(.failure(NSError(domain: "", code: 400, userInfo: nil)))
                }
            } else {
                completion(.failure(NSError(domain: "", code: 400, userInfo: nil)))
            }
        }
        PR2Networking.sharedInstance.addTask(trendingTask)
    }

}
