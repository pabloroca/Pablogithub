//
//  UserInfoServiceRemote.swift
//  Pablogithub
//
//  Created by Pablo Roca on 27/12/2018.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import Foundation
import PR2StudioSwift

struct UserInfoServiceRemote: UserInfoService {

    func getUserInfo(login: String, completion: @escaping (Result<UserInfo>) -> Void) {
        let arrKeyString = String(data: Data(bytes: aesKey()), encoding: .utf8)
        let baseURL = APIConstants.baseURL.aesDecryptWithKey(arrKeyString ?? "")
        let urlParams = APIConstants.EPUserInfo.aesDecryptWithKey(arrKeyString ?? "")
        let token = APIConstants.token.aesDecryptWithKey(arrKeyString ?? "")

        let url = baseURL+String(format: urlParams, login)

        guard let urlEncoded = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }

        let auth = ["Authorization": "Bearer \(token)"]

        let userInfoTask = PR2NetworkTask(method: "GET", url: urlEncoded, params: nil, headers: auth, priority: Operation.QueuePriority.normal, pollforUTC: 0) { (success, response) in
            if success && response.result.isSuccess && response.data != nil {
                do {
                    let model = try JSONDecoder().decode(UserInfoResponse.self, from:
                        response.data!)
                    if let result = model.items.first {
                        completion(.success(result))
                    } else {
                        completion(.failure(NSError(domain: "", code: 400, userInfo: nil)))
                    }
                } catch {
                    completion(.failure(NSError(domain: "", code: 400, userInfo: nil)))
                }
            } else {
                completion(.failure(NSError(domain: "", code: 400, userInfo: nil)))
            }
        }
        PR2Networking.sharedInstance.addTask(userInfoTask)
    }
}
