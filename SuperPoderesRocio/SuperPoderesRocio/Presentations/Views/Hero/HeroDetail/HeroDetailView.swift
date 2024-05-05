//
//  HeroDetailView.swift
//  SuperPoderesRocio
//
//  Created by Rocio Martos on 4/5/24.
//

import SwiftUI

struct HeroDetailView: View {
    let hero: SuperHero
    @State var series: [Serie]
    @Environment(\.presentationMode) var presentationMode
    
    @State private var heroImage: UIImage? = nil
    @State private var seriesImages: [UIImage?] = []
    
    var body: some View {
        ScrollView(.vertical){
            LazyVStack{
                //titulo
                HStack{
                    Text(hero.name)
                        .font(.title)
                        .bold()
                    
                    Spacer()
                }
                .padding([.leading, .trailing],10)
                
                //Foto
                AsyncImage(url: URL(string: "\(hero.thumbnail.path)"+".\(hero.thumbnail.extension)")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .padding([.leading, .trailing],20)
                        .opacity(0.8)
                } placeholder: {
                    ProgressView()
                }
                
                //Description
                Text(hero.description)
                    .foregroundColor(.gray)
                    .font(.caption)
                    .padding([.leading, .trailing], 20)
                
                
                Spacer()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(series) { serie in
                            SeriesItemView(serie: serie, heroName: hero.name, series: series)
                        }
                    }
                    .padding(.horizontal)
                    
                }
                .padding(.vertical)
                .onAppear {
                    
                    print("Number of series: \(series.count)")
                }
            }
        }
    }
}
#Preview {
    HeroDetailView(hero: SuperHero(id: 1,name: "Rocío", description: "Rocío, una guerrera feroz y noble, empuña su espada con destreza mientras defiende los reinos de la injusticia. Dotada de habilidades sobrenaturales y un coraje inquebrantable, Valquiria lucha sin descanso para proteger a los inocentes y hacer prevalecer la justicia en un mundo lleno de peligros. Su valentía inspira esperanza y su determinación es la luz que guía en las tinieblas de la adversidad.",modified: "",thumbnail: SuperHeroThumbnail(path: "https://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", extension: "jpg"),resourceURI: "",comics: SuperHeroComics(available: 1, collectionURI: "", items: [SuperHeroComicsItem(resourceURI: "", name: "Comic 1")], returned: 1),stories: SuperHeroComics(available: 12, collectionURI: "", items: [], returned: 12),events: SuperHeroComics(available: 12, collectionURI: "", items: [], returned: 12), series: SuperHeroComics(available: 12, collectionURI: "", items: [], returned: 12), urls: []), series: [Serie(id: 1, title: "Rocío", description: "", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", imageExtension: .jpg))])
}
