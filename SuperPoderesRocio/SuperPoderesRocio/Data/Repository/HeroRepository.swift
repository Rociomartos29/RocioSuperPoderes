//
//  HeroRepository.swift
//  SuperPoderesRocio
//
//  Created by Rocio Martos on 4/5/24.
//

import Foundation


final class HerosRepository: HerosRepositoryProtocol {
    
    private var network: NetworkHerosProtocol

    init(network: NetworkHerosProtocol){
        self.network = network
    }

    func getHeros() async -> SuperHeroResponse {
       return await network.getHerosMarvel()
    }
    
    func getSeriesOfhero(hero: Int) async -> SuperHeroResponse {
        return await network.getSeriesOfhero(hero: hero)
    }
}


//FAKE

final class HerosRepositoryFake: HerosRepositoryProtocol{
    private var network: NetworkHerosProtocol

    init(network: NetworkHerosProtocol = NetworkHerosFake()){
        self.network = network
    }

    func getHeros() async -> SuperHeroResponse {
       return await network.getHerosMarvel()
    }
    
    func getSeriesOfhero(hero: Int) async -> SuperHeroResponse {
        return await network.getSeriesOfhero(hero: hero)
    }
}

