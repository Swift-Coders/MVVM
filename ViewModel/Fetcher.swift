//
//  Fetcher.swift
//  ViewModel
//
//  Created by Garric G. Nahapetian on 4/19/17.
//  Copyright © 2017 SwiftCoders. All rights reserved.
//

import Foundation

protocol Fetching {
    func fetch(withQueryString queryString: String, completion: @escaping (NSDictionary) -> Void)
}

class Fetcher: Fetching {

    func fetch(withQueryString queryString: String, completion: @escaping (NSDictionary) -> Void) {
        let encoded = queryString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let url = URL(string: encoded)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            do {
                let object = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
                
                completion(object!)
                
            } catch {
                print(error)
            }
            
        }) .resume()
    }
}
