//
//  HeroRepositoryProtocol.swift
//  SuperPoderesRocio
//
//  Created by Rocio Martos on 4/5/24.
//

import Foundation
protocol HerosRepositoryProtocol {
    func getHeros() async -> SuperHeroResponse
    func getSeriesOfhero(hero:Int) async -> SuperHeroResponse
}
