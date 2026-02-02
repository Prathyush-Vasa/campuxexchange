import SwiftUI

struct AuthenticationView: View {
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.545, green: 0.176, blue: 0.306),
                    Color(red: 0.420, green: 0.114, blue: 0.243)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                // Logo and Header
                VStack(spacing: 16) {
                    // Logo icon
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(red: 0.545, green: 0.176, blue: 0.306).opacity(0.3))
                            .frame(width: 60, height: 60)
                        
                        Image(systemName: "building.columns.fill")
                            .font(.system(size: 28))
                            .foregroundColor(Color(red: 0.831, green: 0.686, blue: 0.216))
                    }
                    
                    // Title
                    VStack(spacing: 4) {
                        Text("Campus Exchange")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(Color(red: 0.831, green: 0.686, blue: 0.216))
                        
                        Text("Connect. Buy. Sell.")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Text("The marketplace for students")
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.8))
                            .padding(.top, 4)
                    }
                }
                .padding(.bottom, 32)
                
                // Login Card
                VStack(spacing: 0) {
                    // Welcome header
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Welcome")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165))
                        
                        Text("Back!")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165))
                        
                        Text("Enter your data email to get started.")
                            .font(.system(size: 13))
                            .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                            .padding(.top, 2)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                    .padding(.bottom, 20)
                    
                    // User type toggle
                    StudentFacultyToggle()
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)
                    
                    // Email field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("School")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                        
                        HStack {
                            Text("student@useast.edu")
                                .font(.system(size: 15))
                                .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                            
                            Spacer()
                            
                            Image(systemName: "chevron.down")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(red: 0.88, green: 0.88, blue: 0.88), lineWidth: 1)
                        )
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)
                    
                    // Password field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                        
                        HStack {
                            Text("••••••••")
                                .font(.system(size: 15))
                                .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(red: 0.88, green: 0.88, blue: 0.88), lineWidth: 1)
                        )
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
                    
                    // Login button
                    Button(action: {}) {
                        HStack(spacing: 8) {
                            Text("Log In")
                                .font(.system(size: 16, weight: .semibold))
                            
                            Image(systemName: "arrow.right")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(red: 0.545, green: 0.176, blue: 0.306))
                        )
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 20)
                    
                    // Divider
                    Rectangle()
                        .fill(Color(red: 0.88, green: 0.88, blue: 0.88))
                        .frame(height: 1)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 20)
                    
                    // Create account
                    Button(action: {}) {
                        HStack(spacing: 4) {
                            Text("Create an Account!")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Color(red: 0.545, green: 0.176, blue: 0.306))
                            
                            Text("New here?")
                                .font(.system(size: 14))
                                .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                        }
                    }
                    .padding(.bottom, 24)
                }
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white)
                )
                .padding(.horizontal, 24)
                
                Spacer()
            }
        }
    }
}

struct StudentFacultyToggle: View {
    @State private var isStudent = true
    
    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isStudent = true
                }
            }) {
                Text("Student")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(isStudent ? Color(red: 0.545, green: 0.176, blue: 0.306) : Color(red: 0.4, green: 0.4, blue: 0.4))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(
                        Rectangle()
                            .fill(.clear)
                    )
            }
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isStudent = false
                }
            }) {
                Text("Faculty")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(!isStudent ? Color(red: 0.545, green: 0.176, blue: 0.306) : Color(red: 0.4, green: 0.4, blue: 0.4))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(
                        Rectangle()
                            .fill(.clear)
                    )
            }
        }
        .overlay(
            GeometryReader { geometry in
                Rectangle()
                    .fill(Color(red: 0.545, green: 0.176, blue: 0.306))
                    .frame(width: geometry.size.width / 2, height: 2)
                    .offset(x: isStudent ? 0 : geometry.size.width / 2, y: geometry.size.height - 2)
                    .animation(.easeInOut(duration: 0.2), value: isStudent)
            }
        )
        .overlay(
            Rectangle()
                .fill(Color(red: 0.88, green: 0.88, blue: 0.88))
                .frame(height: 1)
            , alignment: .bottom
        )
    }
}

#Preview {
    AuthenticationView()
        .environmentObject(AppState())
}
