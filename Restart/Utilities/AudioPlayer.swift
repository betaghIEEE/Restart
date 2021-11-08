//
//  AudioPlayer.swift
//  Restart
//
//  Created by Daniel Beatty on 11/8/21.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String ){
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            let urlPath: URL  = URL(fileURLWithPath: path)
            audioPlayer = try AVAudioPlayer(contentsOf: urlPath)
            audioPlayer?.play()
        } catch {
            print("Could not play the sound file.")
        }
    }
}
