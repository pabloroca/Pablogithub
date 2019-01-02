//
//  MainCoordinator.swift
//  Pablogithub
//
//  Created by Pablo Roca on 26/12/2018.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import UIKit
import PR2StudioSwift

final class MainCoordinator: Coordinator {
    // MARK: - Properties
    var dependencies: DependencyContainer
    var completed: () -> Void
    private let navigationController: UINavigationController

    init(dependencies: DependencyContainer) {
        self.navigationController = dependencies.navigationController
        self.dependencies = dependencies
        self.completed = {}
    }

    func start() -> UINavigationController {
        let viewModel = TrendingListViewModel()
        let viewController = TrendingListViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
        return navigationController
    }
}
