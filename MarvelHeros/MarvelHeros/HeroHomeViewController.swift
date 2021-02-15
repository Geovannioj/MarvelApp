//
//  ViewController.swift
//  MarvelHeros
//
//  Created by Geovanni Oliveira de Jesus on 14/02/21.
//  Copyright © 2021 Geovanni Oliveira de Jesus. All rights reserved.
//

import UIKit

class HeroHomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var heros: [HeroModel] = [HeroModel]()
    let xibCellId = "heroCell"
    var offset = 0
    let callDataAtOffset = 5
    let tableViewCellHeight = 200
    let networkManager: NetworkManagerProtocol = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        bindData(offset: 0)
    }
    
    private func bindData(offset: Int) {
        networkManager.requestData(offset: offset) { (responseStatus, responseData) in
            switch responseStatus {
            case .success:
                if let data = responseData {
                    self.appendHeros(data)
                    self.tableView.reloadData()
                }
            case .failure:
                //Build error screen message
                print("ERROR")
            }
        }
    }
    
    func appendHeros(_ input: [HeroModel]) {
        for hero in input {
            self.heros.append(hero)
        }
    }
    private func setTableView() {
        let xibName = "HeroTableViewCell"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: xibName, bundle: nil), forCellReuseIdentifier: xibCellId)
    }
}

extension HeroHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.heros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.xibCellId, for: indexPath) as? HeroTableViewCell else { return UITableViewCell() }
        
        cell.heroNameLbl.text = self.heros[indexPath.row].name
        if let data = self.heros[indexPath.row].imageData {
            cell.heroImgView.image = UIImage(data: data)
        }
        cell.setAccessibility()
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == heros.count - callDataAtOffset && indexPath.row != 0 {
            print("VAI CARREGAR NOVOS HEROIS")
            offset += heros.count
            bindData(offset: offset)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(tableViewCellHeight)
    }
}
