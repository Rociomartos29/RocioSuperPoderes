//
//  HerosRowView.swift
//  SuperPoderesRocio
//
//  Created by Rocio Martos on 26/4/24.
//

import SwiftUI

struct HerosRowView: View {
    var hero: SuperHero
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: hero.thumbnail.path + "." + hero.thumbnail.extension)) { image in
                image
                    .resizable()
                
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 20)
                
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding([.leading, .trailing],20)
                    .opacity(0.6)
            }
            Text(hero.name)
                .font(.title)
                .foregroundStyle(.gray)
                .bold()
        }
    }
}

#Preview {
    HerosRowView(hero: SuperHero(id: 1,name: "Rocío", description: "Rocío, una guerrera feroz y noble, empuña su espada con destreza mientras defiende los reinos de la injusticia. Dotada de habilidades sobrenaturales y un coraje inquebrantable, Valquiria lucha sin descanso para proteger a los inocentes y hacer prevalecer la justicia en un mundo lleno de peligros. Su valentía inspira esperanza y su determinación es la luz que guía en las tinieblas de la adversidad.",modified: "",thumbnail: SuperHeroThumbnail(path: "https://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", extension: "jpg"),resourceURI: "",comics: SuperHeroComics(available: 1, collectionURI: "", items: [SuperHeroComicsItem(resourceURI: "", name: "Comic 1")], returned: 1),stories: SuperHeroComics(available: 12, collectionURI: "", items: [], returned: 12),events: SuperHeroComics(available: 12, collectionURI: "", items: [], returned: 12),series: SuperHeroComics(available: 12, collectionURI: "", items: [], returned: 12),urls: []))
}
