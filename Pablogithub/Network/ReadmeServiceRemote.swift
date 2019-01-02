//
//  ReadmeServiceRemote.swift
//  Pablogithub
//
//  Created by Pablo Roca on 27/12/2018.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import Foundation
import PR2StudioSwift

struct ReadmeServiceRemote: ReadmeService {

    func getReadme(login: String, repository: String, completion: @escaping (Result<String>) -> Void) {
        let arrKeyString = String(data: Data(bytes: aesKey()), encoding: .utf8)
        let urlParams = APIConstants.EPReadme.aesDecryptWithKey(arrKeyString ?? "")

        guard let url = URL(string: String(format: urlParams, login, repository)) else {
            completion(.failure(NSError(domain: "", code: 400, userInfo: nil)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                if let readmeContent  = String(data: data!, encoding: String.Encoding.utf8) {
                    completion(.success(readmeContent))
                } else {
                    completion(.failure(NSError(domain: "", code: 400, userInfo: nil)))
                }
            } else {
                completion(.failure(NSError(domain: "", code: 400, userInfo: nil)))
            }
        }

        task.resume()
    }

}
