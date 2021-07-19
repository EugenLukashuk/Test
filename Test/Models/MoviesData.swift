//
//  MoviesData.swift
//  Test
//
//  Created by Eugen on 16.07.2021.
//

import Foundation

struct MoviesData: Decodable {
    var page: Int?
    var results: [Story]?
}

struct Story: Decodable {
    var adult: Bool?
    var backdropPath: String?
    var id: Int?
    var overview: String?
    var popularity: Double?
    var posterPath: String?
    var releaseDate: String?
    var title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
}
