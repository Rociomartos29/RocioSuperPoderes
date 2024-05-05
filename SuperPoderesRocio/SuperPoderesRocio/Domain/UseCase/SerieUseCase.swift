//
//  SerieUseCase.swift
//  SuperPoderesRocio
//
//  Created by Rocio Martos on 4/5/24.
//

import Foundation
protocol SeriesUseCaseProtocol {
    var repository: SeriesRepositoryProtocol { get set }
    func getSeries(forHero heroName: String) async throws -> [Serie]
}

// Caso real para el caso de uso de las series
final class SeriesUseCase: SeriesUseCaseProtocol {
    var repository: SeriesRepositoryProtocol
    
    init(repository: SeriesRepositoryProtocol = SerieRepository(Network: NetworkSeries()) as SeriesRepositoryProtocol) {
        self.repository = repository
    }
    
    func getSeries(forHero heroName: String) async throws -> [Serie] {
        do {
            return try await repository.getSeries(filter: heroName)
        } catch {
            throw error
        }
    }
}

// Caso falso para pruebas del caso de uso de las series
final class SeriesUseCaseFake: SeriesUseCaseProtocol {
    var repository: SeriesRepositoryProtocol

    init(repository: SeriesRepositoryProtocol = SerieRepository(Network: NetworkSeries()) as! SeriesRepositoryProtocol) {
        self.repository = repository
    }

    func getSeries(forHero heroName: String) async throws -> [Serie] {
        do {
            return try await repository.getSeries(filter: heroName)
        } catch {
            throw error
        }
    }
}
