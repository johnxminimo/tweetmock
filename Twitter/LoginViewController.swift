//
//  LoginViewController.swift
//  Twitter
//
//  Created by John Minimo on 2/14/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginUIButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton(_ sender: Any) {
        let requestTokenURL:String = "https://api.twitter.com/oauth/request_token"
        
        TwitterAPICaller.client?.login(url: requestTokenURL, success: {
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { Error in
            print("Login failed, check your password or username.")
        })
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
