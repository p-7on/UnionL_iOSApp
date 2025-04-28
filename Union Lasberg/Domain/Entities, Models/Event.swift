//
//  Event.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 13.03.25.
//

import Foundation

struct Event: Hashable {
    let id = UUID()
    var title: String
    var location: String?
    var date: Date
    var startTime: String
    var endTime: String
}
