import Foundation


struct MangaDexService{
    
    func fetchManga() async throws -> [Manga] {
        guard let url = URL(
            string: "https://api.mangadex.org/manga?title=poo&limit=100&includes[]=cover_art"
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
}

