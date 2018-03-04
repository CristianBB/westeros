//
//  Episode.swift
//  Westeros
//
//  Created by Cristian Blazquez Bustos on 2/3/18.
//  Copyright © 2018 Cbb. All rights reserved.
//

import Foundation

final class Episode {
    let title: String
    let broadcastDate: Date
    weak var season: Season?
    let synopsis: String
 
    init(title: String, broadcastDate: Date, season: Season, synopsis: String) {
        self.title = title
        self.broadcastDate = broadcastDate
        self.season = season
        self.synopsis = synopsis
        
        // Añade episodio a la temporada
        self.season?.add(episode: self)
    }
}

// MARK: Proxies
extension Episode {
    var proxyForEquality: String {
        return "\(title) \(broadcastDate)"
    }
    
}

// MARK: - CustomStringConvertible
extension Episode: CustomStringConvertible {
    var description: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        let strBroadcastDate = dateFormatter.string(from: broadcastDate)
        
        return "Title: \(title), Season:\(season?.name ?? ""), Broadcast Date:\(strBroadcastDate), synopsis:\(synopsis)"

    }
    
    
}

// MARK: - Equatable
extension Episode: Equatable {
    static func ==(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
    
    
}

// MARK: - Hashable
extension Episode: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
    
    
}

// MARK: - Comparable
extension Episode: Comparable {
    
    // La comparación de objetos de tipo Episode se realizará mediante su broadcastDate (para ordenación por fecha de emisión)
    static func <(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.broadcastDate < rhs.broadcastDate
    }
    
    
}


