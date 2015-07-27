//
//  ParseModels.swift
//  ParseStarterProject
//
//  Created by Dario on 7/24/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation

class ParseModels: NSObject {

    override init() {
        super.init()
    }
    
    static func registerSubclasses() {
        Device.registerSubclass()
        FeedSetting.registerSubclass()
    }
}
