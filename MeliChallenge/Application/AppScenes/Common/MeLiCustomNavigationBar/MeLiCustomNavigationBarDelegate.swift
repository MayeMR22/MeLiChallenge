//
//  MeLiCustomNavigationBarDelegate.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 27/05/22.
//

import Foundation

enum CustomNavigationBarButton {
    case search
    case back
}

// MARK: - Protocols
protocol MeLiCustomNavigationBarDelegate: AnyObject {
    func customNavigationBar(requestActionForButton button: CustomNavigationBarButton)
}


