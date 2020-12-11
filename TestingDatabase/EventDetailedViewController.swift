//
//  EventDetailedViewController.swift
//  SafeConnect
//
//  Created by Jessica Wallen on 11/20/20.
//  Copyright © 2020 Michelle Katz. All rights reserved.
// calendar from here: https://www.ioscreator.com/tutorials/add-event-calendar-ios-tutorial

import UIKit
import EventKit
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
    @IBOutlet weak var timeDate: UITextView!
    @IBOutlet weak var covidPrecautions: UITextView!
    
    @IBAction func addToCalendar(_ sender: Any) {
        let eventStore = EKEventStore()
            
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            insertEvent(store: eventStore)
        case .denied:
            print("Access denied")
        case .notDetermined:
            eventStore.requestAccess(to: .event, completion:
              {[weak self] (granted: Bool, error: Error?) -> Void in
                  if granted {
                    self!.insertEvent(store: eventStore)
                  } else {
                        print("Access denied")
                  }
            })
        default:
            print("Case default")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventName.text = name
        eventDescription.text = "Description: " + desc
        location.text = "Location: " + loc
        timeDate.text = "Date/Time: " + td
        covidPrecautions.text = "COVID-19 Precautions: " + covid
       }
    
    func insertEvent(store: EKEventStore) {
        let calendars = store.calendars(for: .event)
        for calendar in calendars {
            if calendar.title == "Calendar" {
                let formatter = DateFormatter()
                formatter.dateFormat = "EEE MMM d, yyyy @ K:mm a"
                let startDate = formatter.date(from: td)
                let endDate = startDate?.addingTimeInterval(60 * 60)
                let event = EKEvent(eventStore: store)
                event.calendar = calendar
                event.title = name
                event.startDate = startDate
                event.endDate = endDate
                    
                do {
                    try store.save(event, span: .thisEvent)
                    let alert = UIAlertController(title: "Event", message: "Event Successfully Added to Calendar", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                catch {
                   print("Error saving event in calendar")
                    let alert = UIAlertController(title: "Event", message: "Could not save event to calendar", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
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

//}
