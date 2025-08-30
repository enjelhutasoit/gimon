//
//  PlatformIconProvider.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 31/07/25.
//

import SwiftUI

public enum PlatformIconProvider {
    private static let iconMapping: [String: String] = [
        "pc": "desktopcomputer",
        "playstation": "gamecontroller.fill",
        "xbox": "xbox.logo",
        "mac": "laptopcomputer",
        "linux": "terminal",
        "ios": "iphone.homebutton",
        "android": "iphone",
        "web": "network",
        "nintendo": "gamecontroller"
    ]

    public static func icon(for slug: String) -> Image {
        let systemName = iconMapping[slug.lowercased()] ?? "questionmark.folder"
        return Image(systemName: systemName)
    }
}
