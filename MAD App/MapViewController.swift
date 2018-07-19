//
//  MapViewController.swift
//  MAD App
//
//  Created by Nicholas Millard on 20/04/2018.
//  Copyright © 2018 Nicholas Millard. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var myMapView: MKMapView!
     var locations = [Business]()
     
     var lat: Double? = nil
     var lon: Double? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //set zoom, location, region
     let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01,0.01)
     let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat!,lon!)
     let region: MKCoordinateRegion = MKCoordinateRegionMake(location,span)
     
     let annotation = MKPointAnnotation()
     annotation.coordinate = location
     annotation.title = "You're here!"
     myMapView.addAnnotation(annotation)
     
     myMapView.setRegion(region, animated: true)
     
     for l in locations {
          let annotation = CustomPin()
          annotation.coordinate = CLLocationCoordinate2DMake(Double(l.Latitude)!, Double (l.Longitude)!)
          annotation.image = UIImage(named: "foodpin")
          annotation.title = l.BusinessName
          annotation.subtitle = l.RatingValue
          myMapView.addAnnotation(annotation)
     }
     
        
        // Do any additional setup after loading the view.
    }
     func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
          guard !annotation.isKind(of:MKUserLocation.self) else {return nil}
          let annotationIdentifier = "AnnotationIdentifier"
          var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
          
          if annotationView == nil {
               annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
               annotationView!.canShowCallout = true
          }
          else {
               annotationView!.annotation = annotation
          }
          let customPointAnnotation = annotation as! CustomPin
          annotationView!.image = customPointAnnotation.image
          return annotationView
     }
    
     
     
}
