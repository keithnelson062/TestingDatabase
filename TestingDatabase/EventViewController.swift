//
//  EventViewController.swift
//  SafeConnect
//
//  Created by Michelle Katz on 11/19/20.
//  Copyright © 2020 Michelle Katz. All rights reserved.
//

import UIKit

class EventViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var events: [Event] = []
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
        eventCV.register(EventViewCell.self, forCellWithReuseIdentifier: "eventCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
