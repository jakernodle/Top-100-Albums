//
//  Rood.swift
//  TopAlbums
//
//  Created by JA Kernodle on 6/23/22.
//

import Foundation

struct Root : Decodable {
    let data : RSSFeed?
    
    enum CodingKeys: String, CodingKey {
      case data = "feed"
    }
}

struct RSSFeed: Decodable {
  let all: [Album]?
  
  enum CodingKeys: String, CodingKey {
    case all = "results"
  }
}
