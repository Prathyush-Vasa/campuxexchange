// Colors.xcassets Configuration
// This file documents the color assets needed in your Xcode project

/*
To add these colors in Xcode:

1. In your Xcode project, select Assets.xcassets
2. Click the + button at the bottom and select "Color Set"
3. Name it "ASUMaroon"
4. In the Attributes Inspector, set:
   - Any Appearance: #8C1D40 (RGB: 140, 29, 64)
5. Repeat for "ASUGold":
   - Any Appearance: #FFC627 (RGB: 255, 198, 39)

Alternative: Create a Colors.swift file with these extensions:
*/

import SwiftUI

extension Color {
    static let ASUMaroon = Color(red: 140/255, green: 29/255, blue: 64/255)
    static let ASUGold = Color(red: 255/255, green: 198/255, blue: 39/255)
}

// If you add the extension above, replace Color("ASUMaroon") with Color.asuMaroon
// and Color("ASUGold") with Color.asuGold throughout the project
