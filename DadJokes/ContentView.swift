//
//  ContentView.swift
//  DadJokes
//
//  Created by Russell Gordon on 2022-02-21.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Stored properties
    @State var currentJoke: DadJoke = DadJoke(id: "", joke: "Knock, knock...", status: 0)
    
    //hold a list of favouite jokes
    @State var favourites: [DadJoke] = []
    
    //
    @State var currentJokeAddedToFavourites: Bool = false
    
    
    // MARK: Computed properties
    var body: some View {
        VStack {
            
            Text(currentJoke.joke)
                .font(.title)
                .multilineTextAlignment(.leading)
                .padding(30)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.primary, lineWidth: 4)
                )
                .padding(10)
            
            Image(systemName: "heart.circle")
                .font(.largeTitle)
                .foregroundColor(currentJokeAddedToFavourites == true ? .red : .secondary)
                .onTapGesture {
                    
                    if currentJokeAddedToFavourites == false {
                    
                    // add the current joke to list
                    favourites.append(currentJoke)
                    
                    //Keep track of joke becouming a favourite
                    currentJokeAddedToFavourites = true
                        
                    }
                }
            
            Button(action: {
               
                Task { await loadNewJoke()}
           
            }, label: {
                
                Text("Another one!")
            })
                .buttonStyle(.bordered)
            
            HStack {
                
                Text("Favourites")
                    .bold()
                
                Spacer()
            }
            
            List(favourites, id: \.self) { currentJoke in
                
                Text(currentJoke.joke)
                
            }
            
            Spacer()
                        
        }
        // When the app opens, get a new joke from the web service
        .task {
            
            // By typeing await It is acknowlging the this function is asyncrounes.
           await  loadNewJoke()
            
        }
        .navigationTitle("icanhazdadjoke?")
        .padding()
    }
    
    // MARK: Functions
    
    // this function loads a new joke.
    func loadNewJoke() async {
        
        // Assemble the URL that points to the endpoint
        let url = URL(string: "https://icanhazdadjoke.com/")!
        
        // Define the type of data we want from the endpoint
        // Configure the request to the web site
        var request = URLRequest(url: url)
        // Ask for JSON data
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Start a session to interact (talk with) the endpoint
        let urlSession = URLSession.shared
        
        // Try to fetch a new joke
        // It might not work, so we use a do-catch block
        do {
            
            // Get the raw data from the endpoint
            let (data, _) = try await urlSession.data(for: request)
            
            // Attempt to decode the raw data into a Swift structure
            // Takes what is in "data" and tries to put it into "currentJoke"
            //                                 DATA TYPE TO DECODE TO
            //                                         |
            //                                         V
            currentJoke = try JSONDecoder().decode(DadJoke.self, from: data)
            
            //we need to check if the current joke is already a favourite
            currentJokeAddedToFavourites = false
            
        } catch {
            print("Could not retrieve or decode the JSON from endpoint.")
            // Print the contents of the "error" constant that the do-catch block
            // populates
            print(error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
