//
//  NetworkSeries.swift
//  SuperPoderesRocio
//
//  Created by Rocio Martos on 29/4/24.
//

import Foundation
class NetworkSeries {
    enum SeriesError: Error {
        case invalidURL
        case requestFailed
        case invalidResponse
        case decodingError
    }
    
    func getSeries(filter: String) async throws -> [Serie] {
        guard let url = URL(string: "http://gateway.marvel.com/v1/public/series?ts=1&apikey=b07c96dbe0d40383491fbc5fc19afff9&hash=a0aacc383b08f47b0515aad3209d948f") else {
            throw SeriesError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get// Aquí usamos el enum HTTPMethod
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let seriesResponse = try JSONDecoder().decode(SeriesResponse.self, from: data)
            return seriesResponse.data.results
        } catch {
            throw SeriesError.requestFailed
        }
    }
}
