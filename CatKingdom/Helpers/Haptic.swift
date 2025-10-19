//
//  Haptic.swift
//  CatKingdom
//
//  Created by William on 19/10/25.
//

import UIKit

final class Haptic {
    static func lightTap() {
        tap(.light)
    }
    
    static func mediumTap() {
        tap(.medium)
    }
    
    static func heavyTap() {
        tap(.heavy)
    }
    
    static func notifySuccess() {
        notify(.success)
    }
    
    static func notifyWarning() {
        notify(.warning)
    }
    
    static func notifyError() {
        notify(.error)
    }
    
    static func selection() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
    
    private static func tap(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
    private static func notify(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
}

