//
//  HeroViewModel.swift
//  MarvelHeros
//
//  Created by Geovanni Oliveira de Jesus on 14/02/21.
//  Copyright © 2021 Geovanni Oliveira de Jesus. All rights reserved.
//

import Foundation

protocol HeroViewModelPortocol {
    var heroModel: HeroModel? { get }
    var imageData: Data? { get }
    
}
class HeroViewModel: HeroViewModelPortocol {
    
    var heroModel: HeroModel?
    var imageData: Data?
    
    
}
