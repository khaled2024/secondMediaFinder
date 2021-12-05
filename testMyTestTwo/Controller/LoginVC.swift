//
//  LoginVC.swift
//  testMyTestTwo
//
//  Created by KhaleD HuSsien on 12/10/2021.
//
import UIKit
import SQLite

class LoginVC: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(false, forKey: userDefultsKeys.isLoggedIn)
    }
    override func viewWillAppear(_ animated: Bool) {
        loginBtn.layer.cornerRadius = 6.0
    }
    
    //MARK: private Functions
    private func loginValidationAndAuth(){
        if let email = emailTextField.text , !email.isEmpty ,let password = passwordTextField.text ,!password.isEmpty{
            let loginAuth = SqlManager.shared().loginAuth(email: emailTextField.text!, password: passwordTextField.text!)
            print(loginAuth)
            if loginAuth == true {
                goToMoviesVC()
                let email = emailTextField.text!
                UserDefaults.standard.set(email, forKey: userDefultsKeys.email)
            }else{
                getAlert(message: "Your Email or Password are Incorrect")
            }
        }
        else {
            getAlert(message: "please check Your Fields")
        }
    }
    private func goToMoviesVC(){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            appDelegate.openToMovie()
        }
    }
    
    //MARK: -Actions
    
    @IBAction func LoginBtnTapped(_ sender: UIButton) {
        loginValidationAndAuth()
    }
    
    @IBAction func RegisterBtn(_ sender: UIButton) {
        let sb = UIStoryboard(name: ViewContollers.main, bundle: nil)
        let registerVC = sb.instantiateViewController(withIdentifier: ViewContollers.registerVC)as! RegisterVC
        navigationController?.pushViewController(registerVC, animated: true)
        navigationController?.navigationItem.hidesBackButton = true
    }
}
