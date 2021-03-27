//
//  Condition.swift
//  Weather
//
//  Created by Asiel Cabrera Gonzalez on 3/21/21.
//

import SwiftUI
import Combine

struct Condition: Codable {
    let text, icon: String
    let code: Int
}



class remoteImageURL: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    init(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }.resume()
    }
}
