//
//  AddEventViewController.swift
//  SafeConnect
//
//  Created by Jessica Wallen on 11/20/20.
//  Copyright © 2020 Michelle Katz. All rights reserved.
//

import UIKit

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
    
    
    @IBAction func addEvent(_ sender: Any) {
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
