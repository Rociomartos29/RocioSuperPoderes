//
//  SeriesItemView.swift
//  SuperPoderesRocio
//
//  Created by Rocio Martos on 30/4/24.
//

import SwiftUI

struct SeriesItemView: View {
    var serie:SuperHero
    
    var body: some View {
        HStack(spacing: 10) {
            // Imagen de la serie
            AsyncImage(url: URL(string: "\(serie.thumbnail.url(type: .portrait))")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 150)
                    .cornerRadius(25)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .cornerRadius(10)
            }
            
            // Título y descripción de la serie
            VStack(alignment: .leading, spacing: 4) {
                Text(serie.title!)
                    .font(.headline)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 3)
    }
}

#Preview{
    
    SeriesItemView(serie: SuperHero(
        id: 1, title: "",
        name: "Rocío",
        description: "Rocío, una guerrera feroz y noble...",
        thumbnail: SuperHeroThumbnail(
            path: "https://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16",
            extension: "jpg"
        ),
        resourceURI: ""
        
    ))
}

