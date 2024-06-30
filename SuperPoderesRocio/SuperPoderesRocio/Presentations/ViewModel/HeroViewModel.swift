//
//  HeroViewModel.swift
//  SuperPoderesRocio
//
//  Created by Rocio Martos on 29/4/24.
//

import Foundation
import Combine

final class HeroViewModel: ObservableObject {
    @Published var dataHeros:SuperHeroResponse? // los datos del request
    @Published var status = Status.none // estado de como va la cosa, para control desde la UI

    //Use case object
    private var useCaseheros : HerosUseCaseProtocol
    
    var suscriptors = Set<AnyCancellable>()
    
    init(useCase : HerosUseCaseProtocol = HerosUseCase()){
        useCaseheros = useCase
    }
   
    // Load Heros from API Marvel
    @MainActor
    func fetchHeroes() async {
        self.status = Status.loading //Cambiamos el estado a Loading
        
        let data = await useCaseheros.getHeros()
        
        //set in main thread
        DispatchQueue.main.async{
            self.dataHeros = data
            self.status = .loaded
        }

    }
}
