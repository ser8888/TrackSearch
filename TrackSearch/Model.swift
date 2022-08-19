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
//
//    static func getTracks(from value: Any) -> [Track] {
//        guard let reply = value as? [String: Any] else { return [] }
//        guard let results = reply["results"] as? [[String: Any]] else { return [] }
//
//        return results.map { Track(
//            artistName: $0["artistName"] as? String ?? "",
//            trackName: $0["trackName"] as? String ?? "",
//            artworkUrl60: $0["artworkUrl60"] as? String,
//            artworkUrl100: $0["artworkUrl100"] as? String
//        ) }
//
//    }
//}

struct Track: Decodable {
    
    let artistName: String
    let trackName: String
//    let trackCensoredName: String
    let artworkUrl60: String?
    let artworkUrl100: String?
//    let collectionPrice: Double
    
    init(value: [String: Any]) {
        artistName = value["artistName"] as? String ?? ""
        trackName = value["trackName"] as? String ?? ""
        artworkUrl60 = value["artworkUrl60"] as? String ?? ""
        artworkUrl100 = value["artworkUrl100"] as? String ?? ""
    }
    
    static func getTracks(from value: Any) -> [Track] {
        guard let value = value as? [String: Any] else { return [] }
        guard let results = value["results"] as? [[String: Any]] else { return [] }
        return results.compactMap { Track(value: $0)}
    }
    
}


