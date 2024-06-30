//
//  SeriesViewModel.swift
//  SuperPoderesRocio
//
//  Created by Rocio Martos on 29/4/24.
//

import Foundation
import Combine

final class SeriesViewModel: ObservableObject {
    @Published var dataSeries: SuperHeroResponse? // los datos del request
    @Published var status = Status.none // estado de como va la cosa, para control desde la UI
    
    // Use case object
    private var useCaseheros: HerosUseCaseProtocol
    
    var suscriptors = Set<AnyCancellable>()
    
    init(useCase: HerosUseCaseProtocol = HerosUseCase()) {
        useCaseheros = useCase
    }
    
    // Load Series of hero from API Marvel
    @MainActor
    func loadMarvelSeries(hero: Int) async {
        self.status = Status.loading // Cambiamos el estado a Loading
        let data = await useCaseheros.getSeriesOfhero(hero: hero)
        
        DispatchQueue.main.async {
            self.dataSeries = data
            self.status = .loaded
            
            // Print the number of series loaded
            if let results = data.data?.results {
                print("Cargando \(results.count) series.")
            } else {
                print("No se encontraron series para cargar.")
            }
        }
    }
}
