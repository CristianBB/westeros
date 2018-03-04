//
//  EpisodeTests.swift
//  WesterosTests
//
//  Created by Cristian Blazquez Bustos on 3/3/18.
//  Copyright © 2018 Cbb. All rights reserved.
//

import XCTest

@testable import Westeros

class EpisodeTests: XCTestCase {
    
    var episode1: Episode!
    var episode2: Episode!
    var season1: Season!
    
    override func setUp() {
        super.setUp()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Instancia de Season
        season1 = Season(name: "Temporada 1", releaseDate: dateFormatter.date(from: "2011-04-17")!)
        
        // Instancias de Episode
        episode1 = Episode(title: "Se acerca el invierno", broadcastDate: dateFormatter.date(from: "2011-04-17")!, season: season1, synopsis: "El rey Robert Baratheon de Poniente viaja al Norte para ofrecerle a su viejo amigo Eddard Stark, Guardián del Norte y Señor de Invernalia, el puesto de Mano del Rey. La esposa de Ned, Catelyn, recibe una carta de su hermana Lysa que implica a miembros de la familia Lannister, la familia de la reina Cersei, en el asesinato de su marido Jon Arryn, la anterior Mano del Rey. Bran, uno de los hijos de Ned y Catelyn, escala un muro y descubre a la reina Cersei y a su hermano Jaime teniendo relaciones sexuales, Jaime empuja al pequeño Bran esperando que la caída lo mate y así evitar ser delatado por el niño. Mientras tanto, al otro lado del mar Angosto, el príncipe exiliado Viserys Targaryen forja una alianza para recuperar el Trono de Hierro: dará a su hermana Daenerys en matrimonio al salvaje dothraki Khal Drogo a cambio de su ejército. El caballero exiliado Jorah Mormont se unirá a ellos para proteger a Daenerys.")
        
        episode2 = Episode(title: "El Camino Real", broadcastDate: dateFormatter.date(from: "2011-04-24")!, season: season1, synopsis: "Tras aceptar su nuevo rol como Mano del Rey, Ned parte hacia Desembarco del Rey con sus hijas Sansa y Arya, mientras que el hijo mayor, Robb, se queda al frente de los asuntos de su padre en la ciudad. Jon Nieve, el hijo bastardo de Ned, se dirige al Muro para unirse a la Guardia de la Noche. Tyrion Lannister, el hermano menor de la Reina, decide no ir con el resto de la familia real al sur y acompaña a Jon en su viaje al Muro. Viserys sigue esperando su momento de ganar el Trono de Hierro y Daenerys centra su atención en aprender cómo gustarle a su nuevo esposo, Drogo.")
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEpisodeEquality() {
        // Comprueba Identidad
        XCTAssertEqual(episode1, episode1)
        
        // Comprueba Igualdad
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let episode1clon = Episode(title: "Se acerca el invierno", broadcastDate: dateFormatter.date(from: "2011-04-17")!, season: season1, synopsis: "El rey Robert Baratheon de Poniente viaja al Norte para ofrecerle a su viejo amigo Eddard Stark, Guardián del Norte y Señor de Invernalia, el puesto de Mano del Rey. La esposa de Ned, Catelyn, recibe una carta de su hermana Lysa que implica a miembros de la familia Lannister, la familia de la reina Cersei, en el asesinato de su marido Jon Arryn, la anterior Mano del Rey. Bran, uno de los hijos de Ned y Catelyn, escala un muro y descubre a la reina Cersei y a su hermano Jaime teniendo relaciones sexuales, Jaime empuja al pequeño Bran esperando que la caída lo mate y así evitar ser delatado por el niño. Mientras tanto, al otro lado del mar Angosto, el príncipe exiliado Viserys Targaryen forja una alianza para recuperar el Trono de Hierro: dará a su hermana Daenerys en matrimonio al salvaje dothraki Khal Drogo a cambio de su ejército. El caballero exiliado Jorah Mormont se unirá a ellos para proteger a Daenerys.")
        XCTAssertEqual(episode1, episode1clon)
        
        // Comprueba Desigualdad
        XCTAssertNotEqual(episode1, episode2)
    }
    
    func testHashable() {
        XCTAssertNotNil(episode1.hashValue)
    }
    
    func testEpisodeComparison() {
        XCTAssertLessThan(episode1, episode2)
    }
    
}
