import Foundation

struct ChapterResponse : Decodable {
    let data : [Chapter]
}

struct Chapter : Decodable{
    let attributes: ChapterAttributes
 
}

struct ChapterAttributes: Decodable {
    let chapter: String?
}
