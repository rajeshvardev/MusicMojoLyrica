//
//  RecentSearchManager.swift
//  MusicMojo
//
//  Created by RAJESH SUKUMARAN on 10/16/16.
//  Copyright © 2016 RAJESH SUKUMARAN. All rights reserved.
//

import UIKit

public class RecentSearchManager: NSObject {
    
    var recents:String
    var recentSearches:[String]
    
    override init() {
        recents = ""
        recentSearches = []
        super.init()
        getPreference()
        
    }
    
    public static let sharedInstance : RecentSearchManager = {
        let instance = RecentSearchManager()
        return instance
    }()
    
    
    public func savePrefernce()
    {
        UserDefaults.standard.set(self.recents, forKey: "recentSearches")
    }
    
    public func clearPreference()
    {
        self.recents = ""
        UserDefaults.standard.set(self.recents, forKey: "recentSearches")
    }
    
    public func readPreference() -> [String]
    {
        return recentSearches
    }
    func getPreference()
    {
        self.recents = (UserDefaults.standard.string(forKey: "recentSearches") != nil) ? UserDefaults.standard.string(forKey: "recentSearches")! : ""
        self.recentSearches = recents.characters.split(separator: "#").map(String.init)
    }
    public func addPrefernce(search:String)
    {
        self.recentSearches.append(search)
        self.recents = self.recentSearches.joined(separator: "#")
        self.savePrefernce()
    }
    
}
