//
//  EditProfileViewController.swift
//  SafeConnect
//
//  Created by Jessica Wallen on 11/20/20.
//  Copyright © 2020 Michelle Katz. All rights reserved.
//

import UIKit
import Firebase


class EditProfileViewController: UIViewController {
    
    var name: String = ""
    var username: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var desc: String = "Edit profile description here..."

    @IBOutlet weak var nameField: UITextField!
    //@IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var profileDescField: UITextView!
    //@IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.text = name
        emailField.text = email
        phoneNumberField.text = phoneNumber
        profileDescField.text = desc

        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(_ sender: Any) {
        let database = Database.database().reference()
        // ...
        if(nameField.text == "" || emailField.text == "" || phoneNumberField.text == "" || profileDescField.text == ""){
            let alert = UIAlertController(title: "Profile Not Complete", message: "Please fill in the remaining fields.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        else{
          let object : [String: Any] = [ // user data
            "name": nameField.text!,
            "Email": emailField.text!,
            // to replace and update user data and to be replace with input fields
            "PhoneNumber": phoneNumberField.text!,
            "Profile_Des": profileDescField.text!
          ]
        database.child("Users/\(currentId)").setValue(object)
        let alert = UIAlertController(title: "Profile Edited", message: "Profile changes saved!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
