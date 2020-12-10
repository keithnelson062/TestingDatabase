//
//  EventDetailedViewController.swift
//  SafeConnect
//
//  Created by Jessica Wallen on 11/20/20.
//  Copyright © 2020 Michelle Katz. All rights reserved.
//

import UIKit
import MapKit
class EventDetailedViewController: UIViewController {
    var name: String = ""
    var desc: String = ""
    var loc: String = ""
    var contact: String = ""
    var td: String = ""
    var covid: String = ""

    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDescription: UITextView!
    @IBOutlet weak var location: UITextView!
    @IBOutlet weak var contactInfo: UITextView!
    @IBOutlet weak var timeDate: UITextView!
    @IBOutlet weak var covidPrecautions: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventName.text = "Name: " + name
        eventDescription.text = "Description: " + desc
        location.text = "Location: " + loc
        contactInfo.text = "Contact Info: " + contact
        timeDate.text = "Date/Time: " + td
        covidPrecautions.text = "COVID-19 Precautions: " + covid

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

//}
