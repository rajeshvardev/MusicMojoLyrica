//
//  ItunesSearchManager.swift
//  MusicMojo
//
//  Created by RAJESH SUKUMARAN on 10/13/16.
//  Copyright © 2016 RAJESH SUKUMARAN. All rights reserved.
//

import UIKit

public protocol ItunesSearchManagerProtocol {
    func getSongsWhenDataTaskCompleted(songs:[Song])
    func getSongDataTaskError(error:NSError)
}


public class ItunesSearchManager: NSObject {
    
    public  var delegate: ItunesSearchManagerProtocol!
    
    var count:Int=0
    
    public func fetchMusicListFromiTunes(param:String) -> URLSessionDataTask
    {
        let searchParam = param.replacingOccurrences(of: " ", with: "+")
        let urlString = "https://itunes.apple.com/search"//?term=" + searchParam
        var UrlComps = URLComponents(string:urlString)
        let queryItems = [URLQueryItem(name: "term", value: searchParam)]
        UrlComps?.queryItems = queryItems

        let url = URL(string: UrlComps?.url)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        // Excute HTTP Request
        
        var songs :[Song] = []
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            // Print out response string
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            //print("responseString = \(responseString)")
            
            
            // Convert server json response to NSDictionary
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    
                    // Print out dictionary
                    print(convertedJsonIntoDict)
                    
                    // Get result Count
                    print(convertedJsonIntoDict["resultCount"])
                    self.count =  (convertedJsonIntoDict["resultCount"] as? Int)!
                    //iterate songs
                    
                    
                    for s in convertedJsonIntoDict["results"] as! NSArray
                    {
                        let song = Song()
                        let songItem = s as! NSDictionary
                        song.wrapperType = songItem.object(forKey: "wrapperType") as! String!
                        song.kind = songItem.object(forKey: "kind") as! String!
                        song.artistId = songItem.object(forKey: "artistId") as! Double!
                        song.collectionId = songItem.object(forKey: "collectionId") as! Double!
                        song.trackId = songItem.object(forKey: "trackId") as! Double!
                        song.artistName = songItem.object(forKey: "artistName") as! String!
                        song.collectionName = songItem.object(forKey: "collectionName") as! String!
                        song.trackName = songItem.object(forKey: "trackName") as! String!
                        song.collectionCensoredName = songItem.object(forKey: "collectionCensoredName") as! String!
                        song.trackCensoredName = songItem.object(forKey: "trackCensoredName") as! String!
                        song.artistViewUrl = songItem.object(forKey: "artistViewUrl") as! String!
                        song.collectionViewUrl = songItem.object(forKey: "collectionViewUrl") as! String!
                        song.trackViewUrl = songItem.object(forKey: "trackViewUrl") as! String!
                        song.previewUrl = songItem.object(forKey: "previewUrl") as! String!
                        song.artworkUrl30 = songItem.object(forKey: "artworkUrl30") as! String!
                        song.artworkUrl60 = songItem.object(forKey: "artworkUrl60") as! String!
                        song.artworkUrl100 = songItem.object(forKey: "artworkUrl100") as! String!
                        song.collectionPrice = songItem.object(forKey: "collectionPrice") as! Float!
                        song.trackPrice = songItem.object(forKey: "trackPrice") as! Float!
                        song.releaseDate = songItem.object(forKey: "releaseDate") as! String!
                        song.collectionExplicitness = songItem.object(forKey: "collectionExplicitness") as! String!
                        song.trackExplicitness = songItem.object(forKey: "trackExplicitness") as! String!
                        song.discCount = songItem.object(forKey: "discCount") as! Int!
                        song.discNumber = songItem.object(forKey: "discNumber") as! Int!
                        song.trackCount = songItem.object(forKey: "trackCount") as! Int!
                        song.trackNumber = songItem.object(forKey: "trackNumber") as! Int!
                        song.trackTimeMillis = songItem.object(forKey: "trackTimeMillis") as! Double!
                        song.country = songItem.object(forKey: "country") as! String!
                        song.currency = songItem.object(forKey: "currency") as! String!
                        song.primaryGenreName = songItem.object(forKey: "primaryGenreName") as! String!
                        song.isStreamable = songItem.object(forKey: "isStreamable") as! Bool!
                        songs.append(song)
                    }
                    self.delegate.getSongsWhenDataTaskCompleted(songs: songs)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
                self.delegate.getSongDataTaskError(error: error)
            }
            
        }
        
        task.resume()
        return task
    }
    
    
}


