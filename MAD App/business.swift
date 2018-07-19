//
//  business.swift
//  MAD App
//
//  Created by Nicholas Millard on 19/04/2018.
//  Copyright © 2018 Nicholas Millard. All rights reserved.
//

import Foundation

class Business: Codable {
    let id: String
    let BusinessName: String
    let AddressLine1: String
    let AddressLine2: String?
    let AddressLine3: String?
    let PostCode: String
    let RatingValue: String
    let RatingDate: String
    let Longitude: String
    let Latitude: String
    let DistanceKM: String
}
