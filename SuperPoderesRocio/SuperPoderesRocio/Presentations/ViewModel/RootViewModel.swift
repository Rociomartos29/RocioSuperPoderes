//
//  RootViewModel.swift
//  SuperPoderesRocio
//
//  Created by Rocio Martos on 26/4/24.
//

import Foundation
import Combine

final class RootViewModel: ObservableObject {
    @Published var status = Status.none // Estado actual
    @Published var heroes: [SuperHero] = [] // Almacenar lista de héroes
    @Published var series: [Serie] = [] 
    var cancellables = Set<AnyCancellable>()
    
    func getHeroes(filter: String) {
        self.status = .loading // Estado cargando antes de la solicitud
        
        Task {
            do {
                // Realizar la solicitud de red
                let networkHeroes = NetworkHeros()
                let result = try await networkHeroes.getHeros(filter: filter)
                
                // Actualizar el estado y los datos
                self.status = .loaded
                self.heroes = result
            } catch {
                // Manejar errores
                self.status = Status.error(error: "Error al buscar héroes: \(error.localizedDescription)")
            }
        }
    }
    
    func loadSeriesForHeroes(_ heroes: [SuperHero]) async throws {
        // Limpiar la lista de series antes de cargar nuevas
        self.series = []
        
        for hero in heroes {
            do {
                // Realizar la solicitud de red para obtener las series del héroe
                let networkSeries = NetworkSeries()
                let result = try await networkSeries.getSeries(filter: String(hero.id))
                
                // Agregar las series obtenidas a la lista de series
                self.series.append(contentsOf: result)
            } catch {
                // Manejar errores al obtener las series del héroe
                throw error
            }
        }
    }
}

