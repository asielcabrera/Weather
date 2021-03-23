//
//  ContentView.swift
//  Weather
//
//  Created by Asiel Cabrera Gonzalez on 3/21/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var weatherStore: WeatherStore
    
    @State var isPresentingModal: Bool = false
    @State private var isEditing: Bool = false
    @State private var search: String = ""
   
    
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Ciudades")) {
                
                    ForEach(weatherStore.cities, id: \.name) { city in
                            CityRow(city: city)
                    }
                        .onDelete(perform: delete)
                        .onMove(perform: move)
                }
            }
            .navigationBarItems(leading: EditButton(), trailing: addButton)
            .navigationBarTitle(Text("Tiempo"))
            .onAppear {
                if weatherStore.cities.count <= 0 && weatherStore.citiesName.count <= 0{
                    self.isPresentingModal = true
                }
            }

        }
        
    }
        
        private var addButton: some View {
            Button(action: {
                self.isPresentingModal = true
            }) {
                Image(systemName: "plus.circle.fill")
                .font(.title)
            }.sheet(isPresented: $isPresentingModal) {
                NewCityView(search: $search).environmentObject(weatherStore)
            }
        }
        
        private func delete(at offsets: IndexSet) {
            
            for index in offsets {
                weatherStore.citiesName.remove(at: index)
                weatherStore.cities.remove(at: index)
                
            }
            UserDefaults.standard.set(weatherStore.citiesName, forKey: "citiesName")
        }

        private func move(from source: IndexSet, to destination: Int) {
            self.weatherStore.citiesName.move(fromOffsets: source, toOffset: destination)
            self.weatherStore.cities.move(fromOffsets: source, toOffset: destination)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
