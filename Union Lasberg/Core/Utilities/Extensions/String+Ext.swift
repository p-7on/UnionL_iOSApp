//
//  String+Ext.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 12.03.25.
//

import Foundation

extension String {
    
    func dateFormatter() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.locale = Locale(identifier: "de_DE")
        formatter.timeZone = TimeZone(identifier: "UTC")
        
        return formatter.date(from: self)!
    }
    
    func htmlToString() -> String {
        // Ersetze doppelte Zeilenumbrüche im HTML durch einen eindeutigen Platzhalter
        let placeholder = "DOUBLE_NEWLINE_PLACEHOLDER"
        let modifiedHTML = self
            .replacingOccurrences(of: "</p>\n<p>", with: "</p>\(placeholder)<p>")
            .replacingOccurrences(of: "</p>\n<p style=\"font-weight: 400;\">", with: "</p>\(placeholder)<p>")
        
        guard let data = modifiedHTML.data(using: .utf16) else { return self }
        
        do {
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            
            // Konvertiere das HTML in einen NSAttributedString
            let attributedString = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            
            // Konvertiere den NSAttributedString in einen normalen String
            let plainText = attributedString.string
            
            // Ersetze den Platzhalter wieder durch doppelte Zeilenumbrüche
            return plainText.replacingOccurrences(of: placeholder, with: "")
        } catch {
            return self
        }
    }
    
    func extractImage(from htmlContent: String) -> String? {
        let pattern = "<img[^>]+src=[\"']([^\"']+)[\"']"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        
        let range = NSRange(location: 0, length: htmlContent.utf16.count)
        if let match = regex.firstMatch(in: htmlContent, options: [], range: range) {
            if let range = Range(match.range(at: 1), in: htmlContent) {
                return String(htmlContent[range]) // Gefundene Bild-URL zurückgeben
            }
        }
        return nil
    }
}
