import Foundation

class ResultArray: Codable {
    var resultCount = 0
    var results = [SearchResult]()
}

class SearchResult: Codable, CustomStringConvertible{
    
    var kind: String? = ""
    
    var artistName: String? = ""
    var trackName: String? = ""
    var collectionName: String?
    
    var itemGenre: String?
    var bookGenre: [String]?
    
    var imageSmall: String? = ""
    var imageLarge: String? = ""
    
    var trackViewURL: String?
    var collectionViewURL: String?
    
    var trackPrice: Double? = 0.0
    var collectionPrice: Double?
    var itemPrice: Double?
    var currency: String? = ""
    
    // computed properties
    var name: String {
        return trackName ?? collectionName ?? ""
    }
    var storeURL: String? {
        return trackViewURL ?? collectionViewURL ?? ""
    }
    var price: Double? {
        return trackPrice ?? collectionPrice ?? itemPrice ?? 0.0
    }
    var genre: String? {
        if let genre = itemGenre{
            return genre
        }else if let genres = bookGenre {
            return genres.joined(separator: ", ")
        }
        return ""
    }
    var description: String {
        return "\n***Result: Kind: \(kind ?? "None") Name: \(name), Artist Name: \(artistName ?? "None")\ngenre = \(genre ?? "None"), price = \(trackPrice ?? 0.0) \(currency ?? "None")\n storeURL: \(storeURL ?? "None")\n imageSmall: \(imageSmall ?? "None")\n imageLarge: \(imageLarge ?? "None")"
    }
    
    var type: String {
        let kind = self.kind ?? "audiobook"
        switch kind {
        case "album": return "Album"
        case "audiobook": return "Audio Book"
        case "book": return "Book"
        case "ebook": return "E-Book"
        case "feature-movie": return "Movie"
        case "music-video": return "Music Video"
        case "podcast": return "Podcast"
        case "software": return "App"
        case "song": return "Song"
        case "tv-episode": return "TV Episode"
        default: return "Unknown"
        }
        
        
    }
    var artist: String {
        return artistName ?? ""
    }
    
    enum CodingKeys: String, CodingKey{
        case imageSmall = "artworkUrl60"
        case imageLarge = "artworkUrl100"
        case itemGenre = "primaryGenreName"
        case bookGenre = "genres"
        case itemPrice = "price"
        
        case kind, artistName, currency
        case trackName, trackPrice, trackViewURL
        case collectionName, collectionViewURL, collectionPrice
    }
}
func < (lhs: SearchResult, rhs: SearchResult) -> Bool{
    return lhs.name.localizedStandardCompare(rhs.name) == .orderedAscending
}
/*
 {
 "wrapperType":"track",
 "kind":"song",
 "artistId":909253,
 "collectionId":120954021,
 "trackId":120954025,
 "artistName":"Jack Johnson",
 "collectionName":"Sing-a-Longs and Lullabies for the Film Curious George",
 "trackName":"Upside Down",
 "collectionCensoredName":"Sing-a-Longs and Lullabies for the Film Curious George",
 "trackCensoredName":"Upside Down",
 "artistViewUrl":"https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewArtist?id=909253",
 "collectionViewUrl":"https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewAlbum?i=120954025&id=120954021&s=143441",
 "trackViewUrl":"https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewAlbum?i=120954025&id=120954021&s=143441",
 "previewUrl":"http://a1099.itunes.apple.com/r10/Music/f9/54/43/mzi.gqvqlvcq.aac.p.m4p",
 "artworkUrl60":"http://a1.itunes.apple.com/r10/Music/3b/6a/33/mzi.qzdqwsel.60x60-50.jpg",
 "artworkUrl100":"http://a1.itunes.apple.com/r10/Music/3b/6a/33/mzi.qzdqwsel.100x100-75.jpg",
 "collectionPrice":10.99,
 "trackPrice":0.99,
 "collectionExplicitness":"notExplicit",
 "trackExplicitness":"notExplicit",
 "discCount":1,
 "discNumber":1,
 "trackCount":14,
 "trackNumber":1,
 "trackTimeMillis":210743,
 "country":"USA",
 "currency":"USD",
 "primaryGenreName":"Rock"}
 */
