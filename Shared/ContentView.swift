//
//  ContentView.swift
//  Shared
//
//  Created by Tariq Almazyad on 6/3/22.
//

import SwiftUI
import LoremSwiftum

enum PetsOptions: String, CaseIterable {
    case allPets
    case dogs
    case cats
    case birds
    
    var title: String {
        switch self {
        case .dogs:     return "Dogs"
        case .cats:     return "Cats"
        case .birds:    return "Birds"
        case .allPets:  return "All Pets"
        }
    }
}

struct PetModel: Identifiable, Hashable {
    let id: String = UUID().uuidString
    let imageName: String
    let name: String
    let petType: PetsOptions
}

struct ContentView: View {
    @State var selectedPet: PetsOptions = .dogs
    
    @State var myPetsOneArray: [PetModel] = [
        PetModel(imageName: "dog1", name: Lorem.firstName, petType: .dogs),
        PetModel(imageName: "dog2", name: Lorem.firstName, petType: .dogs),
        PetModel(imageName: "dog3", name: Lorem.firstName, petType: .dogs),
        PetModel(imageName: "dog4", name: Lorem.firstName, petType: .dogs),
        PetModel(imageName: "dog5", name: Lorem.firstName, petType: .dogs),
        PetModel(imageName: "dog6", name: Lorem.firstName, petType: .dogs),
        
        PetModel(imageName: "bird1", name: Lorem.firstName, petType: .birds),
        PetModel(imageName: "bird2", name: Lorem.firstName, petType: .birds),
        PetModel(imageName: "bird3", name: Lorem.firstName, petType: .birds),
        PetModel(imageName: "bird4", name: Lorem.firstName, petType: .birds),
        PetModel(imageName: "bird5", name: Lorem.firstName, petType: .birds),
        PetModel(imageName: "bird6", name: Lorem.firstName, petType: .birds),
        
        PetModel(imageName: "cat1", name: Lorem.firstName, petType: .cats),
        PetModel(imageName: "cat2", name: Lorem.firstName, petType: .cats),
        PetModel(imageName: "cat3", name: Lorem.firstName, petType: .cats),
        PetModel(imageName: "cat4", name: Lorem.firstName, petType: .cats),
        PetModel(imageName: "cat5", name: Lorem.firstName, petType: .cats),
    ]
    
    let columns = [ GridItem(.adaptive(minimum: 150)) ]
    let data = (1...100).map { "Item \($0)" }
    var body: some View {
        NavigationView{
            VStack{
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(PetsOptions.allCases, id:\.self) { petOption in
                            Button {
                                withAnimation {
                                    selectedPet = petOption
                                }
                            } label: {
                                Text(petOption.title)
                                    .padding()
                                    .background(selectedPet == petOption ? Color.purple : Color.clear)
                                    .cornerRadius(12)
                                    .foregroundColor(.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.white, lineWidth: 0.4)
                                    )
                            }
                            
                        }
                    }.padding()
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    if selectedPet == .allPets {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(myPetsOneArray.shuffled(), id: \.self) { pet in
                                Button {
                                    
                                } label: {
                                    VStack{
                                        Image(pet.imageName)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 140, height: 140)
                                            .cornerRadius(12)
                                            .clipped()
                                        Text(pet.name)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }.padding(.horizontal)
                            
                    } else {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(myPetsOneArray.filter({$0.petType == selectedPet}), id: \.self) { pet in
                                Button {
                                    
                                } label: {
                                    VStack{
                                        Image(pet.imageName)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 140, height: 140)
                                            .cornerRadius(12)
                                            .clipped()
                                        Text(pet.name)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }.padding(.horizontal)
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Selection Category")
        }.navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}


