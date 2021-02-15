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
    @IBOutlet weak var heroCollectionView: UICollectionView!
    
    var heros: [HeroModel] = [HeroModel]()
    let xibCellId = "heroCell"
    let collectionXibCellID = "collectionHeroCell"
    let collectionViewXibName = "HeroCollectionViewCell"
    var offset = 0
    let callDataAtOffset = 5
    let tableViewCellHeight = 200
    let networkManager: NetworkManagerProtocol = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setCollectionView()
        bindData(offset: 0)
        
    }
    
    private func bindData(offset: Int) {
        networkManager.requestData(offset: offset) { (responseStatus, responseData) in
            switch responseStatus {
            case .success:
                if let data = responseData {
                    self.appendHeros(data)
                    self.tableView.reloadData()
                    self.heroCollectionView.reloadData()
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
    
    private func setCollectionView() {
        heroCollectionView.delegate = self
        heroCollectionView.dataSource = self
        
        registerCollectionViewNib()
    }
    
    func registerCollectionViewNib() {
        let nib = UINib(nibName: collectionViewXibName, bundle: nil)
        heroCollectionView.register(nib, forCellWithReuseIdentifier: collectionXibCellID)
        
        if let flowLayout = self.heroCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
}
//MARK: - Tableview delegate and Datasource
extension HeroHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.heros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.xibCellId, for: indexPath) as? HeroTableViewCell else { return UITableViewCell() }
        var index = 0
        
        if indexPath.row < 5 {
            index = indexPath.row + 5
        } else {
            index = indexPath.row
        }
        cell.heroNameLbl.text = self.heros[index].name
        if let data = self.heros[index].imageData {
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

extension HeroHomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let collectionViewItensAmount = 5
        if heros.count == 10 {
            return heros.count - collectionViewItensAmount
        } else if heros.count == 0 {
            return heros.count
        } else {
            return collectionViewItensAmount
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionXibCellID, for: indexPath) as?  HeroCollectionViewCell else { return UICollectionViewCell()}
        
        cell.title.text = heros[indexPath.row].name
        if let imgData = heros[indexPath.row].imageData {
            cell.heroImgView.image = UIImage(data: imgData)
        }
        
        cell.setAccessibility()
        
        return cell
        
    }
}

extension HeroHomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let cell: HeroCollectionViewCell = Bundle.main.loadNibNamed(collectionViewXibName,
                                                                      owner: self,
                                                                      options: nil)?.first as? HeroCollectionViewCell else {
            return CGSize.zero
        }
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        let size: CGSize = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return CGSize(width: 30, height: size.height)
    }
}
