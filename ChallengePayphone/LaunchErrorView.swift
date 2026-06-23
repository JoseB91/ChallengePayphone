//
//  LaunchErrorView.swift
//  ChallengePayphone
//
//  Created by José Briones on 22/6/26.
//

import SwiftUI

struct LaunchErrorView: View {
    let error: Error?

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundStyle(.orange)
            Text(String(localized: "LAUNCH_ERROR"))
                .font(.headline)
            Text(error?.localizedDescription ?? String(localized: "UNKNOWN_ERROR"))
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
    }
}

#Preview() {
    LaunchErrorView(error: MapperError.unsuccessfullyResponse)
}
