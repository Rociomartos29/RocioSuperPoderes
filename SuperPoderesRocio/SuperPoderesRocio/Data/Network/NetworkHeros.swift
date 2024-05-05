//
//  NetworkHeros.swift
//  SuperPoderesRocio
//
//  Created by Rocio Martos on 26/4/24.
//

import Foundation
import KeychainSwift

class NetworkHeros {
    func getHeros(filter: String) async throws -> [SuperHero] {
            // Crea la URL usando el rawValue de Endpoints.heros
            guard let url = URL(string: Endpoints.heros.rawValue) else {
                throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            }
            
            // Crea la solicitud URLRequest
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethods.get
            
            // Realiza la solicitud de manera asíncrona
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Comprueba si se recibieron datos
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NSError(domain: "Failed to fetch data", code: 0, userInfo: nil)
            }
            
            // Decodifica los datos JSON en un array de objetos SuperHero
            do {
                let decodedData = try JSONDecoder().decode([SuperHero].self, from: data)
                return decodedData
            } catch {
                throw error
            }
        }
    }
