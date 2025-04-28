//
//  AlertItem.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 17.03.25.
//

import Foundation
import SwiftUI

struct AlertItem {
    let title: Text
    let message: Text
}

struct AlertContext {
    //MARK: - Network Alerts
    static let invalidData =       AlertItem(title: Text("Server Error"),
                                             message: Text("The data received from the server was invalid. Please try again or contact support."))
    
    static let invalidResponse =   AlertItem(title: Text("Server Error"),
                                             message: Text("Invalid response from the server. Please try again later or contact support."))
    
    static let invalidURL =        AlertItem(title: Text("Server Error"),
                                             message: Text("There was an issue connecting to the server/URL. If this persists please contact support."))
    
    static let unableToComplete =  AlertItem(title: Text("Server Error"),
                                             message: Text("Unable to complete the request at this time. Please check your internet connection"))
}
