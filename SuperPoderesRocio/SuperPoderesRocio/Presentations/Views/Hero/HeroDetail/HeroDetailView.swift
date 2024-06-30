//
//  HeroDetailView.swift
//  SuperPoderesRocio
//
//  Created by Rocio Martos on 4/5/24.
//

import SwiftUI

struct HeroDetailView: View {
    let hero: SuperHero
    @StateObject var seriesViewModel = SeriesViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 10) {
                // Foto
                AsyncImage(url: URL(string: "\(hero.thumbnail.path).\(hero.thumbnail.extension)")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .padding([.horizontal, .bottom])
                        .opacity(0.8)
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                
                // Descripción
                Text(hero.description ?? "")
                    .foregroundColor(.gray)
                    .font(.body)
                    .padding(.horizontal)
                
                // Series
                if let series = seriesViewModel.dataSeries?.data?.results {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 10) {
                            ForEach(series) { serie in
                                SeriesItemView(serie: serie)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 120)
                    .padding(.vertical)
                } else {
                    ProgressView()
                        .padding(.vertical)
                }
            }
            .navigationTitle(hero.name ?? "")
            .onAppear {
                Task {
                    await seriesViewModel.loadMarvelSeries(hero: hero.id)
                }
            }
        }
    }
}

#Preview {
    HeroDetailView(hero: SuperHero(
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
