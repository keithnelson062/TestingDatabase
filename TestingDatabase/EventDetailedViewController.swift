//
//  EventDetailedViewController.swift
//  SafeConnect
//
//  Created by Jessica Wallen on 11/20/20.
//  Copyright © 2020 Michelle Katz. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class EventDetailedViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
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
    @IBOutlet weak var map: MKMapView!
    
    
 func getLocation(from address: String, completion: @escaping (_ locations: CLLocationCoordinate2D?)-> Void) {
     let geocoder = CLGeocoder()
     geocoder.geocodeAddressString(address) { (placemarks, error) in
         guard let placemarks = placemarks,
         let locations = placemarks.first?.location?.coordinate else {
             completion(nil)
             return
         }
         completion(locations)
     }
 }

   
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
//    private var distanceBetweenCoordinates: Double {
//
//        var latitude = self.map.annotations[0].coordinate.latitude
//        var longitude = self.map.annotations[0].coordinate.longitude
//          let to = CLLocation(latitude: latitude, longitude: longitude)
//
//          latitude = self.locationManager.location?.coordinate.latitude as! CLLocationDegrees
//        longitude = self.locationManager.location?.coordinate.longitude as! CLLocationDegrees
//          let from = CLLocation(latitude: latitude, longitude: longitude)
//
//          let distance = to.distance(from: from)
//
//          return distance
//      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventName.text = "Name: " + name
        eventDescription.text = "Description: " + desc
        location.text = loc
        contactInfo.text = "Contact Info: " + contact
        timeDate.text = td
        covidPrecautions.text = "COVID-19 Precautions: " + covid
// map.mapType = .satellite
//        var cors = getLocation(from: location.text) { locations in
//           print(locations.debugDescription)
//            let Event_location = PointOfInterest(title: self.eventName.text!, locationName: self.location.text, coordinate: CLLocationCoordinate2DMake(locations!.latitude, locations!.longitude))
//            //
//            self.map.addAnnotation(Event_location)
       }

        
        
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
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

//}
