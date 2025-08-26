//
//  URLOpener.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 31/07/25.
//

import UIKit

func openURLInBrowser(_ url: URL?) {
    if let url, UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    } else {
        print("Invalid URL or can't open URL")
    }
}

func openURLInBrowser(_ urlString: String) {
    let trimmed = urlString.trimmingCharacters(in: .whitespacesAndNewlines)
    
    if var components = URLComponents(string: trimmed) {
        components.scheme = "https"
        
        if let url = components.url {
            openURLInBrowser(url)
            return
        }
    }
    print("Invalid URL or can't open URL")
}
