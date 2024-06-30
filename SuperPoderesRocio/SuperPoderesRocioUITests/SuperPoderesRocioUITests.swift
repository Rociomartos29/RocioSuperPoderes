//
//  SuperPoderesRocioUITests.swift
//  SuperPoderesRocioUITests
//
//  Created by Rocio Martos on 30/6/24.
//

import XCTest
import SwiftUI
@testable import SuperPoderesRocio

final class SuperPoderesRocioUITests: XCTestCase {
    
    func testGetHerosNetworkRequest() async throws {
            let network = NetworkHerosFake()
            let response = try await network.getHerosMarvel()
            
            XCTAssertEqual(response.code, 200)
            XCTAssertEqual(response.status, "success")
            XCTAssertGreaterThan(response.data?.results.count ?? 0, 0)
            XCTAssertNotNil(response.data?.results.first)
        }
        
        func testGetSeriesOfHeroNetworkRequest() async throws {
            let network = NetworkHerosFake()
            let response = try await network.getSeriesOfhero(hero: 1009146)
            
            XCTAssertEqual(response.code, 200)
            XCTAssertEqual(response.status, "success")
            XCTAssertGreaterThan(response.data?.results.count ?? 0, 0)
            XCTAssertNotNil(response.data?.results.first)
        }
        
    func testGetHerosURLRequest() {
        let baseNetwork = BaseNetwork()
        let request = baseNetwork.getHeros()
        
        print("Request URL: \(request.url?.absoluteString ?? "URL es nil")")
        print("Request HTTP Method: \(request.httpMethod ?? "Método HTTP es nil")")
        print("Request Headers: \(request.allHTTPHeaderFields ?? [:])")
        
        
        XCTAssertEqual(request.url?.absoluteString, "https://gateway.marvel.com/v1/public/characters?ts=1&apikey=b07c96dbe0d40383491fbc5fc19afff9&hash=a0aacc383b08f47b0515aad3209d948f")
        XCTAssertEqual(request.httpMethod, "GET")
        if let contentType = request.allHTTPHeaderFields?["Content-type"] {
            
            XCTAssertEqual(contentType, "application/json")
        } else {
            XCTFail("El encabezado Content-type es nil")
        }
    }
        
        func testGetSeriesOfHeroURLRequest() {
            let baseNetwork = BaseNetwork()
            let request = baseNetwork.getSeries(idHero: 1009146)
            
            XCTAssertEqual(request.url?.absoluteString, "https://gateway.marvel.com/v1/public/characters/1009146/series?ts=1&apikey=b07c96dbe0d40383491fbc5fc19afff9&hash=a0aacc383b08f47b0515aad3209d948f")
            XCTAssertEqual(request.httpMethod, "GET")
            if let contentType = request.allHTTPHeaderFields?["Content-type"] {
                XCTAssertEqual(contentType, "application/json")
            } else {
                XCTFail("El encabezado Content-type es nil")
            }
        }
     
    // MARK: - ViewModel Tests
       
    func testHeroViewModelFetchHeroes_Success() {
        // Given
        let viewModel = HeroViewModel(useCase: HeroUseCaseFake())
        let expectation = XCTestExpectation(description: "Fetch heroes expectation")
               Task {
                   await viewModel.fetchHeroes()
                   expectation.fulfill()
               }
        
        // Then
        XCTAssertEqual(viewModel.status, .loaded)
        XCTAssertNotNil(viewModel.dataHeros)
        XCTAssertEqual(viewModel.dataHeros?.data?.results.count, 3) // Assuming mock data returns 3 heroes
    }
        
    func testSeriesViewModelLoadMarvelSeries_Success() {
        // Given
        let viewModel = SeriesViewModel(useCase: HeroUseCaseFake())
        let expectation = XCTestExpectation(description: "Fetch Series expectation")
        // When
        Task {
            await viewModel.loadMarvelSeries(hero: 123)
            expectation.fulfill()
        }
        
        // Then
        XCTAssertEqual(viewModel.status, .loaded)
        XCTAssertNotNil(viewModel.dataSeries)
        XCTAssertEqual(viewModel.dataSeries?.data?.results.count, 3) // Assuming mock data returns 3 series
    }
       
       // MARK: - All Tests
       
       static var allTests = [
           ("testGetHerosNetworkRequest", testGetHerosNetworkRequest),
           ("testGetSeriesOfHeroNetworkRequest", testGetSeriesOfHeroNetworkRequest),
           ("testHeroViewModelFetchHeroes_Success", testHeroViewModelFetchHeroes_Success),
           ("testSeriesViewModelLoadMarvelSeries_Success", testSeriesViewModelLoadMarvelSeries_Success)
       ]
   }

