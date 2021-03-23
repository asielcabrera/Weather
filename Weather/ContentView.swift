//
//  ContentView.swift
//  Weather
//
//  Created by Asiel Cabrera Gonzalez on 3/21/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var weatherStore: WeatherStore
    @ObservedObject var locationProvider : LocationProvider
        
    @State var isPresentingModal: Bool = false
    @State private var isEditing: Bool = false
    @State private var search: String = ""
   
    init() {
            locationProvider = LocationProvider()
            locationProvider.lm.allowsBackgroundLocationUpdates = false
            do {try locationProvider.start()}
            catch {
                print("No location access.")
                locationProvider.requestAuthorization()
            }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Cities")) {
                    ForEach(weatherStore.cities, id: \.name) { city in
                            CityRow(city: city)
                    }
                        .onDelete(perform: delete)
                        .onMove(perform: move)
                }
            }
            .navigationBarItems(leading: EditButton(), trailing: addButton)
            .navigationBarTitle(Text("Weather"))
            .onAppear {
                if weatherStore.cities.count <= 0 && weatherStore.citiesName.count <= 0 {
                    self.weatherStore.citiesName.append("\(locationProvider.location?.coordinate.latitude ?? 0),\(locationProvider.location?.coordinate.longitude ?? 0)")
                    self.weatherStore.getData()
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
