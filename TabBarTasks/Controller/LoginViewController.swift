//
//  LoginViewController.swift
//  TabBarTasks
//
//  Created by Shawn Li on 5/23/20.
//  Copyright © 2020 ShawnLi. All rights reserved.
//

import UIKit
import LoginTextField
import LGButton

class LoginViewController: UIViewController, UITextFieldDelegate
{
    var userNameTF = LoginTextField()
    var passwordTF = LoginTextField()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func loginTapped(_ sender: LGButton)
    {
        if let username = userNameTF.text, let password = passwordTF.text, !username.isEmpty, !password.isEmpty
        {
            if UserDefaults.standard.value(forKey: username) as! String == password
            {
                UserDefaults.standard.set(true, forKey: AppConstants.UserInfo.loginStatusKey)
                
                let home = self.storyboard?.instantiateViewController(identifier: AppConstants.StoryBoardID.tabBarControllerID) as! TabBarController
                self.navigationController?.pushViewController(home, animated: true)
            }
            else
            {
                AlertManager.alert(forWhichPage: self, alertType: .userAuthenticationFailed)
            }
        }
        else
        {
           AlertManager.alert(forWhichPage: self, alertType: .userAuthenticationEmpty)
        }
    }
    
    func setupUI()
    {
        // User Name
        UserAuthentication.userNameTFSetup(userNameTF: &userNameTF, forWhichPage: self)
        //Password
        UserAuthentication.passwordTFSetup(passwordTF: &passwordTF, forWhichPage: self, isLoginPage: true)
        userNameTF.delegate = self
        passwordTF.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        userNameTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        return true
    }
    
}
