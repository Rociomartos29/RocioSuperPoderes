//
//  HeroRepository.swift
//  SuperPoderesRocio
//
//  Created by Rocio Martos on 4/5/24.
//

import Foundation


final class HerosRepository: HerosRepositoryProtocol {
    
    
    private let network: NetworkHeros
    
    init(network: NetworkHeros) {
        self.network = network
    }
    
    func getHeros(filter: String) async throws -> [SuperHero] {
        do {
            return try await network.getHeros(filter: filter)
        } catch {
            throw error
        }
    }
}
