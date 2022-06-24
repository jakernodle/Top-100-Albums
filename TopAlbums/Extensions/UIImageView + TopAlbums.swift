//
//  UIImageView + TopAlbums.swift
//  TopAlbums
//
//  Created by JA Kernodle on 6/23/22.
//

import Foundation
import UIKit

extension UIImageView {
    static func createCustomImageView(rounded: Bool) -> UIImageView {
        let iv = UIImageView()
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        if(rounded){
            iv.layer.cornerRadius = 24
        }
       
        return iv
    }
}
