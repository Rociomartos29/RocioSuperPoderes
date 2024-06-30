//
//  HerosListView.swift
//  SuperPoderesRocio
//
//  Created by Rocio Martos on 26/4/24.
//

import SwiftUI

struct HerosListView: View {
    @StateObject var viewModel = HeroViewModel()
    @State private var filter: String = ""
    
    
    var body: some View {
        NavigationStack{
            List{
                if let data = viewModel.dataHeros?.data?.results{
                    ForEach(data){ hero in
                        // HeroRowView(hero: hero)
                        NavigationLink(
                            destination: HeroDetailView(hero: hero),
                            label: {
                                HerosRowView(hero: hero)
                            })
                    }
                }
            }
        }
        .task{
            await viewModel.fetchHeroes()
        }
        .searchable(text: $filter, prompt: Text("Buscar por nombre"))
    }
}
    




#Preview {
    HerosListView(viewModel: HeroViewModel())
}
