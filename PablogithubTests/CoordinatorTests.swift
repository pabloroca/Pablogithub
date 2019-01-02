//
//  CoordinatorTests.swift
//  PablogithubTests
//
//  Created by Pablo Roca on 28/12/2018.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import XCTest
//@testable import Pablogithub

class CoordinatorTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testAppCoordinator() {
        let dependencies = DependencyContainer(navigationController: UINavigationController(), keyWindow: UIWindow())

        let appCoordinator = AppCoordinator(dependencies: dependencies)
        let start = appCoordinator.start()
        XCTAssertTrue(type(of: start) == UINavigationController.self)
    }

}
