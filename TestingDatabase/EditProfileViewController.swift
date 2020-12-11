//
//  EditProfileViewController.swift
//  SafeConnect
//
//  Created by Jessica Wallen on 11/20/20.
//  Copyright © 2020 Michelle Katz. All rights reserved.
//

import UIKit
import Firebase


class EditProfileViewController: UIViewController, UITableViewDataSource {
    
    var name: String = ""
    var username: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var desc: String = ""

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var profileDescField: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        nameField.text = name
        usernameField.text = username
        emailField.text = email
        phoneNumberField.text = phoneNumber
        profileDescField.text = desc

        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(_ sender: Any) {
        let database = Database.database().reference()

          
        // ...
          let object : [String: Any] = [ // user data
            "name": nameField.text!,
            "Email": emailField.text!,
            // to replace and update user data and to be replace with input fields
            "Phone": phoneNumberField.text!,
            "username": usernameField.text!,
            "Profile_Des": profileDescField.text!
          ]
          
          

        database.child("Users/\(currentId)").setValue(object)
        print(name)
        
        
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "tableCell")
        cell.textLabel!.text = "Event " + String(indexPath.row)
        return cell
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
