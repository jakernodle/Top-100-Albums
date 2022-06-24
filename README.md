# Top-100-Albums
This is a simple UICollectionView example with asynchronous image loading using Kingfisher, Alamofire for network requests, and a completly programmatic UI. Though Top-100-Albums is a simple 2 screen application, it displays how I structure swift projects in a production setting.

# How to run?
1. Clone this repo
2. Open shell window and navigate to project folder
3. Run `pod install`
4. Open the xcworkspace file and run the project on a selected device or simulator

# Code Organization
## /ViewControllers
- ViewController is a UIViewController class embedded in a NavigationController that holds the UICollectionView for displaying albums.
- AlbumDetailViewController is also a UIViewController class that is passed `Album` data from ViewController to display a single album.

## /Cells
- CustomCollectionViewCell is custom UICollectionViewCell class used by ViewController.

## /Models
The Models folder holds all the neccessary data structures utilized by Top-100-Albums
- Album is a `Codable` structure that is the most common struct utilized by the app. 
- Genre is also a `Codable` structure that is utilized by the `Album` struct. 
- Root and RSSFeed are both `Decodable` structures that are used as helpers to reach the results portion of the Json as show below.

```Json

{
  "feed": {
    ...
    "results": [
      {
        "artistName": "Drake",
        "name": "Honestly, Nevermind",
        "releaseDate": "2022-06-17",
        "artistUrl": "https://music.apple.com/us/artist/drake/271256",
        "artworkUrl100": "https://is4-ssl.mzstatic.com/image/thumb/Music122/v4/84/2c/b4/842cb419-243c-b3f4-4da9-b6b980996062/22UMGIM67371.rgb.jpg/100x100bb.jpg",
        ...
        "genres": [
          {
            "genreId": "17",
            "name": "Dance",
            "url": "https://itunes.apple.com/us/genre/id17"
          },
          ...
        ],
        "url": "https://music.apple.com/us/album/honestly-nevermind/1630230040"
      }
    ]
  }
}

```

## /Managers + Networking
In a larger scale application, it would make sense to seperate the managers and networking, however since this application only contains one network request, it seemed overly complicated to seperate the two
- UserService is the class that implements our `fetchAlbums()` network request. If successfull, the album data is stored to the static `shared` value of our `App` class to be used globally.
- App is a simple but helpful class for us to store and use our Album data globally.

## /Extensions
These are both simple extensions to minimize code repetition when creating labels and image views.
- UILabel + TopAlbums
- UIImageView + TopAlbums

## Constants.swift
Constants.swift contains a simple struct for constants used throughout the app. In the future I may add more here.

# Code Features
- No force unwrap statements
- All UI is Auto Layout/programmatic
- MVVM architecture
- Asynchronous and lazy image fetching
- Displays the top 100 music albums in the US
- Network error handling
- Consumes a JSON feed using Alamofire
- Displays music albums with or without network connection after the first time the data is loaded and stored to UserDefaults.
- Allows the user to retry the network call if it fails and there isn’t any data in the local database

# Frameworks
- [Alamofire](https://github.com/Alamofire/Alamofire) - An elegant HTTP networking library written in Swift.
- [Kingfisher](https://github.com/onevcat/Kingfisher) - Kingfisher is a powerful, pure-Swift library for downloading and caching images from the web.
