//
//  UIApplication.swift
//  Crypto
//
//  Created by T D on 2022/3/8.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
