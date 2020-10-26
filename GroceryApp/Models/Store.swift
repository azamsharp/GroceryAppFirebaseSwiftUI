//
//  Store.swift
//  GroceryApp
//
//  Created by Mohammad Azam on 10/21/20.
//

import Foundation

struct Store: Codable {
    var id: String?
    let name: String
    var items: [String]? = nil 
}
