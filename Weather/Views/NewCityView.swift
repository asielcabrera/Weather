//
//  NewCityView.swift
//  Weather
//
//  Created by Asiel Cabrera Gonzalez on 3/21/21.
//

import SwiftUI

struct NewCityView: View {
    @Binding var search: String
    
    @State private var isValidating: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var weatherStore: WeatherStore
    
    @ObservedObject private var cityCompe = CityCompletion()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Search City", text: $search) { _ in

                    } onCommit: {
                        cityCompe.searchTems = search
                    }

                        
                }
                
                Section {
                    ForEach(cityCompe.predictions) { prediction in
                        Button(action: {
                            self.addCity(from: prediction)
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                Text(prediction.name)
                                Text(prediction.country)
                                    .foregroundColor(.primary)
                            }
                            .foregroundColor(.white)
                        }
                    }
                }
            }
                .disabled(isValidating)
                .navigationBarTitle(Text("Add City"))
                .navigationBarItems(leading: cancelButton)
                .listStyle(GroupedListStyle())
        }
    }

    private var cancelButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            self.search = ""
        }) {
            Text("Cancel")
        }
    }
    
    private func addCity(from prediction: CitySearch) {
        isValidating = true
        weatherStore.citiesName.append(prediction.url)
        weatherStore.getData()
        UserDefaults.standard.set(weatherStore.citiesName, forKey: "citiesName")
    }
}

