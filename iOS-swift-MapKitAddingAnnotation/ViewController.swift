//
//  ViewController.swift
//  iOS-swift-MapKitAddingAnnotation
//
//  Created by IMCS2 on 8/10/19.
//  Copyright © 2019 com.phani. All rights reserved.
//

import UIKit
import MapKit
import CoreData

var Names: [String] = []
var labels: [String] = []
var text: [String] = []
var datas: [String] = []
var Corelat: [String] = []
var Corelon: [String] = []

var savingdata: [NSManagedObject] = []
class ViewController: UIViewController, MKMapViewDelegate {
    var LatCorrdinate: String = ""
    var LongCoordinate: String = ""
    
    @IBOutlet weak var mapView: MKMapView!
    
    var keyLat: Float = 32.888983
    var keyLon: Float = -96.954338
    var selectedAnnotation: MKPointAnnotation?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        let longPressRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        longPressRecogniser.minimumPressDuration = 0.5
        mapView.addGestureRecognizer(longPressRecogniser)
        mapView.mapType = MKMapType.standard
        
        let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(keyLat), longitude: CLLocationDegrees(keyLon))
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
    }
    
    @objc func handleTap(_ gestureReconizer: UILongPressGestureRecognizer){
        let location = gestureReconizer.location(in: mapView)
        let coodinate = mapView.convert(location, toCoordinateFrom: mapView)
        // self.save(itemTosave: text, lati: Names, longi: labels)
        
        //Adding annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = coodinate
        mapView.addAnnotation(annotation)
    }
    
    
    
    
    
    
    
    
    //help to get the exact corrinate
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let latValStr : String = String(format: "%0.02f", Float((view.annotation?.coordinate.latitude)!))
        let lonValStr : String = String(format: "%0.02f", Float((view.annotation?.coordinate.longitude)!))
        //print("Latitude:\(latValStr) & longitude\(lonValStr)"
        Names.append(latValStr)
        labels.append(lonValStr)
        let alert = UIAlertController(title: "Some Title", message: "Enter a text", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = "  "
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            let addingText = (textField!.text)!
            text.append(addingText)
            
        }))
        self.present(alert, animated: true, completion: nil)
        
        self.save(itemTosave: text, lati: Names, longi: labels)
        fetchingData()
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        let myDouble = Double(LatCorrdinate)
        let myDoubles = Double(LongCoordinate)
        if myDouble == nil && myDoubles == nil{
            print("Nil")
        }else{
            let latitude: CLLocationDegrees = myDouble!
            let longitude: CLLocationDegrees = myDoubles!
            let latDelta: CLLocationDegrees = 0.05
            let LongDelata:CLLocationDegrees = 0.05
            let coordiantes = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: LongDelata)
            let regions = MKCoordinateRegion(center: coordiantes, span: span)
            mapView.setRegion(regions, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordiantes
            annotation.title = "Found!"
            mapView.addAnnotation(annotation)
        }
    }
    
    
    
    
    
    
    
    
    func save(itemTosave: [String], lati: [String], longi: [String]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Place",
                                                in: managedContext)!
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        person.setValue(itemTosave, forKeyPath: "names")
        person.setValue(lati, forKeyPath: "latt")
        person.setValue(longi, forKeyPath: "longg")
        
        do {
            try managedContext.save()
            savingdata.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    
    
    
    func fetchingData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        //Grabbing the xcode data model
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Place")
        do {
            savingdata = try managedContext.fetch(fetchRequest)
            for saving in savingdata{
                datas = (saving.value(forKeyPath: "names") as? [String])!
                Corelat = (saving.value(forKeyPath: "latt") as? [String])!
                Corelon = (saving.value(forKeyPath: "longg") as? [String])!
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        print(datas)
        print(Corelat)
        print(Corelon)
        
        
    }
}
