//
//  EventViewController.swift
//  SafeConnect
//
//  Created by Michelle Katz on 11/19/20.
//  Copyright © 2020 Michelle Katz. All rights reserved.
//


import UIKit
import FirebaseDatabase
import FirebaseCore


class EventViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var events: [Event] = []
    var keys = [String]()
    var detailedVC = EventDetailedViewController()
  //  loadevents()
    @IBOutlet weak var eventCV: UICollectionView!
    @IBOutlet weak var navigation: UINavigationItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        // Do any additional setup after loading the view.
        print("viewDidLoad done")
    }
    
    func setupCollectionView() {
        eventCV.dataSource = self
        eventCV.delegate = self
        DispatchQueue.global(qos: .userInteractive).async {
            self.loadevents()
            DispatchQueue.main.async {
                self.eventCV.reloadData()
            }
        }
        eventCV.register(EventViewCell.self, forCellWithReuseIdentifier: "eventCell")

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cell")
        let cell = eventCV.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventViewCell
        cell.setCell(name: events[indexPath.row].Eventname, description: events[indexPath.row].Summary)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = events[indexPath.row]
        detailedVC.name = selected.Eventname
        detailedVC.desc = selected.Summary
        detailedVC.td = selected.Date_Time
        detailedVC.covid = selected.Event_id
        detailedVC.loc = selected.Location
        performSegue(withIdentifier: "eventSelected", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if (segue.identifier == "eventSelected"){
            if let detailVC = segue.destination as? EventDetailedViewController {
                detailVC.name = detailedVC.name
                detailVC.desc = detailedVC.desc
                detailVC.contact = detailedVC.contact
                detailVC.td = detailedVC.td
                detailVC.covid = detailedVC.covid
                detailVC.loc = detailedVC.loc
            }
        }
        if (segue.identifier == "addEvent"){
            if segue.destination is AddEventViewController {
                
            }
        }
        
    }

    func loadevents(){
        Database.database().reference().child("Events").observe(.value, with: { (snapshot) in
        if let dict = snapshot.value as? [String : Any]{ //casting as anyobject
           let ekeys = dict.keys
            self.events = []
            for x in ekeys {
                let event = Event() // creating new event object
                event.setValuesForKeys(dict[x]! as! [String : Any]) // set to dict
                self.events.append(event)
            }
        }
            print(self.events)
            self.eventCV.reloadData()
    }, withCancel: nil)
        
        
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
