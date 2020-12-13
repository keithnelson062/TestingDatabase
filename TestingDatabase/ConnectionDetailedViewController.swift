//
//  ConnectionDetailedViewController.swift
//  SafeConnect
//
//  Created by Jessica Wallen on 11/20/20.
//  Copyright © 2020 Michelle Katz. All rights reserved.
//

import UIKit

class ConnectionDetailedViewController: UIViewController{
    
    var name: String = ""
    var username: String = ""
    var email:String = ""
    var phoneNumber: String = ""
    var desc:String = ""
    var profileImage: UIImage?
    
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var profileDescLabel: UITextView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text =  name
        emailLabel.text = email
        phoneNumberLabel.text = phoneNumber
        profileDescLabel.text = desc
        
        // Do any additional setup after loading the view.
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
