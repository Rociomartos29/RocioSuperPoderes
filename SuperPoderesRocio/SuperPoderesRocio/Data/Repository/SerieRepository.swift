//
//  SerieRepository.swift
//  SuperPoderesRocio
//
//  Created by Rocio Martos on 4/5/24.
//

import Foundation
final class SerieRepository: SeriesRepositoryProtocol{
    private var Network: NetworkSeries
    init(Network: NetworkSeries) {
        self.Network = Network
    }
    func getSeries(filter: String) async throws -> [Serie] {
        do {
            return try await Network.getSeries(filter: filter)
        } catch {
            throw error
        }
    }
}

