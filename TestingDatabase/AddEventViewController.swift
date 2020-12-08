//
//  AddEventViewController.swift
//  SafeConnect
//
//  Created by Jessica Wallen on 11/20/20.
//  Copyright © 2020 Michelle Katz. All rights reserved.
//

import UIKit
import FirebaseDatabase
class AddEventViewController: UIViewController {

    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var covidField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.minimumDate = Date()

        // Do any additional setup after loading the view.
    }
    //self.ref.child("users").child(user.uid).setValue(["username": username]) for adding users

    
    @IBAction func addEvent(_ sender: Any) {
        //let userID = Auth.auth().currentUser?.uid

        let database = Database.database().reference()

        let event : [String:Any] = [
        "Eventname" : nameField.text ?? "something2",
        "Photo_add" : "photo_link",
        "Links" : "websites",
        "Date": datePicker.date,
        "Summary" : descField.text!, // to be replaced with input text fields
        "Date_Time": [".sv": "timestamp"],
        "Location": locationField.text ?? "something",
        "Event_id" : "event_id"
                ]

        database.child("Events").childByAutoId().setValue(event)
       // database.child("Events").child(userid).setValue(event)
    // find user id string
    }
    
// self.ref.child("users/\(user.uid)/username").setValue(username) for changing and updating usernames and profile info
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
