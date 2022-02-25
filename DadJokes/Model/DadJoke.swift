//
//  DadJoke.swift
//  DadJokes
//
//  Created by Russell Gordon on 2022-02-22.
//

import Foundation

// The DadJoke structure conforms to the
// Decodable protocol. This means that we want
// Swift to be able to take a JSON object
// and 'decode' into an instance of this structure
// Encodable will let us thurn this data structure to a JSON object.
struct DadJoke: Decodable, Hashable, Encodable {
    let id: String
    let joke: String
    let status: Int
}
