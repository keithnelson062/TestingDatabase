//
//  ConnectionsViewController.swift
//  SafeConnect
//
//  Created by Michelle Katz on 11/19/20.
//  Copyright © 2020 Michelle Katz. All rights reserved.
//

import UIKit

class ConnectionsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var navigation: UINavigationItem!
    @IBOutlet weak var connectionCV: UICollectionView!
    var connections: [Connection] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        // Do any additional setup after loading the view.
    }
    
    func setupCollectionView() {
        connectionCV.dataSource = self
        connectionCV.delegate = self
        connectionCV.register(ConnectionViewCell.self, forCellWithReuseIdentifier: "connectionCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = connectionCV.dequeueReusableCell(withReuseIdentifier: "connectionCell", for: indexPath)
            as! ConnectionViewCell
        cell.setCell(name: "name", description: "description description description description description description description description")
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "connectionSelected", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if (segue.identifier == "connectionSelected"){
            if let detailedVC = segue.destination as? ConnectionDetailedViewController {
                detailedVC.name = "TEST NAME"
                detailedVC.desc = "description description description description description"
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
