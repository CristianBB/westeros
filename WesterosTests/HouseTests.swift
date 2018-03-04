//
//  HouseTests.swift
//  WesterosTests
//
//  Created by Cristian Blazquez Bustos on 8/2/18.
//  Copyright © 2018 Cbb. All rights reserved.
//

import XCTest
@testable import Westeros

class HouseTests: XCTestCase {
    var starkSigil: Sigil!
    var lannisterSigil: Sigil!
    
    var starkHouse: House!
    var lannisterHouse: House!
    
    var robb: Person!
    var arya: Person!
    var tyrion: Person!
    var cersei: Person!
    var jaime: Person!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        starkSigil = Sigil(image: UIImage(), description: "DireWolf")
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: URL(string: "http://awoiaf.westeros.org/index.php/House_Stark")!)
        robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        arya = Person(name: "Arya", house: starkHouse)
        
        lannisterSigil = Sigil(image: UIImage(), description: "Lion")
        lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rudigo", url: URL(string: "http://awoiaf.westeros.org/index.php/House_Lannister")!)
        tyrion = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse)
        cersei = Person(name: "Cersei", house: lannisterHouse)
        jaime = Person(name: "Jaime", alias: "El Matarreyes", house: lannisterHouse)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // Comprueba la existencia de la Clase House
    func testHouseExistence() {
        XCTAssertNotNil(starkHouse)
    }
    
    // Comprueba la existencia de la Clase Sigil
    func testSigilExistence() {
        XCTAssertNotNil(starkSigil)
        XCTAssertNotNil(lannisterSigil)
    }
    
    //Valida la creacion de nuevas Personas
    func testAddPersons() {
        
        // Ahora los miembros se agregan automaticamente al asignarle una Casa a la clase Person, por lo que en este punto ya hay 2 miembros en starkHouse
        XCTAssertEqual(starkHouse.count, 2)
        
        starkHouse.add(person: arya)
        XCTAssertEqual(starkHouse.count, 2)
        
        starkHouse.add(person: tyrion)
        XCTAssertEqual(starkHouse.count, 2, "No debería agregarse un miembro de una casa distinta")
        
        // En lannisterHouse ya hay 3 miembros, no deberia agregarse ninguno mas que ya exista
        lannisterHouse.add(persons: tyrion, cersei)
        XCTAssertEqual(lannisterHouse.count, 3)
    }
    
    func testHouseEquality() {
        // Comprueba Identidad
        XCTAssertEqual(starkHouse, starkHouse)
        
        // Comprueba Igualdad
        let starkHouse2 = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: URL(string: "http://awoiaf.westeros.org/index.php/House_Stark")!)
        robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse2)
        arya = Person(name: "Arya", house: starkHouse2)

        XCTAssertEqual(starkHouse2, starkHouse)
        
        // Comprueba Desigualdad
        XCTAssertNotEqual(starkHouse, lannisterHouse)
    }
    
    func testHashable() {
        XCTAssertNotNil(starkHouse.hashValue)
    }
    
    func testHouseComparison() {
        XCTAssertLessThan(lannisterHouse, starkHouse)
    }
    
    func testHouseReturnsSortedArrayOfMembers() {
        starkHouse.add(persons: robb, arya)
        XCTAssertEqual(starkHouse.sortedMembers, [arya, robb])
    }
    
}

