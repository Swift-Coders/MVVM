//
//  AppDelegate.swift
//  ViewModel
//
//  Created by Garric G. Nahapetian on 4/19/17.
//  Copyright © 2017 SwiftCoders. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let fetcher = Fetcher()
        let string = "https://api.flickr.com/services/rest/?method=flickr.galleries.getPhotos&api_key=b139e4f1a3a51778332012ca260bf060&gallery_id=72157664540660544&format=json&nojsoncallback=1"
        let viewModel = ViewModel(fetcher: fetcher, queryString: string)
        
        window = UIWindow()
        window?.rootViewController = ViewController(viewModel: viewModel)
        window?.makeKeyAndVisible()

        return true
    }
}
