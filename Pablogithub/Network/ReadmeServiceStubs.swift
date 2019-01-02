//
//  ReadmeServiceStubs.swift
//  Pablogithub
//
//  Created by Pablo Roca on 02/01/2019.
//  Copyright © 2019 PR2Studio. All rights reserved.
//

import Foundation
import PR2StudioSwift

private let defaultDataBundle = "Stubs"

struct ReadmeServiceStubs: ReadmeService {

    // MARK: - Properties

    var dataBundle: Bundle = {
        let bundle = Bundle(url: Bundle(for: AppDelegate.self).url(forResource: defaultDataBundle, withExtension: "bundle")!)!
        return bundle
    }()

    func getReadme(login: String, repository: String, completion: @escaping (Result<String>) -> Void) {
        if let filepath = dataBundle.path(forResource: "README", ofType: "") {
            do {
                let contents = try String(contentsOfFile: filepath)
                completion(.success(contents))
            } catch {
                completion(.failure(NSError(domain: "", code: 400, userInfo: nil)))
            }
        } else {
            completion(.failure(NSError(domain: "", code: 400, userInfo: nil)))
        }
    }

}
