//
//  RecentSearchTest.swift
//  ItunesSearch
//
//  Created by RAJESH SUKUMARAN on 10/17/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import MusicMojoLyrica

class RecentSearchTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let recentsM = RecentSearchManager.sharedInstance
        //recentsM.clearPreference()
        //recentsM.addPrefernce(search: "Rajesh")
        //recentsM.addPrefernce(search: "Dave")
        recentsM.addPrefernce(search: "Chitra")
        let recents = recentsM.readPreference()
        XCTAssertEqual(recents.first, "Chitra")
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
