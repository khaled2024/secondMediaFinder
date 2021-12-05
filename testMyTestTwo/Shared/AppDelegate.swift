//
//  AppDelegate.swift
//  testMyTestTwo
//
//  Created by KhaleD HuSsien on 12/10/2021.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // cocoapods for (IQKeyboardManager)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        // for database
        SqlManager.shared().setUpConnection()
        SqlManager.shared().setUpConnectionforMediaCells()
        SqlManager.shared().createTableForCell()
        //root
        appRoot()
        return true
    }
    //MARK: - Functions
    private func appRoot(){
        let def = UserDefaults.standard
        if let isLoggedIn = def.object(forKey: userDefultsKeys.isLoggedIn)as? Bool{
            if isLoggedIn {
                openToMovie()
            }else{
                openToLogin()
            }
        }
    }
    func openToMovie(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let moviesVC = sb.instantiateViewController(withIdentifier: ViewContollers.moviesVC)as! MoviesVC
        let navController = UINavigationController(rootViewController: moviesVC)
        navController.navigationItem.hidesBackButton = true
        self.window?.rootViewController = navController
    }
    func openToLogin(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = sb.instantiateViewController(withIdentifier: ViewContollers.loginVC)as! LoginVC
        let navController = UINavigationController(rootViewController: loginVC)
        self.window?.rootViewController = navController
    }
    //
    private func openToProfile(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let profileVC = sb.instantiateViewController(withIdentifier: ViewContollers.profileVC)as! ProfileVC
        self.window?.rootViewController = profileVC
    }
}

