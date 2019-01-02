//
//  TrendingListTests.swift
//  PablogithubTests
//
//  Created by Pablo Roca on 28/12/2018.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import XCTest

class TrendingListTests: XCTestCase {
    var viewModel: TrendingListViewModel!
    var viewController: TrendingListViewController!

    override func setUp() {
        viewModel = TrendingListViewModel()
        viewController = TrendingListViewController(viewModel: viewModel)
    }

    override func tearDown() {
        viewModel = nil
        viewModel = nil
        super.tearDown()
    }

    func testTrendingListViewController() {
        let expectation = self.expectation(description: "\(#function)")

        viewController.viewDidLoad()
        if viewController.title != nil {
            expectation.fulfill()
        }

        let result = XCTWaiter().wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(result, .completed)
    }

}
