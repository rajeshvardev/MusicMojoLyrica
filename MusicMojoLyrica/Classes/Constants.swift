//
//  Constants.swift
//  Pods
//
//  Created by RAJESH SUKUMARAN on 10/17/16.
//  Constants used in the library
//

import Foundation
struct Constants {
    static let itunesUrl:String = "https://itunes.apple.com/search"
    static let lyricsUrl:String = "http://lyrics.wikia.com/api.php"
    static let itunesUrlTermParam:String = "term"
    static let lyricsUrlFuncParam:String = "func"
    static let lyricsUrlFuncParamValue:String = "getSong"
    static let lyricsUrlArtishParam:String = "artist"
    static let lyricsUrlSongParam:String = "song"
    static let lyricsUrlFmtParam:String = "fmt"
    static let lyricsUrlFmtParamValue:String = "json"
    static let lyricsXPath:String = "//div[contains(@class, 'lyricbox')]"
    static let methodGet:String = "GET"
    static let recentSearchArchiveKey:String = "recentSearches"
    static let recentSearchArchiveSeperator:String = "#"
}
