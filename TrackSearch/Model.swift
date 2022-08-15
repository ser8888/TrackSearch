//
//  Model.swift
//  TrackSearch
//
//  Created by John Doe on 13/08/2022.
//
struct Reply: Decodable {
    
    let resultCount: Int
    let results: [Track]
}

struct Track: Decodable {
    
    let artistName: String
    let trackName: String
//    let trackCensoredName: String
    let artworkUrl60: String?
    let artworkUrl100: String?
//    let collectionPrice: Double
    
}


