//
//  MyImage.swift
//  ViewModel
//
//  Created by Garric G. Nahapetian on 4/19/17.
//  Copyright © 2017 SwiftCoders. All rights reserved.
//

import UIKit

struct Model {
    let image: UIImage
    
    init?(photoDictionary: [String: AnyObject]) {
        guard
            let farmID = photoDictionary["farm"] as? Int,
            let serverID = photoDictionary["server"] as? String,
            let photoID = photoDictionary["id"] as? String,
            let secret = photoDictionary["secret"] as? String
            else { return nil }
        
        let imageResourceString = "https://farm\(farmID).staticflickr.com/\(serverID)/\(photoID)_\(secret)_z.jpg"
        
        guard
            let encoded = imageResourceString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
            let url = URL(string: encoded),
            let data = try? Data(contentsOf: url),
            let image = UIImage(data: data) else { return nil }
        
        self.image = image
    }
}
