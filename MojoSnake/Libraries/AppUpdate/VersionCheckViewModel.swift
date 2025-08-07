//
//  VersionCheckViewModel.swift
//  MojoSnake
//
//  Created by Naveen Rana on 07/08/25.
//

//
//  VersionCheckViewModel.swift
//  ReelsSaver
//
//  Created by Naveen Rana on 11/07/25.
//

import Foundation
import Combine

class VersionCheckViewModel: ObservableObject {
    @Published var showUpdateAlert = false
    var updateUrl: String = ""
    var forceUpdate: Bool = false // Optional: You can handle force update via remote config, or hardcode based on version differences

    private let appStoreID = "6749696927" // Replace with your actual App Store ID

    func checkForUpdate() {
        guard let url = URL(string: "https://itunes.apple.com/lookup?id=\(appStoreID)") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  error == nil,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                  let results = json["results"] as? [[String: Any]],
                  let appStoreVersion = results.first?["version"] as? String,
                  let trackViewUrl = results.first?["trackViewUrl"] as? String else {
                return
            }

            guard let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
                return
            }

            print("App Store version: \(appStoreVersion), Current version: \(currentVersion)")

            if appStoreVersion.compare(currentVersion, options: .numeric) == .orderedDescending {
                DispatchQueue.main.async {
                    self.updateUrl = trackViewUrl
                    self.showUpdateAlert = true
                    self.forceUpdate = true // You can set logic here if you want to force update for specific versions
                }
            }
        }.resume()
    }
}
