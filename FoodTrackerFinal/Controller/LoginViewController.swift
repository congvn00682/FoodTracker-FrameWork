//
//  LoginViewController.swift
//  FoodTrackerFinal
//
//  Created by Vu Ngoc Cong on 4/25/18.
//  Copyright © 2018 Vu Ngoc Cong. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController {

    
    let fbLoginManager: FBSDKLoginManager = FBSDKLoginManager()
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var loginFacebook: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        loginBtn.layer.cornerRadius = loginBtn.frame.size.width/40
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginFacebookBtn(_ sender: Any) {
        fbLogin()
    }
    
    func fbLogin() {
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) {
            (result, err) in
            if (err == nil) {
                print("Loginn Successfully !")
                let fbLoginResult: FBSDKLoginManagerLoginResult = result!
                if fbLoginResult.grantedPermissions != nil {
                    self.getDataLogin()
                }
                
            }else{
                print("Login Failed")
            }
        }
    }
    
    func getDataLogin() {
        if FBSDKAccessToken.current() != nil {
            // lay gia tri (id: co the hien thi anh, name, email) cua fb sau khi login thanh cong
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: {
                (connect, result, err) in
                if err == nil {
                    // luu cac gia tri vao 1 Dictionary
                    let dict = result as! Dictionary<String, Any>
                    print("Info \(dict)")
                    // lay cac gia tri de co the luu thong tin or hien thi
                    let linkId: String = dict["id"] as! String
                    let linkName: String = dict["name"] as! String
                    let linkEmail: String = dict["email"] as! String
                }
            })
        }
    }
    
}
