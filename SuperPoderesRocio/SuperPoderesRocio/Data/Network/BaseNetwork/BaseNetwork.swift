//
//  BaseNetwork.swift
//  SuperPoderesRocio
//
//  Created by Rocio Martos on 26/6/24.
//

import Foundation
let server = "https://gateway.marvel.com"
let apiKey = "b07c96dbe0d40383491fbc5fc19afff9"
let ts = "1"
let hash = "a0aacc383b08f47b0515aad3209d948f"


struct BaseNetwork{
    private func getURL(endpoint: String, subPath:String = "") -> String{
        var url = server
        url += "\(endpoint)\(subPath)"
        url += "?ts=\(ts)"
        url += "&apikey=\(apiKey)"
        
        url += "&hash=\(hash)"
        return url
    }
    
    func getHeros() -> URLRequest {
            let urlCad: String = getURL(endpoint: Endpoints.heros.rawValue)
            print(urlCad)
            
            var request: URLRequest = URLRequest(url: URL(string: urlCad)!)
            
            request.httpMethod = HTTPMethods.get
            
            // Configurar el encabezado Content-type como application/json
            request.addValue("application/json", forHTTPHeaderField: "Content-type")
            
            return request
        }
        
        func getSeries(idHero: Int) -> URLRequest {
            let urlCad = getURL(endpoint: Endpoints.heros.rawValue, subPath: "/\(idHero)/series")
            
            print (urlCad)
            var request: URLRequest = URLRequest(url: URL(string: urlCad)!)
            request.httpMethod = HTTPMethods.get
            
            // Configurar el encabezado Content-type como application/json
            request.addValue("application/json", forHTTPHeaderField: "Content-type")
            
            return request
        }
    }
