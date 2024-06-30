//
//  HeroUseCase.swift
//  SuperPoderesRocio
//
//  Created by Rocio Martos on 4/5/24.
//

import Foundation
protocol HerosUseCaseProtocol{
    var repo: HerosRepositoryProtocol {get set}
    func getHeros() async  -> SuperHeroResponse
    func getSeriesOfhero(hero: Int) async -> SuperHeroResponse
}

final class HerosUseCase: HerosUseCaseProtocol {
    var repo: HerosRepositoryProtocol
    
    init(repo: HerosRepositoryProtocol = HerosRepository(network: NetworkHeros()) as HerosRepositoryProtocol) {
        self.repo = repo
    }
    
    func getHeros() async  -> SuperHeroResponse{
        return  await repo.getHeros()
        
    }
    func getSeriesOfhero(hero: Int) async -> SuperHeroResponse {
        return await repo.getSeriesOfhero(hero: hero)
    }
}

final class HeroUseCaseFake: HerosUseCaseProtocol {
    var repo: HerosRepositoryProtocol
    
    init(repo: HerosRepositoryProtocol = HerosRepository(network: NetworkHeros())) {
        self.repo = repo
    }
    
    func getHeros() async  -> SuperHeroResponse {
        return  await repo.getHeros()
    }
    func getSeriesOfhero(hero: Int) async -> SuperHeroResponse {
        return await repo.getSeriesOfhero(hero: hero)
    }
}
