//
//  MovieRespone.swift
//  MovieList
//
//  Created by admin on 05/10/2022.
//

import Foundation
struct MovieRespone: Codable {
    var results: [Movie]

}
struct Movie: Codable {
    let posterPath: String
    let title: String
    let releaseDate : String
    let voteaverage: Float
    let overview: String
        private enum CodingKeys: String, CodingKey {
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case voteaverage = "vote_average"
            case title = "title"
            case overview 
        }
}
