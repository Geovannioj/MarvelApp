//
//  HeroDetailCoordinator.swift
//  MarvelHeros
//
//  Created by Geovanni Oliveira de Jesus on 15/02/21.
//  Copyright © 2021 Geovanni Oliveira de Jesus. All rights reserved.
//

import Foundation
import UIKit

class HeroDetailCoordinator: BaseCoordinator {
    
    var heroModel: HeroModel?
    var navigationController: UINavigationController?
    
    init(heroModel: HeroModel, navController: UINavigationController) {
        self.heroModel = heroModel
        self.navigationController = navController
    }
    
    func start() {
        let controller = HeroDetailViewController(nibName: "HeroDetailView", bundle: .main)
        controller.hero = heroModel
        navigationController?.pushViewController(controller, animated: true)

    }
}
