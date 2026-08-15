import Foundation
//file contains "models" to convert json into usable code.


struct MangaResponse: Decodable {
    let data: [Manga]
}

struct Manga: Decodable, Identifiable {
    let id: String
    let attributes: MangaAttributes
    let relationships: [Relationship]

    var coverURL: URL?{
        guard let coverFileName = getCoverFileName()
        else{return nil}
        
        return URL(string: "https://uploads.mangadex.org/covers/\(id)/\(coverFileName).256.jpg")
    }
    
    private func getCoverFileName() -> String? {
        guard let coverRelationship = relationships.first(where: {
            $0.type == "cover_art"
        }
        )
        else{return nil}

        return coverRelationship.attributes?.fileName
    }
    
   
    
    
    
}

struct MangaAttributes: Decodable {
    let title: [String: String]
}

struct Relationship: Decodable {
    let id: String
    let type: String
    let attributes: RelationshipAttributes?
}

struct RelationshipAttributes: Decodable{
    let fileName: String?
    let chapter: String?
}





