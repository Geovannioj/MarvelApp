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
    
    let networkManager: NetworkManagerProtocol = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        bindData()
        
    }
    
    private func bindData() {
        networkManager.requestData { (responseStatus, responseData) in
            switch responseStatus {
            case .success:
                if let data = responseData {
                    self.heros = data
                    self.tableView.reloadData()
                }
            case .failure:
                //Build error screen message
                print("ERROR")
            }
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
}
