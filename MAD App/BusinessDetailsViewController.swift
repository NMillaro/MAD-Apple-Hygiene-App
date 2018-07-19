//
//  BusinessDetailsViewController.swift
//  MAD App
//
//  Created by Nicholas Millard on 20/04/2018.
//  Copyright © 2018 Nicholas Millard. All rights reserved.
//

import UIKit

class BusinessDetailsViewController: UIViewController {
    
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var businessDetails: UILabel!
    var businessR: String!
    @IBOutlet weak var businessRating: UIImageView!
    @IBOutlet weak var businessRDate: UILabel!
    @IBOutlet weak var businessAdd1: UILabel!
    @IBOutlet weak var businessAdd2: UILabel?
    @IBOutlet weak var businessAdd3: UILabel?
    @IBOutlet weak var businessPCode: UILabel!
    
    var theBusiness: Business?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        businessName.text = theBusiness?.BusinessName
        businessRDate.text = "Rated on: " + (theBusiness?.RatingDate)!
        businessAdd1.text = theBusiness?.AddressLine1
        businessAdd2?.text = theBusiness?.AddressLine2
        businessAdd3?.text = theBusiness?.AddressLine3
        businessPCode.text = theBusiness?.PostCode
        
        
        businessR = theBusiness?.RatingValue
        if businessR == "5" {
            businessRating.image = UIImage.init(imageLiteralResourceName: "fhrs_5_en-gb.jpg")
        } else if  businessR == "4" {
            businessRating.image = UIImage.init(imageLiteralResourceName: "fhrs_4_en-gb.jpg")
        } else if  businessR == "3" {
            businessRating.image = UIImage.init(imageLiteralResourceName: "fhrs_3_en-gb.jpg")
        } else if  businessR == "2" {
            businessRating.image = UIImage.init(imageLiteralResourceName: "fhrs_2_en-gb.jpg")
        } else if  businessR == "1" {
            businessRating.image = UIImage.init(imageLiteralResourceName: "fhrs_1_en-gb.jpg")
        } else if  businessR == "0" {
            businessRating.image = UIImage.init(imageLiteralResourceName: "fhrs_1_en-gb.jpg")
        }else {
            businessRating.image = UIImage.init(imageLiteralResourceName: "fhis_exempt.jpg")
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
