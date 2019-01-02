//
//  PablogithubUITests.swift
//  PablogithubUITests
//
//  Created by Pablo Roca on 26/12/2018.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import XCTest

private let defaultLongWaitTimeout: TimeInterval = 20.0

class PablogithubUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUp() {
        super.setUp()

        app = XCUIApplication()
        app.launchEnvironment = ["UITest": "enable"]
        continueAfterFailure = false
        XCUIDevice.shared.orientation = .portrait

    }

    func testSuccess() {
        app.launch()

    }

}
