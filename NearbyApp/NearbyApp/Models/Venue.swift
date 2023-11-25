struct Venue: Codable, Identifiable {
    let name: String
    let url: String
    let city: String
    let country: String
    let id: Int
}

struct Venues: Codable {
    let venues: [Venue]
}
