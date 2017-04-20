//
//  ViewModel.swift
//  ViewModel
//
//  Created by Garric G. Nahapetian on 4/19/17.
//  Copyright © 2017 SwiftCoders. All rights reserved.
//

import UIKit

protocol ViewModeling {
    var numberOfSections: Int { get }
    func numberOfRows(inSection section: Int) -> Int
    func itemForRow(at indexPath: IndexPath) -> UIImage
    func refresh(completion: @escaping () -> Void)
}

class ViewModel: ViewModeling {
    var numberOfSections: Int = 1
    
    private let fetcher: Fetching
    private let queryString: String
    
    private var items: [Model] = []
    
    init(fetcher: Fetching, queryString: String) {
        self.fetcher = fetcher
        self.queryString = queryString
    }
    
    func refresh(completion: @escaping () -> Void) {
        fetcher.fetch(withQueryString: queryString) { (response: NSDictionary) in
            guard
                let photosDictionary = response.value(forKey: "photos") as? [String: AnyObject],
                let photosArray = photosDictionary["photo"] as? [[String: AnyObject]]
                else { return }
            
            self.items.removeAll()
            
            for photoDictionary in photosArray {
                if let model = Model(photoDictionary: photoDictionary) {
                    self.items.append(model)
                }
            }
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        return items.count
    }
    
    func itemForRow(at indexPath: IndexPath) -> UIImage {
        return items[indexPath.row].image
    }
}
