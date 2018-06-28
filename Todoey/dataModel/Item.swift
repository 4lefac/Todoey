//
//  Item.swift
//  Todoey
//
//  Created by Forlefac Fontem on 6/26/18.
//  Copyright © 2018 Forlefac Fontem. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
