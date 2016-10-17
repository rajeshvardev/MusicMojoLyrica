//
//  Utils.swift
//  MusicMojo
//
//  Created by RAJESH SUKUMARAN on 10/13/16.
//  Copyright © 2016 RAJESH SUKUMARAN. All rights reserved.
//

import Foundation

class Utils
{
    static func JsonLikeStructureValueFinder(key:String,structure:String) -> String?
    {
        let keyRange = structure.range(of: key)
        let lineRange = structure.lineRange(for: keyRange!)
        var substringline = structure.substring(with: lineRange)
        substringline = substringline.replacingOccurrences(of: "\'", with: "")
        substringline = substringline.replacingOccurrences(of: "\n", with: "")
        let keyValueExplode = substringline.characters.split(separator: ":" , maxSplits:1).map(String.init)
        if keyValueExplode.count > 0
        {return keyValueExplode.last!}
        else
        {return nil}
        
    }
    static func sanitiseLyrics(key:String) -> String
    {
        var returnString = key.replacingOccurrences(of: "<br>", with: "\n")
        returnString = returnString.replacingOccurrences(of: "<div class=\"lyricsbreak\"></div>", with: "\n")
        return returnString
    }
}

