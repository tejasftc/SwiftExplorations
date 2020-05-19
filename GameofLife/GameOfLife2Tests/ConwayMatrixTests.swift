//
//  ConwayMatrixTests.swift
//  GameofLife2
//
//  Created by Tejas Thiyagarajan on 5/18/20.
//  Copyright © 2020 Tejas Thiyagarajan. All rights reserved.
//

import XCTest

class ConwayMatrixTests: XCTestCase, BoardDrawDelegate {
    var screenChange: [(Int, Int, Bool)] = []
    func displayCells(r: Int, c: Int, state: Bool) {
        screenChange.append(contentsOf: [(r,c,state)])
    }
    

//    override init() {
//        super.init()
//    }
//    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBlinker() throws {
        
        var cm = ConwayMatrix(rows:3, cols: 3, onCells: [(1,0),(1,1),(1,2)])
        cm.computeNextStep()
        cm.displayBoard(drawBoard: self)
        
//        assert(screenChange[0].0 == 0)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
