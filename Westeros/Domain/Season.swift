//
//  Season.swift
//  Westeros
//
//  Created by Cristian Blazquez Bustos on 2/3/18.
//  Copyright © 2018 Cbb. All rights reserved.
//

import Foundation

typealias Episodes = Set<Episode>

final class Season {
    let name: String
    let releaseDate: Date
    private var _episodes: Episodes
    
    init (name: String, releaseDate: Date) {
        self.name = name
        self.releaseDate = releaseDate
        _episodes = Episodes()
    }
}

extension Season {
    var count: Int {
        return _episodes.count
    }
    
    var sortedEpisodes: [Episode] {
        return _episodes.sorted()
    }
    
    func add(episode: Episode) {
        guard episode.season == self else {
            return
        }
        _episodes.insert(episode)
    }
    
    func add(episodes: Episode...) {
        episodes.forEach { add(episode: $0) }
    }
}

// MARK: Proxies
extension Season {
    var proxyForEquality: String {
        return "\(name) \(releaseDate)"
    }
    
}

// MARK: - CustomStringConvertible
extension Season: CustomStringConvertible {
    var description: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        let stRreleaseDate = dateFormatter.string(from: releaseDate)
        
        return "Season Name:\(name), Release Date:\(stRreleaseDate), Episodes:\(_episodes.count)"
        
    }
    
}

// MARK: - Equatable
extension Season: Equatable {
    static func ==(lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
    
    
}

// MARK: - Hashable
extension Season: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
    
}

// MARK: - Comparable
extension Season: Comparable {
    
    // La comparación de objetos de tipo Season se realizará mediante su releaseDate (para ordenación por fecha de emisión)
    static func <(lhs: Season, rhs: Season) -> Bool {
        return lhs.releaseDate < rhs.releaseDate
    }
    
    
}
