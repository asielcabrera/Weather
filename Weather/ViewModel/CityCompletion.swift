//
//  CityCompletion.swift
//  Weather
//
//  Created by Asiel Cabrera Gonzalez on 3/22/21.
//

import SwiftUI
import Combine

class CityCompletion: ObservableObject {
    @Published private (set) var predictions: [CitySearch] = []
    
    @Published var searchTems: String = String()
    
    private var cancellables = Set<AnyCancellable>()
    
    //    MARK:- Initiliazer for cities via model
    init() {
        $searchTems
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            .removeDuplicates()
            .map({ (string) -> String? in
                if string.count < 3 {
                    self.predictions = []
                    return nil
                }
                return string
            })
            .compactMap{ $0 }
            .sink { (_) in
                
            } receiveValue: { [self] (searchField) in
                searchItems(searchText: searchField)
                
            }
            .store(in: &cancellables)
        
    }
    
    private func searchItems(searchText: String) {
        
        WeatherManager.getSearchCity(searchText: searchText)
            .receive(on: RunLoop.main)
            .sink { (completed) in
                
            } receiveValue: { [self] (searchCities) in
                predictions = searchCities
            }
            .store(in: &cancellables)
    }
    
}
