//
//  ConnectionsViewController.swift
//  SafeConnect
//
//  Created by Michelle Katz on 11/19/20.
//  Copyright © 2020 Michelle Katz. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseCore

class ConnectionsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate{
    @IBOutlet weak var navigation: UINavigationItem!
    @IBOutlet weak var connectionCV: UICollectionView!
    var connections: [Connection] = []
    var newusers: [Connection] = []
    var detailedVC = ConnectionDetailedViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        getPosts()
        // Do any additional setup after loading the view.
    }
    
    func setupCollectionView() {
        connectionCV.dataSource = self
        connectionCV.delegate = self
       // searchusers.delegate = self
         DispatchQueue.global(qos: .userInitiated).async {
                self.loadusers()
                DispatchQueue.main.async {
                    self.connectionCV.reloadData()
                }
        }
        search.delegate = self
        connectionCV.register(ConnectionViewCell.self, forCellWithReuseIdentifier: "connectionCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return connections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = connectionCV.dequeueReusableCell(withReuseIdentifier: "connectionCell", for: indexPath)
            as! ConnectionViewCell
        cell.setCell(name: connections[indexPath.row].name, description: connections[indexPath.row].Email)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = connections[indexPath.row]
        detailedVC.name = selected.name
        detailedVC.email = selected.Email
        detailedVC.desc = selected.Profile_Des
        detailedVC.phoneNumber = selected.PhoneNumber
        performSegue(withIdentifier: "connectionSelected", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if (segue.identifier == "connectionSelected"){
            if let detailVC = segue.destination as? ConnectionDetailedViewController {
                detailVC.name = detailedVC.name
                detailVC.email = detailedVC.email
                detailVC.desc = detailedVC.desc
                detailVC.phoneNumber = detailedVC.phoneNumber
            }
        }
    }
    func loadusers(){

        Database.database().reference().child("Users").observe(.value, with: { (snapshot) in
            if let dict = snapshot.value as? [String : Any]{ //casting as anyobject
               let ekeys = dict.keys
                self.connections = []
                for x in ekeys {
                    let User = Connection()
                    User.setValuesForKeys(dict[x]! as! [String : Any]) // set to dict
                    self.connections.append(User)
                }
            }
        self.connectionCV.reloadData()
        }, withCancel: nil)
    }
    
    @IBOutlet weak var search: UISearchBar!
    //@IBOutlet weak var usersearchBar: UISearchBar!
    func searchs(query: String){
    self.connections = []

    let databaseRef = Database.database().reference()
    databaseRef.child("Users").queryOrdered(byChild: "\(query)").observe( .childAdded, with: { (snapshot) in
           if let dict = snapshot.value as? [String : Any] { //casting as anyobject
            _ = dict.keys
            let User = Connection()
            User.setValuesForKeys(dict) // set to dict
            self.connections.append(User)
            self.connectionCV.reloadData()
           }
        })
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         let delay = 1
         DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            if let text = self.search.text {
                if(text != "") {
                    self.searchs(query: text)
                    self.connectionCV.reloadData()
                }
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
    func getPosts() {
      let databaseRef = Database.database().reference()
      databaseRef.child("name").queryOrderedByKey().observe( .childAdded, with: { (snapshot) in
        if let dict = snapshot.value as? [String : Any] { //casting as anyobject
            let branduser = Connection()
            branduser.setValuesForKeys(dict)
            self.newusers.append(branduser)// set to dict
        }
     
    })
    }

}
