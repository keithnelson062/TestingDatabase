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
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss a"
        var ouptputTime = dateFormatter.string(from: sender.date)
        print("ouptputTime:-\(ouptputTime)")
        return "ouptputTime:-\(ouptputTime)"
    }
    
    @IBAction func addEvent(_ sender: Any) {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd"

        let myString = formatter.string(from: datePicker.date) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "dd-MMM-yyyy"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)

        print(myStringafd)
        
        //let userID = Auth.auth().currentUser?.uid
        var time = getTime(sender: datePicker)
        let database = Database.database().reference()
        print(time)
        let event : [String:Any] = ["Eventname" : nameField.text,
                "Photo_add" : "photo_link",
        "Links" : "websites",
        "Date_Time": time,
        "Summary" : descField.text, // to be replaced with input text fields
            "Date": myStringafd,
        "Location": locationField.text,
        "Event_id" : covidField.text
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
