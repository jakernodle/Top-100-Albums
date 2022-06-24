//
//  AlbumCollectionViewCell.swift
//  TopAlbums
//
//  Created by JA Kernodle on 6/22/22.
//

import Foundation
import UIKit
import Kingfisher
import Alamofire

class CustomCell: UICollectionViewCell {
    
    var albumData: Album? {
        didSet {
            guard let data = albumData else { return }
            
            if let url = URL(string: data.backgroundImageURL) {
                albumImgView.kf.indicatorType = .activity
                albumImgView.kf.setImage(with: url,
                               placeholder: UIImage(named: "No-image-found"),
                               options: [.transition(.fade(0.2))])
            }
            
            albumImgView.backgroundColor = .blue
            albumTitle.text = data.albumTitle
            artistTitle.text = data.artistTitle
        }
    }
    
    let albumImgView = UIImageView.createCustomImageView(rounded: true)
    let albumTitle = UILabel.createCustomLabel(bold: true, fontSize: 20, dropShadow: true, numberOfLines: 2, color: .white)
    let artistTitle = UILabel.createCustomLabel(bold: false, fontSize: 16, dropShadow: true, numberOfLines: 1, color: .white)

    
    override init(frame: CGRect) {
        super.init(frame: .zero)

        contentView.addSubview(albumImgView)
        contentView.addSubview(albumTitle)
        contentView.addSubview(artistTitle)

        albumImgView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        albumImgView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        albumImgView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        albumImgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        artistTitle.heightAnchor.constraint(equalToConstant: 16).isActive = true
        artistTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        artistTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        artistTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        albumTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        albumTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        albumTitle.bottomAnchor.constraint(equalTo: artistTitle.topAnchor, constant: -4).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
