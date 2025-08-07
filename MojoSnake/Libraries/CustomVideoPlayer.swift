//
//  CustomVideoPlayer.swift
//  ReelsSaver
//
//  Created by Naveen Rana on 19/08/22.
//

import Foundation
import AVFoundation

class CustomVideoPlayer: ObservableObject {
    
    
    @Published var avplayer: AVPlayer? = AVPlayer()
    convenience init(urlString: String) {
        guard let url = URL(string: urlString) else {
            self.init()
            return
        }
        self.init()
        self.avplayer = AVPlayer(url: url)

    }
    
    func togglePlayPause() {
        avplayer?.timeControlStatus == .playing ? avplayer?.play() : avplayer?.pause()
    }
    func stop() {
        avplayer?.pause()
        avplayer?.replaceCurrentItem(with: nil)
        avplayer = nil
    }
}
