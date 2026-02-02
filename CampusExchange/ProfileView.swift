import SwiftUI

struct AddItemView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Image(systemName: "plus.circle")
                    .font(.system(size: 80))
                    .foregroundColor(Color("ASUMaroon").opacity(0.3))
                
                Text("Sell an Item")
                    .font(.system(size: 24, weight: .bold))
                
                Text("This feature is coming soon!\nYou'll be able to list items for sale to other ASU students.")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                
                VStack(alignment: .leading, spacing: 12) {
                    FeatureRow(icon: "camera.fill", text: "Add photos of your item")
                    FeatureRow(icon: "text.alignleft", text: "Write a description")
                    FeatureRow(icon: "tag.fill", text: "Set your price")
                    FeatureRow(icon: "checkmark.circle.fill", text: "Publish to marketplace")
                }
                .padding(.horizontal, 32)
                .padding(.top, 16)
                
                Spacer()
            }
            .padding(.top, 60)
            .navigationTitle("Sell")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(Color("ASUMaroon"))
                .frame(width: 24)
            
            Text(text)
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
    }
}

struct ProfileView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(Color("ASUMaroon").opacity(0.1))
                                .frame(width: 64, height: 64)
                            
                            Text(appState.currentUser?.name.prefix(1).uppercased() ?? "?")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(Color("ASUMaroon"))
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(appState.currentUser?.name ?? "User")
                                .font(.system(size: 20, weight: .semibold))
                            
                            Text(appState.currentUser?.email ?? "")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            
                            if appState.currentUser?.isVerified ?? false {
                                HStack(spacing: 4) {
                                    Image(systemName: "checkmark.seal.fill")
                                        .font(.system(size: 12))
                                        .foregroundColor(.blue)
                                    Text("Verified ASU Student")
                                        .font(.system(size: 12))
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                Section(header: Text("My Activity")) {
                    NavigationLink(destination: EmptyView()) {
                        Label("My Listings", systemImage: "tag")
                    }
                    
                    NavigationLink(destination: EmptyView()) {
                        Label("Saved Items", systemImage: "heart")
                    }
                    
                    NavigationLink(destination: EmptyView()) {
                        Label("Purchase History", systemImage: "clock")
                    }
                }
                
                Section(header: Text("Settings")) {
                    NavigationLink(destination: EmptyView()) {
                        Label("Notifications", systemImage: "bell")
                    }
                    
                    NavigationLink(destination: EmptyView()) {
                        Label("Privacy", systemImage: "lock")
                    }
                    
                    NavigationLink(destination: EmptyView()) {
                        Label("Help & Support", systemImage: "questionmark.circle")
                    }
                }
                
                Section {
                    Button(action: {
                        appState.logout()
                    }) {
                        HStack {
                            Label("Log Out", systemImage: "arrow.right.square")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AppState())
}
