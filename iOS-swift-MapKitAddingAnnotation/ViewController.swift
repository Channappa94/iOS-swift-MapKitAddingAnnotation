//
//  ViewController.swift
//  iOS-swift-MapKitAddingAnnotation
//
//  Created by IMCS2 on 8/10/19.
//  Copyright © 2019 com.phani. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var keyLat: Float = 32.888983
    var keyLon: Float = -96.954338
    var selectedAnnotation: MKPointAnnotation?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView.delegate = self
        
        let longPressRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        longPressRecogniser.minimumPressDuration = 0.5
        mapView.addGestureRecognizer(longPressRecogniser)
        
        mapView.mapType = MKMapType.standard
        
        let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(keyLat), longitude: CLLocationDegrees(keyLon))
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "United States"
        annotation.subtitle = "Irving"
        
        mapView.addAnnotation(annotation)
    }
    
    @objc func handleTap(_ gestureReconizer: UILongPressGestureRecognizer){
        let location = gestureReconizer.location(in: mapView)
        let coodinate = mapView.convert(location, toCoordinateFrom: mapView)
        
        //Adding annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = coodinate
        annotation.title = "latitude: " + String(format: "%0.02f", annotation.coordinate.latitude) + " longitude: " + String(format: "%0.02f", annotation.coordinate.longitude)
        print(coodinate)
        mapView.addAnnotation(annotation)
        
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let latValStr : String = String(format: "%0.02f", Float((view.annotation?.coordinate.latitude)!))
        let lonValStr : String = String(format: "%0.02f", Float((view.annotation?.coordinate.longitude)!))
        print("Latitude:\(latValStr) & longitude\(lonValStr)")
        
        let geoLattitude = Double(latValStr)
        let geoLongitude = Double(lonValStr)
        
        //This will help to get location name using coordinates
//        let geocoder = CLGeocoder()
//        let location = CLLocation(latitude: geoLattitude!, longitude: geoLongitude!)
//        geocoder.reverseGeocodeLocation(location) {
//            (placemarks, error) -> Void in
//            if let placemarks = placemarks, placemarks.count > 0 {
//                let placemark = placemarks[0]
//                print(placemark.addressDictionary!)
//            }
//        }
        
        
        
    }
    

}
