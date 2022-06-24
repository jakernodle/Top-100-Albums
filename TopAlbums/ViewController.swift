//
//  ViewController.swift
//  TopAlbums
//
//  Created by JA Kernodle on 6/22/22.
//

import UIKit

class ViewController: UIViewController {
        
    var myCollectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //nav bar setup
        self.navigationItem.title = "Top 100 Albums"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    
        //load Albums
        getAlbums()
        
        //collection view setup
        let view = UIView()
        view.backgroundColor = .white
                
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: self.view.frame.width/2-20, height: self.view.frame.width/2-20)
                
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView?.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        myCollectionView?.backgroundColor = UIColor.white
                
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
         
        view.addSubview(myCollectionView ?? UICollectionView())
                
        self.view = view
    }
    
    func getAlbums(){
        UserService().fetchAlbums(){ (response) in
            switch response {
            case .success:
                self.myCollectionView?.reloadData()
                
            case .successFromStoredData:
                self.myCollectionView?.reloadData()
                self.presentGetAlbumsErrorMessage(title: "Couldn't Update Data", message: "This is previously saved data and may not be current.")
                
            case .failure:
                self.presentGetAlbumsErrorMessage(title: "Couldn't Load Data", message: "There was an error loading the top 100 albums.")
            }
        }
    }
    
    func presentGetAlbumsErrorMessage(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { action in
        }))
        alert.addAction(UIAlertAction(title: "Retry", style: .destructive, handler: { action in
            self.getAlbums()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = App.shared.albums?.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        if let albums = App.shared.albums {
            myCell.albumData = albums[indexPath.item]
        }
        return myCell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {        
        //let button = UIButton()
        //button.setTitle("", for: .normal)
        //let barButton = UIBarButtonItem()
        //barButton.customView = button
        //navigationItem.backBarButtonItem = barButton
        
        //self.navigationItem.setHidesBackButton(true, animated: true)

        
        let albumDetailVC = AlbumDetailViewController()
        if let albums = App.shared.albums {
            albumDetailVC.albumData = albums[indexPath.item]
        }
        self.navigationController?.pushViewController(albumDetailVC, animated: true)
    }
}

