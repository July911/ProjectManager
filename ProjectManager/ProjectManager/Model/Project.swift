import Foundation

struct Project: Codable, Listable {
    
    var name: String
    var detail: String
    var deadline: Date
    var identifer: UUID?
}