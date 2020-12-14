//
//  ProfileViewController.swift
//  SafeConnect
//
//  Created by Michelle Katz on 11/19/20.
//  Copyright © 2020 Michelle Katz. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase
class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var profileDescription: UITextView!
    override func viewDidLoad() {
        var nowUser = Connection()
        super.viewDidLoad()

        Database.database().reference().child("Users/\(currentId)").observe(.value, with: { (snapshot) in
          if let dict = snapshot.value as? [String : Any]{ //casting as anyobject
            _ = dict.keys
                nowUser = Connection()
            nowUser.setValuesForKeys(dict) // set to dict
            self.email.text = nowUser.Email!
            self.name.text = nowUser.name!
            self.profileDescription.text = nowUser.Profile_Des!
            self.phoneNumber.text = nowUser.PhoneNumber!
              
          }
        }, withCancel: nil)

    }
    @IBAction func signout(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editProfile"){
            if let detailVC = segue.destination as? EditProfileViewController {
                detailVC.desc = profileDescription.text
                detailVC.email = email.text ?? ""
                detailVC.name = name.text ?? ""
                detailVC.phoneNumber = phoneNumber.text ?? ""
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
