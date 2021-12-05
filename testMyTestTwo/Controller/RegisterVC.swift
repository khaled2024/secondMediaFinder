//
//  RegisterVC.swift
//  testMyTestTwo
//
//  Created by KhaleD HuSsien on 12/10/2021.
//

import UIKit
import SQLite
class RegisterVC: UIViewController {
    //MARK: -OutLets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: -LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserImage()
        setUpNavigationBar()
        SqlManager.shared().createTable()
        SqlManager.shared().getAllUsers()
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpLayouts()
    }
    //MARK: - private Functions
    
    private func setUpLayouts(){
        registerBtn.layer.cornerRadius = 7.0
        loginBtn.layer.cornerRadius = 7.0
        imageView.layer.cornerRadius = (imageView.frame.size.width  ) / 7
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2.0
        imageView.layer.borderColor = UIColor.white.cgColor
    }
    
    private func setUserImage(){
        imageView.image = UIImage(systemName: "person.fill")
    }
    
    private func isValidEmail(email: String) -> Bool{
        if !email.trimed.isEmpty{
            if Validtor.shared().isEmailValid(email: email){
                return true
            }else{
                getAlert(message: "please Enter valid email example khaled@gmail.com")
                return false
            }
        }else{
            getAlert(message: "please Enter valid email")
        }
        return false
    }
    
    private func isValidPassword(password: String) -> Bool{
        if !password.isEmpty{ // مش فاضي
            if Validtor.shared().isPasswordValid(password: password){
                return true
            }
            else{
                getAlert(message: "please Enter valid password with at least a capital letter & one smale letter and at least 8 number or more")
                return false
            }
        }else{
            getAlert(message: "please Enter password")
        }
        return false
    }
    
    private func isValidName(name: String) -> Bool{
        if !name.isEmpty{
            return true
        }else{
            getAlert(message: "please Enter Name")
            return false
        }
    }
    
    private func isValidAddress(address: String) -> Bool{
        if !address.isEmpty{
            return true
        }else{
            getAlert(message: "please Enter valid Address")
            return false
        }
    }
    
    private func isEnteredImage(image: UIImage)-> Bool{
        if image == UIImage(systemName: "person.fill"){
            getAlert(message: "please Enter Profile Image")
            return false
        }else{
            return true
        }
    }
    
    private func isValiedFileds() -> Bool{
        if  let name = nameTextField.text ,isValidName(name: name) ,
            let email = emailTextField.text ,isValidEmail(email: email) ,
            let password = passwordTextField.text ,isValidPassword(password: password) ,
            let address = addressTextField.text ,isValidAddress(address: address),
            let image = imageView.image ,isEnteredImage(image: image) {
            return true
        }
        return false
    }
    
    private func setUpNavigationBar(){
        navigationItem.title = "Register"
        navigationController?.navigationBar.backItem?.titleView?.tintColor = .white
    }
    
    @objc private func goToLoginScreen(){
        let sb = UIStoryboard(name: ViewContollers.main, bundle: nil)
        let loginVC = sb.instantiateViewController(withIdentifier: ViewContollers.loginVC)as! LoginVC
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    //MARK: - Actions
    @IBAction func registerBtnTapped(_ sender: UIButton) {
        if isValiedFileds(){
            SqlManager.shared().insertUser(name: nameTextField.text!, email: emailTextField.text!, address: addressTextField.text!, password: passwordTextField.text!, imageView: imageView)
            self.getSuccessAlert(title: "Congratulation!", message: "Your account created succesfully") { _ in
                self.goToLoginScreen()
            }
        }
    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        goToLoginScreen()
    }
    
    @IBAction func adressBtnTapped(_ sender: UIButton) {
        let sb = UIStoryboard(name: ViewContollers.main, bundle: nil)
        let mapVC = sb.instantiateViewController(withIdentifier: ViewContollers.mapVC)as! MapVC
        self.present(mapVC, animated: true, completion: nil)
        mapVC.modalPresentationStyle = .overFullScreen
        mapVC.delegate = self
    }
    
    @IBAction func imageProfileBtnTapped(_ sender: UIButton) {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self
        self.present(imagePickerVC, animated: true, completion: nil)
    }
}
//MARK: -Extension

extension RegisterVC: ShowLocationDelegation {
    func location(location: String) {
        addressTextField.text = location
    }
}
extension RegisterVC: UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            imageView.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
}

