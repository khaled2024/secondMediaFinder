//
//  Validtor.swift
//  testMyTestTwo
//
//  Created by KhaleD HuSsien on 27/10/2021.
//
import UIKit

class Validtor {
    //MARK: - Signleton
    private static let sharedInstance = Validtor()
    static func shared() ->Validtor{
        return Validtor.sharedInstance
    }
    func isEmailValid(email: String)->Bool{
        let regx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let pred = NSPredicate(format: "SELF MATCHES %@", regx)
        return pred.evaluate(with: email)
    }
    func isPasswordValid(password: String)->Bool{
        let regx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let pred = NSPredicate(format: "SELF MATCHES %@", regx)
        return pred.evaluate(with: password)
    }
    
    

}
