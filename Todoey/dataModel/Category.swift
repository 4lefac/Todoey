//
//  Category.swift
//  Todoey
//
//  Created by Forlefac Fontem on 6/26/18.
//  Copyright © 2018 Forlefac Fontem. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
