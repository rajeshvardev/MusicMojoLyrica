//
//  Utils.swift
//  MusicMojo
//
//  Created by RAJESH SUKUMARAN on 10/13/16.
//  Copyright © 2016 RAJESH SUKUMARAN. All rights reserved.
//

import Foundation
import SystemConfiguration
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


//This class checks network reachability.
public class Reachability {
    
    /**
     This method will check whether network is available or not.
     
     Method return Boolean value by checking network rechability.
     **/
    public class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}
