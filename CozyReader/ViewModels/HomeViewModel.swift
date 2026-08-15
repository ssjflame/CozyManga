import Foundation
import Observation

@Observable
class HomeViewModel{
    var mangaResults: [Manga] = []
    var latestChapter: [String: String] = [:]
    private var offset = 0
    private var isLoading = false
    
    var displayableManga: [Manga] {
        mangaResults.filter {
            $0.attributes.title["en"] != nil
        }
    }
    private var hasMoreManga = true
    
    func loadManga() async{
        if(isLoading || !hasMoreManga){
            return
        }
        
        isLoading = true
        
        do {
            let newManga = try await MangaDexService().fetchManga(offset: offset)
            
            mangaResults.append(contentsOf: newManga)
            
            offset += 20
            
            if newManga.count < 20{
                hasMoreManga = false
            }
            
        } catch {
            print("Failed to fetch manga: \(error.localizedDescription)")
        }
        isLoading = false
    }
    
    
    
    
    
}
