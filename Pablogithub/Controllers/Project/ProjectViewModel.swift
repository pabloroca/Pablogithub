//
//  ProjectViewModel.swift
//  Pablogithub
//
//  Created by Pablo Roca on 27/12/2018.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import UIKit

final class ProjectViewModel {
    var project: Trending!
    var readme: String?
    var userInfo: UserInfo?

    lazy var segmentedControlItems: [UIImage] = {
        guard let imageStar = UIImage(named: "star"), let imageFork = UIImage(named: "repo-forked") else { return []}
        return [
            UIImage.textEmbededImage(image: imageStar, string: "\(project.stars) Stars", color: UIColor.pr2ColorMain, imageAlignment: 0, segFont: UIFont.pr2FontHeader()),
            UIImage.textEmbededImage(image: imageFork, string: "\(project.forks) Forks", color: UIColor.pr2ColorMain, imageAlignment: 0, segFont: UIFont.pr2FontHeader())
        ]
    }()

    func readUserInfoAndReadme(completion: @escaping (Bool) -> Void) {
        let backgroundQueue = DispatchQueue(label: "", attributes: .concurrent)
        let dispatchGroup = DispatchGroup()

        var isError = false

        dispatchGroup.enter()
        backgroundQueue.async { [weak self] in
            guard let self = self else { return }
            ServiceFactory.UserInfoService().getUserInfo(login: self.project.author, completion: { (result) in
                switch result {
                case .success(let value):
                    self.userInfo = value
                case .failure:
                    isError = true
                }
                dispatchGroup.leave()
            })
        }

        dispatchGroup.enter()
        backgroundQueue.async { [weak self] in
            guard let self = self else { return }
            ServiceFactory.ReadmeService().getReadme(login: self.project.author, repository: self.project.name, completion: { (result) in
                switch result {
                case .success(let value):
                    self.readme = value
                case .failure:
                    isError = true
                }
                dispatchGroup.leave()
            })
        }

        dispatchGroup.notify(queue: .main) { 
            if isError {
                return completion(false)
            } else {
                return completion(true)
            }
        }
    }
}
