//
//  HeroTableViewCell.swift
//  MarvelHeros
//
//  Created by Geovanni Oliveira de Jesus on 15/02/21.
//  Copyright © 2021 Geovanni Oliveira de Jesus. All rights reserved.
//

import UIKit

class HeroTableViewCell: UITableViewCell {

    @IBOutlet weak var heroImgView: UIImageView!
    @IBOutlet weak var heroNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setAccessibility()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setAccessibility() {
        self.accessibilityLabel = heroNameLbl.text
        self.accessibilityTraits = .button
    }
    
}
