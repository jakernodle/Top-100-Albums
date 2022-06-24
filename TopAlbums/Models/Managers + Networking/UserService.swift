//
//  UserService.swift
//  TopAlbums
//
//  Created by JA Kernodle on 6/23/22.
//

import Foundation
import UIKit
import Alamofire


enum ResponseCode: Int {
    case success = 0
    case successFromStoredData = 1
    case failure = 2
}

class UserService {
    func fetchAlbums(completion: @escaping (ResponseCode) -> Void ){
        let request = AF.request("https://rss.applemarketingtools.com/api/v2/us/music/most-played/50/albums.json")
        request.responseDecodable(of: Root.self) { (response) in
            switch response.result {
            case .success:
                guard let root = response.value else { return }
                App.shared.setAlbums(albums: root.data?.all ?? [])
                completion(ResponseCode.success)
                
            case .failure:
                if let data = UserDefaults.standard.data(forKey: "SavedAlbumData") {
                    if let albumData = try? PropertyListDecoder().decode([Album].self, from: data) {
                        App.shared.setAlbums(albums: albumData)
                        completion(ResponseCode.successFromStoredData)
                    }
                }else{
                    completion(ResponseCode.failure)
                }
            }
        }
    }
}
