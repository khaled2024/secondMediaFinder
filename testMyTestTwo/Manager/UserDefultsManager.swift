//
//  UserDefultsManager.swift
//  testMyTestTwo
//
//  Created by KhaleD HuSsien on 27/10/2021.

import UIKit

class UserDefultsManager {
    //MARK: - Signleton
    private static let sharedInstance = UserDefultsManager()
    static func shared() ->UserDefultsManager{
        return UserDefultsManager.sharedInstance
    }
    
    //MARK: - Variabels
    private let def = UserDefaults.standard
    
    var email: String{
        set{
            def.set(newValue, forKey: userDefultsKeys.email)
        }
        get{
            guard def.object(forKey: userDefultsKeys.email) != nil else  {
                return "Nothing"
            }
            return def.string(forKey: userDefultsKeys.email)!
        }
    }
    var isLoggedIn: Bool{
        set{
            def.set(newValue, forKey: userDefultsKeys.isLoggedIn)
        }
        get{
            guard def.object(forKey: userDefultsKeys.isLoggedIn) != nil else  {
                return false
            }
            return def.bool(forKey: userDefultsKeys.isLoggedIn)
        }
    }
}
