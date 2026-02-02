import SwiftUI

struct MessagesListView: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedConversation: Conversation?
    
    var body: some View {
        NavigationView {
            Group {
                if appState.conversations.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "message")
                            .font(.system(size: 64))
                            .foregroundColor(.gray.opacity(0.3))
                        
                        Text("No conversations yet")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.gray)
                        
                        Text("Contact a seller to start chatting")
                            .font(.system(size: 14))
                            .foregroundColor(.gray.opacity(0.8))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(appState.conversations) { conversation in
                            ConversationRow(conversation: conversation)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    selectedConversation = conversation
                                }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Messages")
            .navigationBarTitleDisplayMode(.large)
            .sheet(item: $selectedConversation) { conversation in
                ChatView(conversation: conversation)
                    .environmentObject(appState)
            }
        }
    }
}

struct ConversationRow: View {
    let conversation: Conversation
    
    var body: some View {
        HStack(spacing: 16) {
            // Avatar
            ZStack {
                Circle()
                    .fill(Color("ASUMaroon").opacity(0.1))
                    .frame(width: 50, height: 50)
                
                Text(conversation.otherUser.name.prefix(1))
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color("ASUMaroon"))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(conversation.otherUser.name)
                    .font(.system(size: 16, weight: .semibold))
                
                Text("Re: \(conversation.itemTitle)")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}

struct ChatView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    let conversation: Conversation
    
    @State private var messageText = ""
    @State private var messages: [Message] = []
    
    var currentConversation: Conversation? {
        appState.conversations.first(where: { $0.id == conversation.id })
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Messages
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(currentConversation?.messages ?? []) { message in
                                MessageBubble(
                                    message: message,
                                    isCurrentUser: message.senderId == appState.currentUser?.id
                                )
                                .id(message.id)
                            }
                        }
                        .padding()
                    }
                    .onChange(of: currentConversation?.messages.count) { _ in
                        if let lastMessage = currentConversation?.messages.last {
                            withAnimation {
                                proxy.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                    }
                }
                
                Divider()
                
                // Input
                HStack(spacing: 12) {
                    TextField("Type a message...", text: $messageText)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(24)
                    
                    Button(action: sendMessage) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(messageText.isEmpty ? .gray : Color("ASUMaroon"))
                    }
                    .disabled(messageText.isEmpty)
                }
                .padding()
            }
            .navigationTitle(conversation.otherUser.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(conversation.otherUser.name)
                            .font(.system(size: 16, weight: .semibold))
                        Text("Re: \(conversation.itemTitle)")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
    
    private func sendMessage() {
        guard !messageText.isEmpty else { return }
        
        appState.sendMessage(to: conversation.id, text: messageText)
        messageText = ""
    }
}

struct MessageBubble: View {
    let message: Message
    let isCurrentUser: Bool
    
    var body: some View {
        HStack {
            if isCurrentUser {
                Spacer()
            }
            
            VStack(alignment: isCurrentUser ? .trailing : .leading, spacing: 4) {
                Text(message.text)
                    .font(.system(size: 16))
                    .foregroundColor(isCurrentUser ? .white : .primary)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(isCurrentUser ? Color("ASUMaroon") : Color.gray.opacity(0.1))
                    .cornerRadius(20)
                
                Text(message.timestamp, style: .time)
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: 280, alignment: isCurrentUser ? .trailing : .leading)
            
            if !isCurrentUser {
                Spacer()
            }
        }
    }
}

#Preview {
    MessagesListView()
        .environmentObject(AppState())
}
