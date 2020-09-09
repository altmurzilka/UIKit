//
//  ViewController.swift
//  PersistedJSON
//
//  Created by Алтын on 9/10/20.
//

import UIKit

class ViewController: UIViewController {
    
    let networking = NetworkingService.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlPath = "https://kiloloco.com/api/users"
        networking.request(urlPath) { (result) in
            print(result)
        }
    }


}

