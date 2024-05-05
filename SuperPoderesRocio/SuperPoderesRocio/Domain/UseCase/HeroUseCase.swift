//
//  HeroUseCase.swift
//  SuperPoderesRocio
//
//  Created by Rocio Martos on 4/5/24.
//

import Foundation
protocol HerosUseCaseProtocol{
    var repo: HerosRepositoryProtocol {get set}
    func getHeros(filter: String) async throws -> [SuperHero]
}

final class HerosUseCase: HerosUseCaseProtocol {
    var repo: HerosRepositoryProtocol
    
    init(repo: HerosRepositoryProtocol = HerosRepository(network: NetworkHeros()) as! HerosRepositoryProtocol) {
        self.repo = repo
    }

    func getHeros(filter: String) async throws -> [SuperHero] {
        return try await repo.getHeros(filter: filter)
    }
}

final class HeroUseCaseFake: HerosUseCaseProtocol {
    var repo: HerosRepositoryProtocol
    
    init(repo: HerosRepositoryProtocol = HerosRepository(network: NetworkHeros())) {
        self.repo = repo
    }

    func getHeros(filter: String) async throws -> [SuperHero] {
        return try await repo.getHeros(filter: filter)
    }
}
