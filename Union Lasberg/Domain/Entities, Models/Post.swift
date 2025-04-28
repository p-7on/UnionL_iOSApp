//
//  HomeArticle.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 11.03.25.
//

import Foundation

struct Post: Decodable, Identifiable, Hashable {
    let id: Int
    var date: Date
    let link: String
    var title: String
    var content: String
    var excerpt: String
    let featuredMediaID: Int
    let categories: [Int]
    
    var imageURL: String?
   
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case link
        case title
        case content
        case excerpt
        case featuredMediaID = "featured_media"
        case categories
    }
    
    init(id: Int, date: Date, link: String, title: String, content: String, excerpt: String, featuredMediaID: Int, categories: [Int], imageURL: String? = nil) {
            self.id = id
            self.date = date
        self.link = link
            self.title = title
            self.content = content
            self.excerpt = excerpt
            self.featuredMediaID = featuredMediaID
            self.categories = categories
            self.imageURL = imageURL
        }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        
        let dateString = try container.decode(String.self, forKey: .date)
        date = dateString.dateFormatter()
        
        self.link = try container.decode(String.self, forKey: .link)
        self.title = try container.decode(RenderedText.self, forKey: .title).rendered
        self.content = try container.decode(RenderedText.self, forKey: .content).rendered
        self.excerpt = try container.decode(RenderedText.self, forKey: .excerpt).rendered
        self.featuredMediaID = try container.decode(Int.self, forKey: .featuredMediaID)
        self.categories = try container.decode([Int].self, forKey: .categories)
    }
    
}

struct RenderedText: Decodable {
    var rendered: String
}


struct MockDataHomePost {
    
    static let sampleHomePost1 = Post(
        id: 1711019,
        date: Date(),
        link: "https://www.union-lasberg.at/ferienprogramm-2024/",
        title: "Bewegungsangebote starten bald!",
        content: "Bald es geht los und die Bewegungsangebote unserer Sektion #Fitness&amp;Bewegung gehen wieder los! Kosten der Bewegungsangebote: Saisonbeitrag (10x) für Union-Mitglieder 25€ und für Nicht-Mitglieder 30€! 10-er Block für Union Mitglied",
        excerpt: "Bald es geht los und die Bewegungsangebote unserer Sektion <a href=",
        featuredMediaID: 1709555,
        categories: [13],
        imageURL: "https://www.union-lasberg.at/wp-content/uploads/2022/03/UL_Logo_original.png"
    )
    
    static let sampleHomePost2 = Post(
        id: 1709334,
        date: Date(),
        link: "https://www.union-lasberg.at/ferienprogramm-2024/",
        title: "Abschied unserer Nummer 7 Tomas Lestina",
        content: "178 Tore, 136 Siege, 300 Spiele und 25179 Einsatzminuten das ist die unglaubliche Bilanz von Tomas Lestina #7 bei der Sportunion Lasberg. Doch Lesti war viel mehr als nur ein Spieler er war Freund, Spaßmacher und stets ein Vorbild auf dem Platz. Auch seine Breackdance Einlagen werden Allen in Erinnerung bleiben. Jetzt heißt es Abschied nehmen!",
        excerpt: "178 Tore, 136 Siege, 300 Spiele und 25179 Einsatzminuten das ist die unglaubliche Bilanz von Tomas Lestina #7 bei der Sportunion Lasberg. Doch Lesti war viel mehr als nur",
        featuredMediaID: 1705559,
        categories: [2],
        imageURL: "https://www.union-lasberg.at/wp-content/uploads/2024/09/20240922_175916.png"
    )
    
    static let homePosts = [sampleHomePost1, sampleHomePost2]
}
