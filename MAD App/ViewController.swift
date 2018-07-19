//
//  ViewController.swift
//  MAD App
//
//  Created by Nicholas Millard on 09/04/2018.
//  Copyright © 2018 Nicholas Millard. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    var AllBusinesses = [Business]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllBusinesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyBusinessTableViewCell
        cell.textLabel?.text = "\(AllBusinesses[indexPath.row].BusinessName)"
        if AllBusinesses[indexPath.row].RatingValue == "5" {
            cell.businessRating.image = UIImage.init(imageLiteralResourceName: "fhrs_5_en-gb-1.jpg")
        } else if  AllBusinesses[indexPath.row].RatingValue == "4" {
               cell.businessRating.image = UIImage.init(imageLiteralResourceName: "fhrs_4_en-gb-1.jpg")
        } else if  AllBusinesses[indexPath.row].RatingValue == "3" {
            cell.businessRating.image = UIImage.init(imageLiteralResourceName: "fhrs_3_en-gb-1.jpg")
        } else if  AllBusinesses[indexPath.row].RatingValue == "2" {
            cell.businessRating.image = UIImage.init(imageLiteralResourceName: "fhrs_2_en-gb-1.jpg")
        } else if  AllBusinesses[indexPath.row].RatingValue == "1" {
            cell.businessRating.image = UIImage.init(imageLiteralResourceName: "fhrs_1_en-gb-1.jpg")
        } else if  AllBusinesses[indexPath.row].RatingValue == "0" {
            cell.businessRating.image = UIImage.init(imageLiteralResourceName: "fhrs_1_en-gb-1.jpg")
        }else {
            cell.businessRating.image = UIImage.init(imageLiteralResourceName: "fhis_exempt-1.jpg")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print("You selected row \(indexPath.row) which is \(Business[indexPath.row])")
    }
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.dataSource = self
        myTableView.delegate = self
        
        
        
        addNavBarImage()
        
        
        //ask for permissions
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
            
        
        // start location manager after permissions granted
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            
            
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            // updates every 50 meters moved
            locationManager.distanceFilter = 50
            locationManager.startUpdatingLocation()
            print("Updating location...")
            //locationManager.startMonitoringSignificantLocationChanges()
        }
        
       
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func addNavBarImage() {
        let navController = navigationController!
        
        let searchIcon = #imageLiteral(resourceName: "search-89")
        let mapIcon = #imageLiteral(resourceName: "map")
        let mapButton = UIBarButtonItem(title: "Map", style: UIBarButtonItemStyle.done, target: self, action: #selector(TapMapButton))
        mapButton.image = mapIcon
        self.navigationItem.rightBarButtonItem = mapButton
        
        let searchButton = UIBarButtonItem(title: "Search", style: UIBarButtonItemStyle.done, target: self, action: #selector(TapSearchButton))
        searchButton.image = searchIcon
        self.navigationItem.leftBarButtonItem = searchButton
        
        
        let image = #imageLiteral(resourceName: "foodicon")
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 2 - (image.size.width) / 2
        let bannerY = bannerHeight / 2 - (image.size.height) / 2
            
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        
        navigationItem.titleView = imageView
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        //fetch location
        let lat = String(format: "%f", (locationManager.location?.coordinate.latitude)!)
        let lon = String(format: "%f", (locationManager.location?.coordinate.longitude)!)
        
        print("Lat: " + lat + " Lon:" + lon)
        
        
        let url = URL(string: "http://radikaldesign.co.uk/sandbox/hygiene.php?op=s_loc&lat=" + (lat) + "&long=" + (lon))
        print(url!) //shows url to confirm working
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {print("error with data"); return}
            do {self.AllBusinesses = try JSONDecoder().decode([Business].self, from: data);
                
                //interrupts main thread to update table with newly retrieved data
                DispatchQueue.main.async {
                    print("Updating TableView")
                    self.myTableView.reloadData()
                }
                //print size of businesses array
                print(self.AllBusinesses.count)
                // print name of first business
                print("Nearest: " + self.AllBusinesses[0].BusinessName)
            }catch let err {
                print("Error", err)
                
            }
            }.resume() //starts network call
        
        
    }
    
    @objc func TapMapButton(for segue: UIStoryboardSegue, sender: UIBarButtonItem){
        self.performSegue(withIdentifier: "map", sender: self)
        
    }
    
    @objc func TapSearchButton(sender: UIBarButtonItem){
        self.performSegue(withIdentifier: "search", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationItem.title = nil
        
        if segue.identifier == "map" {
            let dvc = segue.destination as! MapViewController
            dvc.lat = locationManager.location?.coordinate.latitude
            dvc.lon = locationManager.location?.coordinate.longitude
            dvc.locations = AllBusinesses

            
        }
        
        
        if let cell = sender as? UITableViewCell {
            let i = myTableView.indexPath(for: cell)!.row
            
            if segue.identifier == "details" {
                
                let dvc = segue.destination as! BusinessDetailsViewController
                dvc.theBusiness = self.AllBusinesses[i]
            }
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

