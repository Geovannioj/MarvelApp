//
//  HeroCollectionViewCell.swift
//  MarvelHeros
//
//  Created by Geovanni Oliveira de Jesus on 15/02/21.
//  Copyright © 2021 Geovanni Oliveira de Jesus. All rights reserved.
//

import UIKit

class HeroCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var heroImgView: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setAccessibility() {
        heroImgView.accessibilityLabel = "Imagem de apresentação do herói \(String(describing: title.text))"
        title.accessibilityLabel = title.text
    }

}
