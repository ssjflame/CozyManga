import Foundation
import Observation

@Observable
class HomeViewModel{
    var mangaResults: [Manga] = []
    
    func loadManga() async{
        do {
            mangaResults = try await MangaDexService().fetchManga()
        } catch {
            print("Failed to fetch manga: \(error.localizedDescription)")
        }
    }
    
    
    
}
