//
//  ProfileVC.swift
//  testMyTestTwo
//
//  Created by KhaleD HuSsien on 12/10/2021.
//

import UIKit
import SQLite
class ProfileVC: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var NameLable: UILabel!
    @IBOutlet weak var emailLable: UILabel!
    @IBOutlet weak var addressLable: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    //MARK: Variable
    var user: User!
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setData()
        setItemBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpLayouts()
    }
    //MARK: private Functions
    
    private func setUpLayouts(){
        profileImageView.layer.cornerRadius = (profileImageView.frame.size.width  ) / 7
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderWidth = 2.0
        profileImageView.layer.borderColor = UIColor.white.cgColor
    }
    
    private func setData(){
        NameLable.text = "Name: " + user.name
        emailLable.text = "Email: " + user.email
        addressLable.text = "Address: " + user.address
        let image = UIImage(data: user.image)
        profileImageView.image = image
    }
    
    private func setUp(){
        let email = UserDefultsManager.shared().email
        user = SqlManager.shared().getUserFromDB(emailUser: email)!
    }
    
    //MARK: - Actions
    @objc private func goToLoginScreen(){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            appDelegate.openToLogin()
        }
    }
    
    private func setItemBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "logout"), style: .plain, target: self, action: #selector(goToLoginScreen))
    }
}
