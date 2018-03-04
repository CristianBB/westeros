//
//  CharactersTests.swift
//  WesterosTests
//
//  Created by Cristian Blazquez Bustos on 8/2/18.
//  Copyright © 2018 Cbb. All rights reserved.
//

import XCTest

@testable import Westeros

class PersonTest: XCTestCase {
    
    var starkSigil: Sigil!
    var starkHouse: House!
    var ned: Person!
    var arya: Person!
    var robb: Person!
    
    var lannisterSigil: Sigil!
    var lannisterHouse: House!
    var tyrion: Person!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        starkSigil = Sigil(image: UIImage(), description: "DireWolf")
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: URL(string: "http://awoiaf.westeros.org/index.php/House_Stark")!)
        ned = Person(name: "Eddard", alias: "Ned", house: starkHouse)
        arya = Person(name: "Arya", house: starkHouse)
        robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        
        lannisterSigil = Sigil(image: UIImage(), description: "Lion")
        lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rudigo", url: URL(string: "http://awoiaf.westeros.org/index.php/House_Lannister")!)
        tyrion = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCharacterExistense() {
        XCTAssertNotNil(ned)
        XCTAssertNotNil(arya)
        
    }
    
    func testFullName() {
        XCTAssertEqual(ned.fullName, "Eddard Stark")
    }
    
    func testPersonEquality() {
        // Comprueba identidad
        XCTAssertEqual(tyrion, tyrion)
        
        // Comprueba igualdad con otra persona Tyrion
        let enano = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse)
        XCTAssertEqual(enano, tyrion)
        
        // Comprueba desigualdad
        XCTAssertNotEqual(tyrion, arya)
        
    }
    
    
    
}
