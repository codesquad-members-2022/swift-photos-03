//
//  PhotoAlbumUITests.swift
//  PhotoAlbumUITests
//
<<<<<<< HEAD
//  Created by Jihee hwang on 2022/03/21.
=======
//  Created by 김동준 on 2022/03/21.
>>>>>>> d6975c8254075a9831349eefd791db367b3f9909
//

import XCTest

class PhotoAlbumUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

<<<<<<< HEAD
=======
        // Use recording to get started writing UI tests.
>>>>>>> d6975c8254075a9831349eefd791db367b3f9909
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
