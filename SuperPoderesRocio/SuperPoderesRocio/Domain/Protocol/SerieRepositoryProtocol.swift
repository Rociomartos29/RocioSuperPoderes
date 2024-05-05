//
//  SerieRepositoryProtocol.swift
//  SuperPoderesRocio
//
//  Created by Rocio Martos on 4/5/24.
//

import Foundation
protocol SeriesRepositoryProtocol{
    func getSeries(filter: String) async throws -> [Serie]
}
