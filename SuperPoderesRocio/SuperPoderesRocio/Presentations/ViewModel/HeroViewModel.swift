//
//  HeroViewModel.swift
//  SuperPoderesRocio
//
//  Created by Rocio Martos on 29/4/24.
//

import Foundation
import Combine

final class HeroViewModel: ObservableObject {
    @Published var heroes: [SuperHero] = []
    @Published var status = Status.none
    
    let useCase: HerosUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(useCase: HerosUseCaseProtocol = HerosUseCase()) {
        self.useCase = useCase
    }
    
    func fetchHeroes(filter: String) {
        self.status = .loading
        
      
    fetchData()
               .receive(on: DispatchQueue.main) // Asegura que las actualizaciones se realicen en el hilo principal
               .sink(receiveCompletion: { completion in
                   switch completion {
                   case .finished:
                       break
                   case .failure(let error):
                       self.handleFailure(error)
                   }
               }, receiveValue: { heroes in
                   self.heroes = heroes
                   self.status = .loaded
               })
               .store(in: &cancellables)
           }
    private func fetchData() -> AnyPublisher<[SuperHero], Error> {
        let url = URL(string:"\(Endpoints.heros.rawValue)")
            
        return URLSession.shared.dataTaskPublisher(for: url!)
                .map { $0.data }
                .decode(type: SuperHeroResponse.self, decoder: JSONDecoder())
                .map { $0.data.results }
                .mapError { error in
                    error as? URLError ?? URLError(.unknown)
                }
                .eraseToAnyPublisher()
        }
    // Manejo de errores
    private func handleFailure(_ error: Error) {
        print("Error fetching heroes: \(error)")
        self.status = .error(error: error.localizedDescription)
    }
}
