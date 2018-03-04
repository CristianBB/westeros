//
//  RepositoryTests.swift
//  WesterosTests
//
//  Created by Cristian Blazquez Bustos on 13/2/18.
//  Copyright © 2018 Cbb. All rights reserved.
//

import XCTest

@testable import Westeros

class RepositoryTests: XCTestCase {
    var localHouses: [House]!
    
    override func setUp() {
        super.setUp()
        
        localHouses = Repository.local.houses
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRepositoryCreation() {
        let repo = Repository.local
        XCTAssertNotNil(repo)
    }
    
    func testLocalRepositoryHousesCreation() {
        XCTAssertNotNil(localHouses)
        XCTAssertEqual(localHouses.count, 4)
    }
    
    func testLocalRepositoryReturnHouseByCaseInsensitive() {
        let stark = Repository.local.house(named: "sTarK")
        XCTAssertEqual(stark?.name, "Stark")
        
        let keepcoding = Repository.local.house(named: "Keepcoding")
        XCTAssertNil(keepcoding)
    }
    
    // Filtrado por nombre usando enumerado
    func testLocalRepositoryReturnHouseByEnum() {
        let stark = Repository.local.house(.Stark)
        XCTAssertEqual(stark?.name, "Stark")
        
    }
    
    func testHouseFiltering() {
        let filtered = Repository.local.houses(filteredBy: { $0.count == 6})
        XCTAssertEqual(filtered.count, 1)
    }
    
}
