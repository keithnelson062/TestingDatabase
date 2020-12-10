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
    func getTime(sender:UIDatePicker) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d, yyyy @ K:mm a"
        let time = formatter.string(from: sender.date)
        return time
    }
    
    @IBAction func addEvent(_ sender: Any) {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "EEE MMM d, yyyy @ K:mm a"
        let dateString = formatter.string(from: datePicker.date) // string purpose I add here


        print(dateString)
        
        //let userID = Auth.auth().currentUser?.uid
        let time = getTime(sender: datePicker)
        let database = Database.database().reference()
        print(time)
        let event : [String:Any] = ["Eventname" : nameField.text,
        "Photo_add" : "photo_link",
        "Links" : "websites",
        "Date_Time": time,
        "Summary" : descField.text, // to be replaced with input text fields
        "Date": dateString,
        "Location": locationField.text,
        "Event_id" : covidField.text
                ]

        database.child("Events").childByAutoId().setValue(event)
       // database.child("Events").child(userid).setValue(event)
    // find user id string
        
        nameField.text = ""
        descField.text = ""
        locationField.text = ""
        datePicker.minimumDate = Date()
        covidField.text = ""
        
        let alert = UIAlertController(title: "Event", message: "Event Successfully Added", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
