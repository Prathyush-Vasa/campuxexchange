import SwiftUI

struct AuthenticationView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var showError = false
    
    var body: some View {
        if isLoggedIn {
            MarketplaceView()
        } else {
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
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(red: 0.545, green: 0.176, blue: 0.306).opacity(0.3))
                                .frame(width: 60, height: 60)
                            
                            Image(systemName: "building.columns.fill")
                                .font(.system(size: 28))
                                .foregroundColor(Color(red: 0.831, green: 0.686, blue: 0.216))
                        }
                        
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
                        VStack(spacing: 4) {
                            Text("Welcome")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165))
                            
                            Text("Enter your school email to get started.")
                                .font(.system(size: 13))
                                .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                                .padding(.top, 2)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal, 24)
                        .padding(.top, 24)
                        .padding(.bottom, 20)
                        
                        // User type toggle
                        StudentFacultyToggle()
                            .padding(.horizontal, 24)
                            .padding(.bottom, 24)
                        
                        // Email field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("School Email")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                            
                            TextField("student@useast.edu", text: $email)
                                .font(.system(size: 15))
                                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
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
                            
                            SecureField("••••••••", text: $password)
                                .font(.system(size: 15))
                                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 14)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(red: 0.88, green: 0.88, blue: 0.88), lineWidth: 1)
                                )
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)
                        
                        // Error message
                        if showError {
                            Text("Invalid email or password. Please try again.")
                                .font(.system(size: 13))
                                .foregroundColor(.red)
                                .padding(.horizontal, 24)
                                .padding(.bottom, 12)
                        }
                        
                        // Login button
                        Button(action: {
                            if email == "student@useast.edu" && password == "password123" {
                                withAnimation {
                                    isLoggedIn = true
                                }
                            } else {
                                showError = true
                            }
                        }) {
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
                                Text("New here?")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                                
                                Text("Create an Account!")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Color(red: 0.545, green: 0.176, blue: 0.306))
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
}

// Placeholder Home Screen
struct HomeView: View {
    var body: some View {
        ZStack {
            Color(red: 0.96, green: 0.96, blue: 0.96).ignoresSafeArea()
            
            VStack(spacing: 16) {
                Image(systemName: "building.columns.fill")
                    .font(.system(size: 48))
                    .foregroundColor(Color(red: 0.545, green: 0.176, blue: 0.306))
                
                Text("Welcome to Campus Exchange!")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165))
                
                Text("You're logged in successfully.")
                    .font(.system(size: 15))
                    .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
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
                    .background(Rectangle().fill(.clear))
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
                    .background(Rectangle().fill(.clear))
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
                .frame(height: 1),
            alignment: .bottom
        )
    }
}

#Preview {
    AuthenticationView()
        .environmentObject(AppState())
}
