//
//  Category.swift
//  Todoey
//
//  Created by Aleksandra Sobot on 26.8.22..
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @Persisted var name: String = ""
    @Persisted var categoryColor: String = ""
    @Persisted var categoryID = UUID().uuidString
    @Persisted var items = List<Item>()
}
