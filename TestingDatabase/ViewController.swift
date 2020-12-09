//
//  ViewController.swift
//  TestingDatabase
//
//  Created by Keith Nelson on 11/16/20.
//  Copyright © 2020 Keith Nelson. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseCore
var Newevents:  [Event] = [] // arrays of events and names

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func fetchEvent() { // fecthing event data
        Newevents = [] // array of new events
        Database.database().reference().child("Events").observe(.childAdded, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary // casting as dictionary
            let username = value?["Links"] as? String ?? "" // which feature is being caught
            
            if let dict = snapshot.value as? [String : AnyObject]{ //casting as anyobject
                let event = Event() // creating new event object
                event.setValuesForKeys(dict) // set to dict
                
                Newevents.append(event)
                self.arrayname.append(event.Eventname ?? "sorry")
                self.Tabledata.reloadData()
                DispatchQueue.global(qos: .userInitiated).async {
                    DispatchQueue.main.async {
                        self.Tabledata.reloadData()
                    }

                }
            }
            print("Something")
        }, withCancel: nil)
    }
    
    var myarray = [String]()
    var arrayname = [String]()
    var aname = [String]()
// settuping table view
    private let database = Database.database().reference()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Newevents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mycell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        let event = Newevents[indexPath.row]
        mycell.textLabel?.text = event.Eventname
        mycell.detailTextLabel?.text = event.Links
        print(event.Eventname!) // printing the names of events
        return mycell
        // displaying event name and info
    }
    

    @IBAction func fetchfire(_ sender: Any) {
        let ref = Database.database().reference().child("Events") // fetching data by events on database
        ref.observe(.childAdded) { (snapshot) in
            self.myarray = []
            
            self.arrayname = []
            self.aname = []
            Database.database().reference().child("Events").observe(.childAdded, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let username = value?["Links"] as? String ?? ""
                self.aname.append(username)
                if let dict = snapshot.value as? [String: AnyObject] {
                    let event = Event()
                    print("jvhjvjvhjvj  \(event.Eventname ?? "why")") // testing
                    Newevents.append(event)
                    self.arrayname.append(event.Eventname ?? "sorry") // testing
                    self.Tabledata.reloadData()
                    DispatchQueue.global(qos: .userInitiated).async {
                        DispatchQueue.main.async {
                            self.Tabledata.reloadData()
                            event.Eventname = dict["Eventname"] as? String

                        }

                    }
                }

            }, withCancel: nil)
            print("aname somehting \(self.aname)")
            print(Newevents)
            print(self.arrayname)
        }
        Tabledata.reloadData()

    }
    
    @IBOutlet weak var Tabledata: UITableView!
    
    override func viewDidLoad() {
        self.fetchEvent()

        super.viewDidLoad()
        let ref = Database.database().reference()
        ref.child("Events").observe(.childAdded, with: {(snap) in
            let post = snap.value as? Event
            if let actual = post{
                print("actuaul is \(actual)")
                self.Tabledata.reloadData()
            }
        })

        self.setupTableView()
        // button function for adding events
        let button = UIButton(frame: CGRect(x: 20, y: 200, width: view.frame.size.width-40, height: 50))
        button.setTitle("Add Event", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .link
        view.addSubview(button)

        button.addTarget(self, action: #selector(addNew), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    @objc private func addNew() { // adding and posting events
        
        let object : [String: Any] = [ // user data
            "name": "something_for event",
            "Email": "email", // to replace and update user data and to be replace with input fields
            "Googleid": "id",
            "Users" : "users",
        ]
        let event : [String:Any] = ["Eventname" : "place_name",
                "Photo_add" : "photo_link",
        "Links" : "websites",
        "Date_Time": "Date/Time",
        "Summary" : "Event_summary", // to be replaced with input text fields
        "Date": "some_time",
        "Location": "location",
        "Event_id" : "event_id"
                ]
        database.child("Gmail_Id").childByAutoId().setValue(object) // adding user data to be also replace with the google ids and possibly merged as one 
        database.child("Events").childByAutoId().setValue(event) // adding to the events categories
    }
    func setupTableView() {
        Tabledata.dataSource = self
        Tabledata.delegate = self
    }


}

