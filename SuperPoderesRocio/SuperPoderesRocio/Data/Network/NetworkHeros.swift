//
//  NetworkHeros.swift
//  SuperPoderesRocio
//
//  Created by Rocio Martos on 26/4/24.
//

import Foundation
import KeychainSwift
struct HTTPResponseCodes{
    static let SUCCESS = 200
    static let NOT_AUTHORIZED = 401
    static let ERROR = 401
}

protocol NetworkHerosProtocol {
    func getHerosMarvel() async -> SuperHeroResponse
    func getSeriesOfhero(hero:Int) async -> SuperHeroResponse
}


final class NetworkHeros: NetworkHerosProtocol{
    
    ///get Heros
    func getHerosMarvel() async -> SuperHeroResponse {
        var modelReturn = SuperHeroResponse(code: 1, status: "", copyright: "", attributionText: "", attributionHTML: "", etag: "", data: SuperHeroData(offset: 1, limit: 1, total: 1, count: 1, results: []))
        
        let sessionRequest = BaseNetwork().getHeros()
        
        //Call to server
        
        do{
            
            let (data, response) = try await URLSession.shared.data(for: sessionRequest)
            
            
                if let resp = response  as? HTTPURLResponse {
                    if resp.statusCode == HTTPResponseCodes.SUCCESS {
                       
                            modelReturn = try! JSONDecoder().decode(SuperHeroResponse.self, from: data)
                       
                    }
                
            }
            
        }catch{
            NSLog("Aqui tratamos el error get heros")
        }
        
        return modelReturn
        
        
    }
    
    //get Series of hero
    func getSeriesOfhero(hero: Int) async -> SuperHeroResponse {
        var modelReturn = SuperHeroResponse(code: 1, status: "", copyright: "", attributionText: "", attributionHTML: "", etag: "", data: SuperHeroData(offset: 1, limit: 1, total: 1, count: 1, results: []))
        let sessionRequest = BaseNetwork().getSeries(idHero: hero)
        
        //Call to server
        
        do{
            
            let (data, response) = try await URLSession.shared.data(for: sessionRequest)
            
            if let resp = response  as? HTTPURLResponse {
                if resp.statusCode == HTTPResponseCodes.SUCCESS {
                    modelReturn = try! JSONDecoder().decode(SuperHeroResponse.self, from: data)
                }
            }
            
        }catch{
            NSLog("Aqui tratamos el error series del hero")
        }
        
        return modelReturn
    }
    
    
}



//Fake for testing, Design UI etc.
final class NetworkHerosFake: NetworkHerosProtocol{
    
    ///get Heros Mock
    func getHerosMarvel() async -> SuperHeroResponse {
        
        let hero1 = SuperHero(id: 1009351, title: "", name: "Hulk", description: "Caught in a gamma bomb explosion while trying to save the life of a teenager, Dr. Bruce Banner was transformed into the incredibly powerful creature called the Hulk. An all too often misunderstood hero, the angrier the Hulk gets, the stronger the Hulk gets.", thumbnail: SuperHeroThumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0", extension: Extension.jpg.rawValue), resourceURI: "http://gateway.marvel.com/v1/public/characters/1009351")
        
        
        let hero2 = SuperHero(id: 1009165, title: "", name: "Avengers", description: "Earth's Mightiest Heroes joined forces to take on threats that were too big for any one hero to tackle. With a roster that has included Captain America, Iron Man, Ant-Man, Hulk, Thor, Wasp and dozens more over the years, the Avengers have come to be regarded as Earth's No. 1 team.", thumbnail: SuperHeroThumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/9/20/5102c774ebae7", extension: Extension.jpg.rawValue), resourceURI: "http://gateway.marvel.com/v1/public/characters/1009165")
        let data = SuperHeroData(offset: 0, limit: 0, total: 2, count: 2, results: [hero1,hero2])
        return  SuperHeroResponse(code: 200, status: "success", copyright: "2020", attributionText: "", attributionHTML: "", etag: "", data: data)
        
        
    }
    
    //get Series of hero Mock
    func getSeriesOfhero(hero: Int) async -> SuperHeroResponse {
        
        let data  = SuperHeroData(offset: 0, limit: 0, total: 2, count: 2, results: [SuperHero(id: 1009146, title: "Moon Girl and Devil Dinosaur (2015 - 2019)", name: "", description: "The flagship X-Men comic for over 40 years, Uncanny X-Men delivers action, suspense, and a hint of science fiction month in and month out. Follow the adventures of Professor Charles Xavier's team of mutants as they attempt to protect a world that hates and fears them.", thumbnail: SuperHeroThumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/e0/56d0caf175be0", extension: Extension.jpg.rawValue), resourceURI: "http://gateway.marvel.com/v1/public/characters/1009146")])
        
        return  SuperHeroResponse(code: 200, status: "success", copyright: "2020", attributionText: "", attributionHTML: "", etag: "", data: data)
        
        
        
  
    }
    
    
}
