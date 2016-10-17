//
//  RecentSearchManager.swift
//  MusicMojo
//
//  Created by RAJESH SUKUMARAN on 10/16/16.
//  Copyright © 2016 RAJESH SUKUMARAN. All rights reserved.
//
//  Class to handle recent searches

import UIKit
public class RecentSearchManager: NSObject {
    
    public var recents:String
    public var recentSearches:[String]
    
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
        UserDefaults.standard.set(self.recents, forKey: Constants.recentSearchArchiveKey)
        UserDefaults.standard.synchronize()
    }
    
    public func clearPreference()
    {
        self.recents = ""
        UserDefaults.standard.set(self.recents, forKey: Constants.recentSearchArchiveKey)
        UserDefaults.standard.synchronize()
        getPreference()
    }
    
    public func readPreference() -> [String]
    {
        return recentSearches.reversed()
    }
    func getPreference()
    {
        self.recents = (UserDefaults.standard.string(forKey: Constants.recentSearchArchiveKey) != nil) ? UserDefaults.standard.string(forKey: Constants.recentSearchArchiveKey)! : ""
        let recent = recents.characters.split(separator: Constants.recentSearchArchiveSeperator.characters.first!).map(String.init)
//        var recentReversed:[String] = []
//        for arrayIndex in stride(from:recent.count-1 ,through: 0, by: -1) {
//            recentReversed.append(recent[arrayIndex])
//        }
        
        self.recentSearches = recent.reversed()
    }
    public func addPrefernce(search:String)
    {
        if self.recentSearches.contains(search)
        {
            self.recentSearches.remove(at: self.recentSearches.index(of: search)!)
        }
        self.recentSearches.append(search)
        self.recents = self.recentSearches.joined(separator: Constants.recentSearchArchiveSeperator)
        self.savePrefernce()
    }
    
}
