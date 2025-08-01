//
//  LogoView.swift
//  GimOn
//
//  Created by Enjel Hutasoit on 31/07/25.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Image("gimon-logo")
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 25)
    }
}
