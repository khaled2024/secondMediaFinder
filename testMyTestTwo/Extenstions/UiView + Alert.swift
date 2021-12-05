//
//  UiView + Alert.swift
//  testMyTestTwo
//
//  Created by KhaleD HuSsien on 27/10/2021.
//

import UIKit
extension UIViewController{
    
    func getAlert(message: String){
        let alert = UIAlertController.init(title: "Sorry", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
     func getSuccessAlert(title: String , message: String , completion: ((UIAlertAction) -> Void)?){
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: completion))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}

