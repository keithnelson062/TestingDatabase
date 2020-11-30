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
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func fetchEvent() {
        Newevents = []
        Database.database().reference().child("Events").observe(.childAdded, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let username = value?["Links"] as? String ?? ""
            
            if let dict = snapshot.value as? [String : AnyObject]{
                let event = Event()
                event.setValuesForKeys(dict)
                
                //print(event.Eventname!, event.Links!)
                self.Newevents.append(event)
                self.arrayname.append(event.Eventname ?? "sorry")
                self.Tabledata.reloadData()
                DispatchQueue.global(qos: .userInitiated).async {
                    DispatchQueue.main.async {
                        self.Tabledata.reloadData()
                    }

                }
            }
            print("Something")
            //print(snapshot)
        }, withCancel: nil)
    }
    
    var myarray = [String]()
    var Newevents:  [Event] = []
    var arrayname = [String]()
    var aname = [String]()
    //var movies: [Movie] = []

    private let database = Database.database().reference()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Newevents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mycell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        let event = Newevents[indexPath.row]
        mycell.textLabel?.text = event.Eventname
        mycell.detailTextLabel?.text = event.Links
        return mycell
    }
    
   // var myarray : [NSDictionary] = []

    @IBAction func fetchfire(_ sender: Any) {
        let ref = Database.database().reference().child("Events")
        ref.observe(.childAdded) { (snapshot) in
            //print(snapshot)
            self.myarray = []
            self.Newevents = []
            self.arrayname = []
            self.aname = []
            Database.database().reference().child("Events").observe(.childAdded, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let username = value?["Links"] as? String ?? ""
                self.aname.append(username)
                if let dict = snapshot.value as? [String: AnyObject] {
                    let event = Event()
                  //  event.setValuesForKeys(dict)
                    
                    print("jvhjvjvhjvj  \(event.Eventname ?? "why")")
                    self.Newevents.append(event)
                   // self.aname.append(xname)
                    self.arrayname.append(event.Eventname ?? "sorry")
                    self.Tabledata.reloadData()
                    DispatchQueue.global(qos: .userInitiated).async {
                        DispatchQueue.main.async {
                            self.Tabledata.reloadData()
                            event.Eventname = dict["Eventname"] as? String

                        }

                    }
                }
             //   print("Something")
                //print(snapshot)
            }, withCancel: nil)
            print("aname somehting \(self.aname)")

            print(self.Newevents)
            print(self.arrayname)
            var count = 0
            for x in snapshot.key {
                let name = snapshot.value! as? Dictionary<String, String>
                if(name?.count == 8){
                       count = count + 1
                    for each in name! {
                        //print("value is \(value)")
                        if (each.key == "Eventname"){
                            self.myarray.append(each.value)
                            self.Tabledata.reloadData()
                       }
                    }
                   // print(name)
                }

            }

        }
        Tabledata.reloadData()
//        self.fetchEvent()

    }
    
    @IBOutlet weak var Tabledata: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference()
        ref.child("Events").observe(.childAdded, with: {(snap) in
            let post = snap.value as? Event
            if let actual = post{
            //    myarray.append(actual)
                print("actuaul is \(actual)")
                self.Tabledata.reloadData()
            }
        })
//        database.child("Gmail_Id88").observeSingleEvent(of: .value, with: { snapshot in guard let value = snapshot.value as? [Event: Any] else { return }
//            print("Value: \(value)" )
//
//        })
        self.setupTableView()
        let button = UIButton(frame: CGRect(x: 20, y: 200, width: view.frame.size.width-40, height: 50))
        button.setTitle("Add stuff", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .link
        view.addSubview(button)
        button.addTarget(self, action: #selector(addNew), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    @objc private func addNew() {
        
        let object : [String: Any] = [
            "name": "something_for event",
            "Email": "email",
            "Googleid": "id",
            "Users" : "users",
        ]
        let event : [String:Any] = ["Eventname" : "place_name",
                "Photo_add" : "photo_link",
        "Links" : "websites",
        "Date_Time": "Date/Time",
        "Summary" : "Event_summary",
        "Date": "some_time",
        "Location": "location",
        "Event_id" : "event_id"
                ]
        database.child("Gmail_Id").childByAutoId().setValue(object)
        database.child("Events").childByAutoId().setValue(event)
    }
    func setupTableView() {
        Tabledata.dataSource = self
        Tabledata.delegate = self
        //Tabledata.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    

}

