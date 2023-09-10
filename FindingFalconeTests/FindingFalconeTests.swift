//
//  FindingFalconeTests.swift
//  FindingFalconeTests
//
//  Created by Sparsh Singh on 10/09/23.
//

import XCTest

final class FindingFalconeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let expr1 = "expression 1"
        let expr2 = expr1
        XCTAssertEqual(expr1, expr2, "Expressions are equal")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
