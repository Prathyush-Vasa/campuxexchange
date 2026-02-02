import Foundation
import SwiftUI

class AppState: ObservableObject {
    @Published var currentUser: User?
    @Published var items: [MarketplaceItem] = []
    @Published var conversations: [Conversation] = []
    @Published var isLoggedIn = false
    
    init() {
        loadSampleData()
    }
    
    func login(email: String, password: String) -> Bool {
        // Simple validation for demo
        if email.hasSuffix("@asu.edu") && !password.isEmpty {
            currentUser = User(name: email.components(separatedBy: "@").first ?? "User", 
                             email: email, 
                             isVerified: true)
            isLoggedIn = true
            return true
        }
        return false
    }
    
    func signup(name: String, email: String, password: String) -> Bool {
        if email.hasSuffix("@asu.edu") && !password.isEmpty && password.count >= 6 {
            return true // In real app, would send verification email
        }
        return false
    }
    
    func verifyEmail(code: String, name: String, email: String) -> Bool {
        // For demo purposes, accept any 6-digit code
        if code.count == 6 {
            currentUser = User(name: name, email: email, isVerified: true)
            isLoggedIn = true
            return true
        }
        return false
    }
    
    func logout() {
        currentUser = nil
        isLoggedIn = false
    }
    
    func startConversation(with item: MarketplaceItem) -> Conversation {
        // Check if conversation already exists
        if let existing = conversations.first(where: { $0.itemId == item.id && $0.otherUser.id == item.seller.id }) {
            return existing
        }
        
        // Create new conversation
        let newConvo = Conversation(
            itemId: item.id,
            itemTitle: item.title,
            otherUser: item.seller,
            messages: []
        )
        conversations.append(newConvo)
        return newConvo
    }
    
    func sendMessage(to conversationId: UUID, text: String) {
        guard let currentUser = currentUser,
              let index = conversations.firstIndex(where: { $0.id == conversationId }) else {
            return
        }
        
        let message = Message(text: text, senderId: currentUser.id)
        conversations[index].messages.append(message)
    }
    
    private func loadSampleData() {
        // Sample users
        let sarah = User(name: "Sarah Johnson", email: "sjohnson@asu.edu", isVerified: true)
        let mike = User(name: "Mike Chen", email: "mchen@asu.edu", isVerified: true)
        let emma = User(name: "Emma Davis", email: "edavis@asu.edu", isVerified: true)
        let james = User(name: "James Wilson", email: "jwilson@asu.edu", isVerified: true)
        
        // Sample items
        items = [
            MarketplaceItem(
                title: "Calculus Textbook",
                price: 45.00,
                description: "Barely used, like new condition. Perfect for MAT 265/266",
                category: "Books",
                condition: "Like New",
                imageEmoji: "📚",
                seller: sarah
            ),
            MarketplaceItem(
                title: "Mini Fridge",
                price: 80.00,
                description: "Great for dorm room. Works perfectly, moving out sale",
                category: "Furniture",
                condition: "Good",
                imageEmoji: "❄️",
                seller: mike
            ),
            MarketplaceItem(
                title: "iPhone 13 Case",
                price: 15.00,
                description: "Purple protective case, never dropped",
                category: "Electronics",
                condition: "Excellent",
                imageEmoji: "📱",
                seller: emma
            ),
            MarketplaceItem(
                title: "ASU Hoodie - Large",
                price: 25.00,
                description: "Official ASU merch, gently worn",
                category: "Clothing",
                condition: "Good",
                imageEmoji: "👕",
                seller: james
            ),
            MarketplaceItem(
                title: "Desk Lamp",
                price: 12.00,
                description: "LED desk lamp with adjustable brightness",
                category: "Furniture",
                condition: "Like New",
                imageEmoji: "💡",
                seller: sarah
            ),
            MarketplaceItem(
                title: "Scientific Calculator",
                price: 20.00,
                description: "TI-84 Plus, works great for all math classes",
                category: "Electronics",
                condition: "Good",
                imageEmoji: "🔢",
                seller: mike
            )
        ]
    }
}
