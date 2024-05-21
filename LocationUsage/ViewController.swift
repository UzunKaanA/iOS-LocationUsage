//
//  ViewController.swift
//  LocationUsage
//
//  Created by Kaan Uzun on 21.05.2024.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapKit: MKMapView!
    @IBOutlet weak var lblLatitude: UILabel!
    @IBOutlet weak var lblLongitude: UILabel!
    @IBOutlet weak var lblSpeed: UILabel!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //will reduce the phone battery
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        //28.4813756,-81.5074789
    }

}

extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations[locations.count-1]
        
        let latitude = lastLocation.coordinate.latitude
        let longitude = lastLocation.coordinate.longitude
        
        lblLatitude.text =  "Latitude  : \(latitude)"
        lblLongitude.text = "Longitude : \(longitude)"
        lblSpeed.text =     "Speed     : \(lastLocation.speed)"
        
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude) //Location
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5) //Zoom
        let region = MKCoordinateRegion(center: location, span: span)
        mapKit.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = location
        pin.title = "\(latitude) - \(longitude)"
        pin.subtitle = "Subtitle"
        mapKit.addAnnotation(pin)
        
        mapKit.showsUserLocation = true
        
    }
    
    
}

