//
//  ViewController.swift
//  ParsingLocalJsonWithSearchField
//
//  Created by Алтын on 9/14/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var SearchText: UITextField!
    
    @IBOutlet var WordLabel: UILabel!
    @IBOutlet var TypeLable: UILabel!
    @IBOutlet var DefinitionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func SearchButton(_ sender: Any) {
        fetchingInformation()
    }
    
    
    func fetchingInformation() {
        
        guard let path = Bundle.main.path(forResource: "satWords", ofType: "json") else { return }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            guard let array = json as? [Any] else { return }
            for word in array {
                guard let wordList = word as? [String: Any] else { return }
                guard let word = wordList["word"] as? String else { return }
                guard let type = wordList["type"] as? String else { return }
                guard let definition = wordList["definition"] as? String else { return }
                
                if SearchText.text!.contains(word) {
                    WordLabel.text = word
                    TypeLable.text = type
                    DefinitionLabel.text = definition
                }
            }
            
            
        } catch {
            print(error)
        }
        
        
        
    }

}
