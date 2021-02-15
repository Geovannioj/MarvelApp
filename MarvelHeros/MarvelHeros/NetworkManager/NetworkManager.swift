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
    var resultHeros: [HeroModel] { get }
    func requestData(offset: Int,completionHandler: @escaping ((ResultStatus,[HeroModel]?) -> Void))
    func downloadImage(from url: URL) -> Data
}

class NetworkManager: NetworkManagerProtocol {
    
    var resultHeros: [HeroModel] = [HeroModel]()
    private let publicKey: String = "4aedd955fbdad2c757b38f4b1f6e0d12"
    private let privateKey: String = "3651d395ae9b0cd14cc9130ebacc47dc3f6488e5"
    private var timeStemp: String = String(describing: Int(Date().timeIntervalSince1970))
    private var md5Manager = MD5Manager()
    private let group = DispatchGroup()

    
    func requestData(offset: Int, completionHandler: @escaping ((ResultStatus,[HeroModel]?) -> Void)) {

        let md5DataHex = getMD5Hash(timeStemp: timeStemp,
                                    privateKey: privateKey,
                                    publicKey: publicKey)
        
        let parameters = ["apikey": self.publicKey,
                          "ts": "\(timeStemp)",
                          "hash": "\(md5DataHex)",
                          "offset": "\(offset)"]
  
        group.enter()
        
        AF.request("http://gateway.marvel.com/v1/public/characters?orderBy=name&limit=10",
                   method: .get,
                   parameters: parameters).validate().responseJSON  { response in
                    
                    self.group.leave()
                    switch response.result {
                    case .success(let data):
                        self.unwrapJson(data: data)
                        completionHandler(.success, self.resultHeros)
                        self.resultHeros = [HeroModel]()
                    case .failure(let error):
                        completionHandler(.failure, nil)
                        print(error)
                    }
        }
            
    }
    
    private func getMD5Hash(timeStemp: String,
                            privateKey: String,
                            publicKey: String ) -> String {
        
        let md5StrContent = "\(timeStemp)\(privateKey)\(publicKey)"
        let md5Data = md5Manager.MD5(string: md5StrContent)
        let md5DataHex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
        
        return md5DataHex
        
    }
    
    private func unwrapJson(data: Any) {
        if let jsonResult = data as? [String: AnyObject] {
            let dataContent = jsonResult["data"]!["results"]! as? [AnyObject]
            for heroContent in dataContent! {
                let content = heroContent as? [String: AnyObject]
                var hero = HeroModel(name: content?["name"] as! String,
                                     description: content?["description"] as! String,
                                     imagePath: content?["thumbnail"]?["path"] as! String,
                                     imageExtension: content?["thumbnail"]?["extension"] as! String)
                
                    if let imgUrl = URL(string: "\(hero.imagePath).\(hero.imageExtension)") {
                        let imgData = downloadImage(from: imgUrl)
                        hero.imageData = imgData
                    }

                self.resultHeros.append(hero)
            }
        }
    }
        
    func downloadImage(from url: URL) -> Data {
        var imageData: Data?
        group.enter()
        imageData = try? Data(contentsOf: url)
        self.group.leave()
        return imageData ?? Data()
    }
}
