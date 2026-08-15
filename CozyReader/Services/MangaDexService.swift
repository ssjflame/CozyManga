import Foundation


struct MangaDexService{
    
    func fetchManga(offset : Int) async throws -> [Manga] {
        guard let url = URL(
            string: "https://api.mangadex.org/manga?title=a&limit=20&offset=\(offset)&includes[]=cover_art"
        ) else {
            return []
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decodedResponse = try JSONDecoder().decode(
            MangaResponse.self,
            from: data
        )
        
        return decodedResponse.data
        
    }
    
    
    func fetchLatestChapter(for manga: Manga) async throws -> String? {
        guard let url = URL(
            string: "https://api.mangadex.org/chapter?manga=\(manga.id)&translatedLanguage[]=en&order[chapter]=desc&limit=1"
        )else{return nil}
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decodedResponse = try JSONDecoder().decode(
            ChapterResponse.self,
            from: data
        )
        
        return decodedResponse.data.first?.attributes.chapter
        
    
    }
}

