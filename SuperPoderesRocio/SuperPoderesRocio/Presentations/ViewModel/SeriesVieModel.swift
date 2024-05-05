//
//  SeriesVieModel.swift
//  SuperPoderesRocio
//
//  Created by Rocio Martos on 29/4/24.
//

import Foundation
import Combine

final class SeriesViewModel: ObservableObject {
    @Published var series: [Serie] = []
      @Published var status = Status.none
      
      private let useCase: SeriesUseCaseProtocol
      private var cancellables = Set<AnyCancellable>()
      
      init(useCase: SeriesUseCaseProtocol = SeriesUseCase(repository: SerieRepository(Network: NetworkSeries()))) {
          self.useCase = useCase
      }
      
      func fetchSeries(for heroName: String) {
          print("Fetching series for hero: \(heroName)") // Depuración
          
          self.status = .loading
              
          Task {
              do {
                  self.series = try await useCase.getSeries(forHero: heroName)
                  self.status = .loaded
                  
                  print("Series fetched successfully") // Depuración
                  print("Number of series: \(self.series.count)") // Depuración
              } catch {
                  self.handleFailure(error)
              }
          }
      }
      
      // Manejo de errores
      private func handleFailure(_ error: Error) {
          print("Error: \(error)")
          self.status = .error(error: error.localizedDescription)
      }
  }
