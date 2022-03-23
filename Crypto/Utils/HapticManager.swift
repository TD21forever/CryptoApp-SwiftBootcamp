//
//  HapticManager.swift
//  Crypto
//
//  Created by T D on 2022/3/23.
//

import Foundation
import UIKit

class HapticManager{
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type:UINotificationFeedbackGenerator.FeedbackType){
        generator.notificationOccurred(type)
    }
}
