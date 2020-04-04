//
//  MainViewController.swift
//  Rush
//
//  Created by gio emiliano on 2020-02-04.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation



class MainViewController : UIViewController {
    @IBOutlet weak var placesSegmentedController: UISegmentedControl!
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var tableViewPlaces: UITableView!
    
    var locationManager: CLLocationManager?

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var viewMapAnnotation: UIView!
    @IBOutlet weak var mapViewLabelAddress: UILabel!
    @IBOutlet weak var mapViewLabelDistance: UILabel!
    @IBOutlet weak var mapViewLogo: UIImageView!
    @IBOutlet weak var mapViewLabelStatus: UILabel!
    @IBOutlet weak var mapViewRateStar1: UIImageView!
    @IBOutlet weak var mapViewHours: UILabel!
    @IBOutlet weak var mapViewLabelName: UILabel!
    @IBOutlet weak var mapViewRateStar2: UIImageView!
    @IBOutlet weak var mapViewRateStar3: UIImageView!
    @IBOutlet weak var mapViewRateStar4: UIImageView!
    @IBOutlet weak var mapViewRateStar5: UIImageView!
    
    
    var places : [Place] = []
    
    var latitude : Double = 0.0
    var longitude : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //locationManager.requestLocation()
        
       // Webservice.shared().getPlaces()
        
        loadAllPlaces()
        viewMapAnnotation.isHidden = true
        
        
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
            
            map.delegate = self
        
        
        tableViewPlaces.delegate = self
        tableViewPlaces.dataSource = self
        
        map.isHidden = true
        tableViewPlaces.isHidden = false
        
        //addNotation(latitude: 43.785309, longitude: -79.226384)
       // addNotation(latitude: 43.691200, longitude: -79.325673)

        
        searchBar.delegate = self
            
    }
    
    @IBAction func changeList(_ sender: UISegmentedControl) {
        if placesSegmentedController.selectedSegmentIndex == 0 {
            map.isHidden = true
            tableViewPlaces.isHidden = false
            viewMapAnnotation.isHidden = true

        } else {
            map.isHidden = false
            tableViewPlaces.isHidden = true
        }
    }
    
    
    func loadAllPlaces(){
        Webservice.shared().getAllPlaces { (places, error) in
            
            self.places = places
            self.tableViewPlaces.reloadData()
            
            for place in places {
                self.addNotation(latitude: place.latitude, longitude: place.longitude)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SeguePlace" {
            if  let viewController = segue.destination as? PlaceViewController {
                viewController.place = places[0]
            }
        }
    }
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell") as! PlaceTableViewCell
             
             let place = places[indexPath.row]
             cell.setup(place: place)
             
             return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 160
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = places[indexPath.row]
        performSegue(withIdentifier: "SeguePlace", sender: place)

    }
    
    
}

extension MainViewController : CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           if status == .authorizedAlways {
               manager.startUpdatingLocation()

           }
       }
       
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
           print("locations = \(location.latitude) \(location.longitude)")
           
           
           self.latitude = location.latitude
           self.longitude = location.longitude
           
           let span = MKCoordinateSpan(latitudeDelta: 0.2,longitudeDelta: 0.2)
           let centre = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
           let region = MKCoordinateRegion(center: centre, span: span)
           map.setRegion(region, animated: true)
           
           let annotation = MKPointAnnotation()
           annotation.coordinate = centre
         //  map.addAnnotation(annotation)


       }
    
    func addNotation(latitude: Double, longitude: Double){
        
        
        let span = MKCoordinateSpan(latitudeDelta: 0.2,longitudeDelta: 0.2)
        let centre = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: centre, span: span)
        map.setRegion(region, animated: true)
                  
        let annotation = MKPointAnnotation()
        annotation.coordinate = centre
        
        map.addAnnotation(annotation)

        
        
    }
}


extension MainViewController: MKMapViewDelegate {
  // 1
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    // 2
    //guard let annotation = annotation as? Artwork else { return nil }
    // 3
    let identifier = "marker"
    var view: MKMarkerAnnotationView
    // 4
    if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
      as? MKMarkerAnnotationView {
      dequeuedView.annotation = annotation
      view = dequeuedView
    } else {
      // 5
      view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
      view.canShowCallout = true
      view.calloutOffset = CGPoint(x: -5, y: 5)
      view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    }
    return view
  }
    
    func mapView(_ mapView: MKMapView,
            didSelect view: MKAnnotationView)
    {
        // 1
        if view.annotation is MKUserLocation
        {
           // Don't proceed with custom callout
           return
        }
        // 2
        
        if let coordinate = view.annotation?.coordinate {
            mapView.setCenter(coordinate, animated: true)
            
            let place = searchByLat(lat:Double(coordinate.latitude))
            
            setup(place: place)
            viewMapAnnotation.isHidden = false

        }
        
       
        
        
    }
    
    func searchByLat(lat: Double)->Place {
        for place in places {
            if place.latitude == lat {
                return place
            }
        }
        
        return Place()
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool){
        
        viewMapAnnotation.isHidden = true
        for annotation in mapView.annotations {
            mapView.deselectAnnotation(annotation, animated: true)
        }
        
    }
    
    func setup(place: Place) {
        
        mapViewLabelName.text = place.name
        mapViewLabelAddress.text = place.address
        mapViewLogo.image = UIImage(named:place.logoURL)
        mapViewLogo.layer.cornerRadius = mapViewLogo.frame.width/2
        viewMapAnnotation.materialCardLayout()
       // viewMapAnnotation.layer.cornerRadius = 5
        
    }
    
}

extension MainViewController : UISearchBarDelegate {
    
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    
    var result : [Place] = []
    
    for place in places {
        if place.name.contains(searchText) {
            result.append(place)
        }
    }
    
    if result.count == 0 {
        loadAllPlaces()
        return
    }
    
    places = result
    self.tableViewPlaces.reloadData()
    
    
    print("Search: " + searchText)
    
    }
    
//    var searchedPlaces = places.contains(where: { (place) -> Bool in
//
//        if place.name.contains(searchBar.text) {
//            return true
//        }
//        return false
//    })
//
//    print(searchedPlaces)
//
}




 



