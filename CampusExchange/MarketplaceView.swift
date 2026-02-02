import SwiftUI

struct MarketplaceView: View {
    @EnvironmentObject var appState: AppState
    @State private var searchText = ""
    @State private var selectedItem: MarketplaceItem?
    
    var filteredItems: [MarketplaceItem] {
        if searchText.isEmpty {
            return appState.items
        }
        return appState.items.filter { item in
            item.title.localizedCaseInsensitiveContains(searchText) ||
            item.description.localizedCaseInsensitiveContains(searchText) ||
            item.category.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("Search items...", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .padding()
                
                // Items Grid
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 16),
                        GridItem(.flexible(), spacing: 16)
                    ], spacing: 16) {
                        ForEach(filteredItems) { item in
                            ItemCard(item: item)
                                .onTapGesture {
                                    selectedItem = item
                                }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("ASU Marketplace")
            .navigationBarTitleDisplayMode(.large)
            .sheet(item: $selectedItem) { item in
                ItemDetailView(item: item)
                    .environmentObject(appState)
            }
        }
    }
}

struct ItemCard: View {
    let item: MarketplaceItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image
            ZStack {
                LinearGradient(
                    colors: [
                        Color("ASUMaroon").opacity(0.1),
                        Color("ASUGold").opacity(0.1)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                Text(item.imageEmoji)
                    .font(.system(size: 60))
            }
            .frame(height: 140)
            .frame(maxWidth: .infinity)
            .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(item.title)
                        .font(.system(size: 16, weight: .semibold))
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Text("$\(String(format: "%.0f", item.price))")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color("ASUMaroon"))
                }
                
                Text(item.description)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                HStack {
                    Text(item.category)
                        .font(.system(size: 10))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    
                    Spacer()
                    
                    Text(item.condition)
                        .font(.system(size: 10))
                        .foregroundColor(.gray)
                }
            }
            .padding(12)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

struct ItemDetailView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    let item: MarketplaceItem
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Image
                    ZStack {
                        LinearGradient(
                            colors: [
                                Color("ASUMaroon").opacity(0.1),
                                Color("ASUGold").opacity(0.1)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        
                        Text(item.imageEmoji)
                            .font(.system(size: 120))
                    }
                    .frame(height: 280)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(16)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        // Title and Price
                        HStack(alignment: .top) {
                            Text(item.title)
                                .font(.system(size: 28, weight: .bold))
                            
                            Spacer()
                            
                            Text("$\(String(format: "%.2f", item.price))")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(Color("ASUMaroon"))
                        }
                        
                        // Description
                        Text(item.description)
                            .font(.system(size: 16))
                            .foregroundColor(.primary)
                        
                        // Tags
                        HStack(spacing: 12) {
                            TagView(text: item.category)
                            TagView(text: item.condition)
                        }
                        
                        Divider()
                            .padding(.vertical, 8)
                        
                        // Seller Info
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Seller")
                                .font(.system(size: 16, weight: .semibold))
                            
                            Text(item.seller.name)
                                .font(.system(size: 16))
                                .foregroundColor(.primary)
                            
                            Text(item.seller.email)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                        
                        // Contact Button
                        Button(action: {
                            let conversation = appState.startConversation(with: item)
                            dismiss()
                            // In a real app, would navigate to messages
                        }) {
                            HStack {
                                Image(systemName: "message.fill")
                                Text("Contact Seller")
                            }
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color("ASUMaroon"))
                            .cornerRadius(12)
                        }
                        .padding(.top, 8)
                    }
                }
                .padding()
            }
            .navigationTitle("Item Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
}

struct TagView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 12))
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(16)
    }
}

#Preview {
    MarketplaceView()
        .environmentObject(AppState())
}
