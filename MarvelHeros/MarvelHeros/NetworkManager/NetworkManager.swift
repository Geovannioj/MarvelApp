//
//  NetworkManager.swift
//  MarvelHeros
//
//  Created by Geovanni Oliveira de Jesus on 14/02/21.
//  Copyright © 2021 Geovanni Oliveira de Jesus. All rights reserved.
//

import Foundation
import Alamofire

enum ResultStatus {
    case success
    case failure
}

protocol NetworkManagerProtocol {
    
}

class NetworkManager: NetworkManagerProtocol {
    
    var result: HeroModel?
    
    func requestData(completionHandler: @escaping ((ResultStatus,HeroModel?) -> Void)) {
        
        let parameters = ["api_key": "4aedd955fbdad2c757b38f4b1f6e0d12",
                          "ts": "1",
                          "hash": ""]
  
        AF.request("http://gateway.marvel.com/v1/public/characters?",
                   method: .get,
                   parameters: parameters).responseJSON { response in
                    
        }
            
                    
        }
//        AF.request("http://gateway.marvel.com/v1/public/characters?",
//                   method: .get,
//                   parameters: parameters).responseDecodable(of: AstronomyModel.self) { (response) in
//                    guard let astronomyContent = response.value else { completionHandler(.failure, nil); return }
//            self.result = astronomyContent
//            completionHandler(.success, astronomyContent)
//
//
//        }
    }

    func getUrlData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, tableView: UITableView) -> Data {
        var imageData: Data?
        
        getUrlData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            imageData = data
        }
        tableView.reloadData()
        return imageData ?? Data()
    }
}
