//
//  ViewController.swift
//  MarvelHeros
//
//  Created by Geovanni Oliveira de Jesus on 14/02/21.
//  Copyright © 2021 Geovanni Oliveira de Jesus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        if let path = Bundle.main.path(forResource: "MarvelResponse", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [String: AnyObject] {
                    let dataContent = jsonResult["data"]!["results"]! as? [AnyObject]
                    
                    let content = dataContent?[0] as? [String: AnyObject]
                    print(dataContent?.count)
                    print(content?["id"] ?? 0)
                    
                }
              } catch {
                   // handle error
              }
        }
    }


}

