import Foundation

// MARK: - User Model
struct User: Identifiable, Codable {
    let id: UUID
    var name: String
    var email: String
    var isVerified: Bool
    
    init(id: UUID = UUID(), name: String, email: String, isVerified: Bool = false) {
        self.id = id
        self.name = name
        self.email = email
        self.isVerified = isVerified
    }
}

// MARK: - Item Model
struct MarketplaceItem: Identifiable, Codable {
    let id: UUID
    var title: String
    var price: Double
    var description: String
    var category: String
    var condition: String
    var imageEmoji: String
    var seller: User
    var datePosted: Date
    
    init(id: UUID = UUID(), title: String, price: Double, description: String, category: String, condition: String, imageEmoji: String, seller: User, datePosted: Date = Date()) {
        self.id = id
        self.title = title
        self.price = price
        self.description = description
        self.category = category
        self.condition = condition
        self.imageEmoji = imageEmoji
        self.seller = seller
        self.datePosted = datePosted
    }
}

// MARK: - Message Model
struct Message: Identifiable, Codable {
    let id: UUID
    var text: String
    var senderId: UUID
    var timestamp: Date
    
    init(id: UUID = UUID(), text: String, senderId: UUID, timestamp: Date = Date()) {
        self.id = id
        self.text = text
        self.senderId = senderId
        self.timestamp = timestamp
    }
}

// MARK: - Conversation Model
struct Conversation: Identifiable, Codable {
    let id: UUID
    var itemId: UUID
    var itemTitle: String
    var otherUser: User
    var messages: [Message]
    
    init(id: UUID = UUID(), itemId: UUID, itemTitle: String, otherUser: User, messages: [Message] = []) {
        self.id = id
        self.itemId = itemId
        self.itemTitle = itemTitle
        self.otherUser = otherUser
        self.messages = messages
    }
}

// MARK: - Category Enum
enum ItemCategory: String, CaseIterable {
    case books = "Books"
    case furniture = "Furniture"
    case electronics = "Electronics"
    case clothing = "Clothing"
    case other = "Other"
}

// MARK: - Condition Enum
enum ItemCondition: String, CaseIterable {
    case new = "New"
    case likeNew = "Like New"
    case excellent = "Excellent"
    case good = "Good"
    case fair = "Fair"
}
