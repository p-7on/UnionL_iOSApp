//
//  Person.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 21.03.25.
//

import Foundation

struct Person {
    let firtName: String
    let lastName: String
    let email: String
    let phone: String?
    let imageURL: String
}

struct MockDataPerson {
    
    let mockPerson = Person(firtName: "Peter", lastName: "Lauritz", email: "peter.lauritz@unionl.at", phone: "123456789", imageURL: "https://www.union-lasberg.at/wp-content/uploads/2024/07/lauritz-peter-scaled.jpeg")
    
}
