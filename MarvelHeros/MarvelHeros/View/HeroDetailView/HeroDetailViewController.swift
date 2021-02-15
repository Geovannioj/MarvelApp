//
//  HeroDetailViewController.swift
//  MarvelHeros
//
//  Created by Geovanni Oliveira de Jesus on 15/02/21.
//  Copyright © 2021 Geovanni Oliveira de Jesus. All rights reserved.
//

import Foundation
import UIKit

class HeroDetailViewController: UIViewController {
    
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroDetail: UILabel!
    
    var hero: HeroModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeroData()
    }
    
    private func setHeroData() {
        if let hero = self.hero {
            heroName.text = hero.name
            if let imgData = hero.imageData {
                heroImage.image = UIImage(data: imgData)
            }
            heroDetail.text = hero.description
        } else {
            //Nothing to be done
        }
    }
}
