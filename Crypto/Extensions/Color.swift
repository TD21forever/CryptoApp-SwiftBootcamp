//
//  Color.swift
//  Crypto
//
//  Created by T D on 2022/2/16.
//

import Foundation
import SwiftUI

extension Color{
    static let theme = ColorTheme()
    static let launch = LaunchTheme()
}

struct ColorTheme{
    let secondaryText = Color("SecondaryTextColor")
    let red = Color("RedColor")
    let accent = Color("AccentColor")
    let green = Color("GreenColor")
    let background = Color("BackgroundColor")
}

struct LaunchTheme {
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
}
