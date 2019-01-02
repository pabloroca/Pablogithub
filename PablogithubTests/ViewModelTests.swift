//
//  TrendingViewModel.swift
//  PablogithubTests
//
//  Created by Pablo Roca on 02/01/2019.
//  Copyright © 2019 PR2Studio. All rights reserved.
//

import XCTest

class ViewModelTests: XCTestCase {
    var trendingViewModel: TrendingListViewModel!
    var projectViewModel: ProjectViewModel!

    override func setUp() {
        trendingViewModel = TrendingListViewModel()
        projectViewModel = ProjectViewModel()
    }

    override func tearDown() {
        trendingViewModel = nil
        projectViewModel = nil
    }

    func testTrendingViewModel() {
        let expectation = self.expectation(description: "\(#function)")

        trendingViewModel.readTrending { (success) in
            XCTAssertTrue(success)
            XCTAssertTrue(!self.trendingViewModel.rows.isEmpty)
            self.trendingViewModel.filterRows(with: "able")
            XCTAssertTrue(!self.trendingViewModel.rows.isEmpty)
            expectation.fulfill()
        }

        let result = XCTWaiter().wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(result, .completed)
    }

    func testProjectViewModel() {
        let expectation = self.expectation(description: "\(#function)")

        testTrendingViewModel()
        projectViewModel.project = trendingViewModel.rows[0]

        projectViewModel.readUserInfoAndReadme { (success) in
            XCTAssertTrue(success)
            XCTAssertNotNil(self.projectViewModel.userInfo)
            XCTAssertNotNil(self.projectViewModel.project)
            expectation.fulfill()
        }
        let result = XCTWaiter().wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(result, .completed)
    }

}
