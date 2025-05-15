//
//  Movie.swift
//  Cinema2
//
//  Created by BeeCon on 13/5/25.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let title: String
    let release_date: String
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id, title, release_date
        case posterPath = "poster_path"
    }
}


