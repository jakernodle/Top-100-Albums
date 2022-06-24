//
//  Album.swift
//  TopAlbums
//
//  Created by JA Kernodle on 6/22/22.
//

import UIKit

struct Album: Codable{
    var albumTitle: String
    var artistTitle: String
    var backgroundImageURL: String
    var urlString: String
    var releaseDate: String
    var genres: [Genre]
    
    enum CodingKeys: String, CodingKey {
        case albumTitle = "name"
        case artistTitle = "artistName"
        case backgroundImageURL = "artworkUrl100"
        case urlString = "url"
        case releaseDate = "releaseDate"
        case genres = "genres"
    }
}
