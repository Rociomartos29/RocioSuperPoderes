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
                ForEach(viewModel.heroes){ data in
                    NavigationLink{
                        HeroDetailView(hero: data, series: [])
                    }label:{
                        HerosRowView(hero: data)
                        
                    }
                    
                    
                }
            }
        }
        .onAppear{
            viewModel.fetchHeroes(filter: "")
        }
        .searchable(text: $filter, prompt: Text("Buscar por nombre"))
    }
}
    




#Preview {
    HerosListView(viewModel: HeroViewModel())
}
