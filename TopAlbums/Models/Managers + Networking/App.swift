//
//  App.swift
//  TopAlbums
//
//  Created by JA Kernodle on 6/23/22.
//

import Foundation

class App {
    static let shared = App()

    var albums: [Album]? {
        didSet {
            if let data = try? PropertyListEncoder().encode(albums) {
                UserDefaults.standard.set(data, forKey: "SavedAlbumData")
            }
        }
    }
    
    func setAlbums(albums: [Album]){
        self.albums = albums
    }
}
