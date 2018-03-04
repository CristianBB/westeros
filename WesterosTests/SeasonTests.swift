//
//  SeasonTests.swift
//  WesterosTests
//
//  Created by Cristian Blazquez Bustos on 3/3/18.
//  Copyright © 2018 Cbb. All rights reserved.
//

import XCTest

@testable import Westeros

class SeasonTests: XCTestCase {
    
    var season1: Season!
    var season2: Season!
    
    override func setUp() {
        super.setUp()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        // Instancias de Season
        season1 = Season(name: "Temporada 1", releaseDate: dateFormatter.date(from: "2011-04-17")!)
        season2 = Season(name: "Temporada 2", releaseDate: dateFormatter.date(from: "2012-04-01")!)
    
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // Comprueba la existencia de la Clase Season
    func testSeasonExistence() {
        XCTAssertNotNil(season1)
    }
    
    func testSeasonEquality() {
        // Comprueba Identidad
        XCTAssertEqual(season1, season1)
        
        // Comprueba Igualdad
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let season1clon = Season(name: "Temporada 1", releaseDate: dateFormatter.date(from: "2011-04-17")!)
        XCTAssertEqual(season1, season1clon)
        
        // Comprueba Desigualdad
        XCTAssertNotEqual(season1, season2)
    }
    
    func testHashable() {
        XCTAssertNotNil(season1.hashValue)
    }
    
    func testSeasonComparison() {
        XCTAssertLessThan(season1, season2)
    }
    
    func testSeasonReturnsSortedArrayOfEpisodes() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Instancias de Episode
        let episode2 = Episode(title: "El Camino Real", broadcastDate: dateFormatter.date(from: "2011-04-24")!, season: season1, synopsis: "Tras aceptar su nuevo rol como Mano del Rey, Ned parte hacia Desembarco del Rey con sus hijas Sansa y Arya, mientras que el hijo mayor, Robb, se queda al frente de los asuntos de su padre en la ciudad. Jon Nieve, el hijo bastardo de Ned, se dirige al Muro para unirse a la Guardia de la Noche. Tyrion Lannister, el hermano menor de la Reina, decide no ir con el resto de la familia real al sur y acompaña a Jon en su viaje al Muro. Viserys sigue esperando su momento de ganar el Trono de Hierro y Daenerys centra su atención en aprender cómo gustarle a su nuevo esposo, Drogo.")
        
        let episode1 = Episode(title: "Se acerca el invierno", broadcastDate: dateFormatter.date(from: "2011-04-17")!, season: season1, synopsis: "El rey Robert Baratheon de Poniente viaja al Norte para ofrecerle a su viejo amigo Eddard Stark, Guardián del Norte y Señor de Invernalia, el puesto de Mano del Rey. La esposa de Ned, Catelyn, recibe una carta de su hermana Lysa que implica a miembros de la familia Lannister, la familia de la reina Cersei, en el asesinato de su marido Jon Arryn, la anterior Mano del Rey. Bran, uno de los hijos de Ned y Catelyn, escala un muro y descubre a la reina Cersei y a su hermano Jaime teniendo relaciones sexuales, Jaime empuja al pequeño Bran esperando que la caída lo mate y así evitar ser delatado por el niño. Mientras tanto, al otro lado del mar Angosto, el príncipe exiliado Viserys Targaryen forja una alianza para recuperar el Trono de Hierro: dará a su hermana Daenerys en matrimonio al salvaje dothraki Khal Drogo a cambio de su ejército. El caballero exiliado Jorah Mormont se unirá a ellos para proteger a Daenerys.")
        
        XCTAssertEqual(season1.sortedEpisodes, [episode1, episode2])
    }
    
}
