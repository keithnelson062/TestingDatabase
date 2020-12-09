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
  //  loadevents()
    @IBOutlet weak var eventCV: UICollectionView!
    
    @IBOutlet weak var navigation: UINavigationItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        // Do any additional setup after loading the view.
    }
    
    func setupCollectionView() {
        eventCV.dataSource = self
        eventCV.delegate = self
                DispatchQueue.global(qos: .userInitiated).async {
                    
                    
                    self.loadevents()
                   // self.createSpinnerView(uiView: UIView)
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
        let cell = eventCV.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventViewCell
        cell.setCell(name: "name", description: "description description description description description description description description")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "eventSelected", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if (segue.identifier == "eventSelected"){
            if let detailedVC = segue.destination as? EventDetailedViewController {
                detailedVC.name = "TEST EVENT"
                detailedVC.desc = "description description description description description"
            }
        }
        if (segue.identifier == "addEvent"){
            if let detailedVC = segue.destination as? AddEventViewController {
                
            }
        }
        
    }

    func loadevents(){
        Database.database().reference().child("Events").observe(.value, with: { (snapshot) in
        let value = snapshot.value as? NSDictionary // casting as dictionary
        let ekeys = snapshot.key
        if let dict = snapshot.value as? [String : Any]{ //casting as anyobject
           let ekeys = dict.keys
            
            var event = Event() // creating new event object
            for x in ekeys {
                //print(dict[x]!)
                event.setValuesForKeys(dict[x]! as! [String : Any]) // set to dict
                self.events.append(event)
              //  event.setValue(dict[x]!, forKey: x) // set to dict
            }
//            print(event.Eventname!)
            for y in self.events {
                print(y.Links!)
                print(y.Photo_add!)

            }

           // print(ekeys)
          //  print(dict)
        }
            //print(value!)
            //print(" the keys are "+keys)
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
