//
//  LoginViewController.swift
//  SafeConnect
//
//  Created by Michelle Katz on 11/19/20.
//  Copyright © 2020 Michelle Katz. All rights reserved.
//

import UIKit
import GoogleSignIn
class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var test: GIDSignInButton!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "loginPress") {
            if segue.destination is TabBarController {
                print("done")
            }
        }
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
