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
    
    func requestData(completionHandler: @escaping ((ResultStatus,[HeroModel]?) -> Void))
    func downloadImage(from url: URL, tableView: UITableView) -> Data
}

class NetworkManager: NetworkManagerProtocol {
    
    private var result: [HeroModel] = [HeroModel]()
    private let publicKey: String = "4aedd955fbdad2c757b38f4b1f6e0d12"
    private let privateKey: String = "3651d395ae9b0cd14cc9130ebacc47dc3f6488e5"
    private var timeStemp: String = "1"
    private var md5Manager = MD5Manager()
    
    func requestData(completionHandler: @escaping ((ResultStatus,[HeroModel]?) -> Void)) {
        let md5StrContent = "\(timeStemp)\(privateKey)\(publicKey)"
        let md5Data = md5Manager.MD5(string: md5StrContent)
        let md5DataHex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
        
        let parameters = ["apikey": "4aedd955fbdad2c757b38f4b1f6e0d12",
                          "ts": "\(timeStemp)",
                          "hash": "\(md5DataHex)"]
  
        AF.request("https://gateway.marvel.com:443/v1/public/characters?orderBy=name&limit=10",
                   method: .get,
                   parameters: parameters).validate().responseJSON  { response in
                    switch response.result {
                    case .success(let data):
                        self.unwrapJson(data: data)
                        completionHandler(.success, self.result)
                    case .failure(let error):
                        completionHandler(.failure, nil)
                        print(error)
                    }
        }
            
    }

    private func unwrapJson(data: Any) {
        if let jsonResult = data as? [String: AnyObject] {
            let dataContent = jsonResult["data"]!["results"]! as? [AnyObject]
            for heroContent in dataContent! {
                let content = heroContent as? [String: AnyObject]
                let hero = HeroModel(name: content?["name"] as! String,
                                     description: content?["description"] as! String,
                                     imagePath: content?["thumbnail"]?["path"] as! String,
                                     imageExtension: content?["thumbnail"]?["extension"] as! String)
                self.result.append(hero)
            }
        }
    }
        
    private func getUrlData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, tableView: UITableView) -> Data {
        var imageData: Data?
        
        getUrlData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            imageData = data
        }
        return imageData ?? Data()
    }
}
