//
//  ContentView.swift
//  navigationStack
//
//  Created by David Grammatico on 10/08/2023.
//

import SwiftUI

struct CardBrand: Identifiable, Hashable {
    let name: String
    let id = UUID()
}

struct Car: Identifiable, Hashable {
    let id = UUID()
    let make: String
    let model: String
    let year: Int
    
    var description: String {
        return "\(year) \(make) \(model)"
    }
}
struct ContentView: View {
    let brands: [CardBrand] = [
        .init(name: "Ferrari"),
        .init(name: "Mercedes"),
        .init(name: "Audi"),
        .init(name: "Peugeot")
    ]
    
    let cars :[Car] = [
        .init(make: "Ferrari", model: "488", year: 2022),
        .init(make: "Peugeot", model: "208", year: 2023),
        .init(make: "Mercedes", model: "AMG 63", year: 2019),
        .init(make: "Audi", model: "R8", year: 2018)
    ]
    @State private var navigationPath = [CardBrand]()
    @State private var showFullStack = false
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                List {
                    Section("Marques") {
                        ForEach(brands) { brand in
                            NavigationLink(value: brand) {
                                Text(brand.name)
                            }
                        }
                    }
                    Section("Voitures") {
                        ForEach(cars) { car in
                            NavigationLink(value: car) {
                                Text(car.description)
                            }
                        }
                    }
                }
                .navigationDestination(for: CardBrand.self) { brand in
                    VStack {
                        viewForBrand(brand)
                        
                        Button {
                            navigationPath = []
                        } label: {
                            Text("Go to root")
                        }

                    }
                }
                .navigationDestination(for: Car.self) { car in
                    Text("New \(car.description)")
                    // Non applicable car il y a un path
                }
                Button {
                    showFullStack.toggle()
                    if showFullStack {
                        navigationPath = brands
                    } else {
                        navigationPath = [brands[0], brands[2]]
                    }
                } label: {
                    Text("View all")
                }

            }
        }
    }

    func viewForBrand(_ brand: CardBrand) -> some View {
        switch brand.name {
        case "Ferrari":
            return HStack {
                Text(brand.name)
            }
            .background {
                Color.red
            }
        case "Mercedes":
            return HStack {
                Text(brand.name)
            }
            .background {
                Color.green
            }
        case "Audi":
            return HStack {
                Text(brand.name)
            }
            .background {
                Color.blue
            }
        case "Peugeot":
            return HStack {
                Text(brand.name)
            }
            .background {
                Color.yellow
            }
        default:
            return HStack {
                Text("Aucune marque")
            }
            .background {
                Color.black
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
