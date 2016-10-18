//
//  ItunesSearchManager.swift
//  MusicMojo
//
//  Created by RAJESH SUKUMARAN on 10/13/16.
//  Copyright © 2016 RAJESH SUKUMARAN. All rights reserved.
//

import UIKit



//MARK:- ItunesSearchManagerProtocol
public protocol ItunesSearchManagerProtocol {
    //delegate method for fetch completion
    func getSongsWhenDataTaskCompleted(songs:[Song])
    //delegte method for failiure
    func getSongDataTaskError(error:Error)
}

enum ItunesSearchManagerError:Error
{
    case noSongsFoundError(String)
    case noNetworKError(String)
}


//MARK:- ItunesSearchManager
public class ItunesSearchManager: NSObject {
    
    public  var delegate: ItunesSearchManagerProtocol!
    
    var count:Int=0
    
    /*!
     * @method -fetchMusicListFromiTunes
     *
     * @discussion
     * search param track name ,artist etc
     * Can use some abstracted framework like alamofire ,if there are more number of network calls
     *
     */
    public func fetchMusicListFromiTunes(param:String) -> URLSessionDataTask?
    {
        let urlString = Constants.itunesUrl//?term=" + searchParam
        var urlComps = URLComponents(string:urlString)
        let queryItems = [URLQueryItem(name: Constants.itunesUrlTermParam, value: param)]
        urlComps?.queryItems = queryItems
        
        let url = urlComps?.url
        var request = URLRequest(url: url!)
        request.httpMethod = Constants.methodGet
        if !Reachability.isConnectedToNetwork()
        {
            self.delegate.getSongDataTaskError(error: ItunesSearchManagerError.noNetworKError("No network found"))
            return nil
        }
        
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
                    songs = self.getSongs(resultArray: convertedJsonIntoDict["results"] as! NSArray)
                    //TODO - move the keys to constants
                    if songs.count > 0
                    {
                        self.delegate.getSongsWhenDataTaskCompleted(songs: songs)
                    }
                    else
                    {
                        self.delegate.getSongDataTaskError(error: ItunesSearchManagerError.noSongsFoundError("No Songs Found Error"))
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
                self.delegate.getSongDataTaskError(error: error)
            }
            
        }
        
        task.resume()
        return task
    }
    
    /*!
     * @method -getSongs
     *
     * @discussion
     * iterate the songs from the result
     *
     *
     */
    
    func getSongs(resultArray:NSArray) ->[Song]
    {
        var songs:[Song] = []
        for s in resultArray
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
        return songs
    }
}


