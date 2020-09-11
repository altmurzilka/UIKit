//
//  ViewController.swift
//  PersistedJSON
//
//  Created by Алтын on 9/10/20.
//

import UIKit

class ViewController: UITableViewController {
    
    let networking = NetworkingService.shared
    let persistence = PersistenceService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlPath = "https://kiloloco.com/api/users"
        networking.request(urlPath) { (result) in
            
            switch result {
            
            case .success(let data):
                do {
                    guard let jsonArray = try JSONSerialization.jsonObject(with: data, options: [])
                            as? [[String: Any]] else { return }
                    
                    let users: [User] = jsonArray.compactMap { [weak self] in
                        guard
                            let strongSelf = self,
                            let name = $0["name"] as? String,
                            let age = $0["age"] as? Int16,
                            let id = $0["id"] as? Int16
                        else { return nil }
                        
                        let user = User(context: strongSelf.persistence.context)
                        user.name = name
                        user.age = age
                        user.id = id
                        
                        return user
                    }
                    
                    print(users)
                    
                } catch {
                    print(error)
                }
            case .failure(let error): print(error)
            }
        }
    }
    
    
}

