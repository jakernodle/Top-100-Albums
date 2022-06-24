//
//  AlbumDetailViewController.swift
//  TopAlbums
//
//  Created by JA Kernodle on 6/22/22.
//

import Foundation
import UIKit
import Kingfisher

class AlbumDetailViewController: UIViewController {
    
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
            releaseDateRaw = data.releaseDate
            visitURL = data.urlString
            genres = data.genres
        }
    }
    
    var genres: [Genre] = []
    var genreDict: [String: String] = [:] //simple dict to get URL from genre title
    
    let albumImgView = UIImageView.createCustomImageView(rounded: false)
    let artistTitle = UILabel.createCustomLabel(bold: false, fontSize: 22, dropShadow: false, numberOfLines: 1, color: .gray)
    let albumTitle = UILabel.createCustomLabel(bold: true, fontSize: 42, dropShadow: false, numberOfLines: 1, color: .black)
    let copyrightLabel = UILabel.createCustomLabel(bold: false, fontSize: 14, dropShadow: false, numberOfLines: 1, color: .gray)
    var releaseDateRaw = ""
    let releaseDateLabel = UILabel.createCustomLabel(bold: false, fontSize: 14, dropShadow: false, numberOfLines: 1, color: .gray)
    
    let genreScroller: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()
    
    var visitURL = ""
    let visitButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 155, height: 45)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Visit The Album", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(visitURLAction), for: .touchUpInside)
        return button
    }()
    
    let customBackButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.backgroundColor = .lightGray
        button.setImage(UIImage(named: "chevron.left"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(popView), for: .touchUpInside)
        return button
    }()
        
    @objc func visitURLAction(sender: UIButton!) {
        if let url = URL(string: visitURL), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func popView(sender: UIButton!) {
        print("here")
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        //hide navback button for custom back button
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        self.view.addSubview(customBackButton)
        self.view.addSubview(albumImgView)
        self.view.addSubview(artistTitle)
        self.view.addSubview(albumTitle)
        self.view.addSubview(visitButton)
        self.view.addSubview(copyrightLabel)
        self.view.addSubview(releaseDateLabel)
        self.view.addSubview(genreScroller)
        self.view.addSubview(customBackButton)

        if (!UIDevice.current.hasNotch) { //position the custom back button differently if its an older device
            customBackButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        }else{
            customBackButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        }
        customBackButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        customBackButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        customBackButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        albumImgView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        albumImgView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        albumImgView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        albumImgView.heightAnchor.constraint(equalToConstant: view.bounds.size.width).isActive = true
        
        artistTitle.topAnchor.constraint(equalTo: albumImgView.bottomAnchor, constant: 10).isActive = true
        artistTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        artistTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        artistTitle.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        albumTitle.topAnchor.constraint(equalTo: artistTitle.bottomAnchor, constant: 6).isActive = true
        albumTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        albumTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        albumTitle.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        visitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        visitButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        visitButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        visitButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        copyrightLabel.text = "Copyright © 2022 Apple Inc. All rights reserved."
        copyrightLabel.textAlignment = .center
        
        copyrightLabel.bottomAnchor.constraint(equalTo: visitButton.topAnchor, constant: -10).isActive = true
        copyrightLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        copyrightLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        copyrightLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        releaseDateLabel.textAlignment = .center
        releaseDateLabel.bottomAnchor.constraint(equalTo: copyrightLabel.topAnchor, constant: -4).isActive = true
        releaseDateLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        releaseDateLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        releaseDateLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        genreScroller.topAnchor.constraint(equalTo: albumTitle.bottomAnchor, constant: 12).isActive = true
        genreScroller.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        genreScroller.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        genreScroller.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //parse date string
        releaseDateLabel.text = parseReleaseDateString(dateString: releaseDateRaw)
        
        //configure genre scroller
        configureGenres(genres: genres)

    }
    
    func parseReleaseDateString(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateString) else{ return ""}
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "MMM dd yyyy"

        return "Rleased \(convertDateFormatter.string(from: date))"
        
    }
    
    func configureGenres(genres: [Genre]) {
        var x = 10
        for genre in genres {
            let button = UIButton(frame: CGRect(x: x, y: 0, width: 80, height: 20))
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 2
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.minimumScaleFactor = 0.01
            button.layer.borderColor = UIColor.blue.cgColor
            button.backgroundColor = .white
            button.setTitleColor(.blue, for: .normal)
            button.setTitle(genre.name, for: .normal)
            button.addTarget(self, action: #selector(visitGenreURLAction), for: .touchUpInside)
            genreDict[genre.name] = genre.url
            genreScroller.addSubview(button)
            genreScroller.contentSize = CGSize(width: x + 120, height: 20)
            x = Int(button.frame.origin.x + button.bounds.width) + 10
        }
    }
    
    @objc func visitGenreURLAction(sender: UIButton!) {
        guard let title = sender.titleLabel?.text else {return}
        guard let urlString = genreDict[title] else {return}
        
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
