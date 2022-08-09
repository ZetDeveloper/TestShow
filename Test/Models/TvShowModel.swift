//
//  TvShowModel.swift
//  Test
//
//  Created by Jiren on 05/08/22.
//

import Foundation

struct TvShowModel: Identifiable {
    let id = UUID()
    var name: String
    var isFavorite = false
    var poster: String
}



import Foundation

// MARK: - TvShowNetworkModel
struct TvShowNetworkModel: Codable {
    let search: [Search]
    let totalResults, response: String

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

// MARK: - Search
struct Search: Codable {
    let title, year, imdbID: String
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case poster = "Poster"
    }
}
