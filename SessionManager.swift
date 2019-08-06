//
//  SessionManager.swift
//  BlindTunes
//
//  Created by BugDev Studios on 19/11/2018.
//  Copyright © 2018 BugDev Studios. All rights reserved.
//

import Foundation
class SessionManager {
  
  //make singleton
  static let shared = SessionManager()
  private init() {
    
  }
  
  ///for prepopulating text fields in login and sign up
  var dummyUserCount : Int {
    get {
      return UserDefaults.standard.integer(forKey: sessionKeys.isUserSubscribed)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: sessionKeys.isUserSubscribed)
    }
  }
  
  var isUserSubscribed : Bool {
    get {
      return UserDefaults.standard.bool(forKey: sessionKeys.isUserSubscribed)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: sessionKeys.isUserSubscribed)
    }
  }
  
  var isUserLoggedIn : Bool {
    get {
      return UserDefaults.standard.bool(forKey: sessionKeys.isLoggedIn)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: sessionKeys.isLoggedIn)
    }
  }
  
  var userID : Int? {
    get {
      return UserDefaults.standard.integer(forKey: sessionKeys.userID)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: sessionKeys.userID)
    }
  }
  
}


struct sessionKeys {
  static let isUserSubscribed = "isUserSubscribed"
  static let isLoggedIn = "IsUserLoggedIn"
  static let userID = "UserID"
  static let dummyUserCount = "dummyUserCount"
}
