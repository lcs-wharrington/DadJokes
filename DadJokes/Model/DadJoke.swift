//
//  DadJoke.swift
//  DadJokes
//
//  Created by William Robert Harrington on 2022-02-22.
//

import Foundation

struct DadJoke: Decodable, Hashable {
    
    let id: String
    let joke: String
    let status: Int
    
}
