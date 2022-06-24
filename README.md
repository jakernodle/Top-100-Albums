# Top-100-Albums
This is a simple UICollectionView example with asynchronous image loading using Kingfisher, Alamofire for network requests, and a completly programmatic UI. Though Top-100-Albums is a simple 2 screen application, it displays the way swift projects should be structure in a production setting.

# How to run the example?
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
