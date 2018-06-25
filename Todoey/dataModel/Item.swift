//
//  dataModel.swift
//  Todoey
//
//  Created by Forlefac Fontem on 6/24/18.
//  Copyright © 2018 Forlefac Fontem. All rights reserved.
//

import Foundation

class Item: Codable {
    var title: String = ""
    var done: Bool = false
    
    init() {
    }
}
