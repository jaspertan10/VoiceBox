//
//  AudioStatus.swift
//  VoiceBox
//
//  Created by Jasper Tan on 4/3/25.
//

import Foundation

enum AudioStatus: Int, CustomStringConvertible {
    
    case stopped, playing, recording

    var audioName: String {
        let audioNames = ["Audio:Stopped", "Audio:Playing", "Audio:Recording"]
        return audioNames[rawValue]
    }
    
    var description: String {
        return audioName
    }
}
