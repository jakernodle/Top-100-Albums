//
//  UILabel + TopAlbums.swift
//  TopAlbums
//
//  Created by JA Kernodle on 6/23/22.
//

import Foundation
import UIKit

extension UILabel {
    func textDropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
    }

    static func createCustomLabel(bold: Bool, fontSize: CGFloat, dropShadow: Bool, numberOfLines: Int, color: UIColor) -> UILabel {
        let label = UILabel()
       
        label.translatesAutoresizingMaskIntoConstraints = false
        if(bold){
            label.font = UIFont.boldSystemFont(ofSize: fontSize)
        }else{
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
        label.textColor = color
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = numberOfLines
        if(dropShadow){
            label.textDropShadow()
        }
        
        return label
    }
}
