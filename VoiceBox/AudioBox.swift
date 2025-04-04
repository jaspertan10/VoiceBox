//
//  AudioBox.swift
//  VoiceBox
//
//  Created by Jasper Tan on 4/3/25.
//

import Foundation
import AVFoundation

@Observable //Observes any changes in this class and refreshes any views upon change.
class AudioBox: NSObject, ObservableObject {
    
    //@Published refreshes any views using status upon change
    //@Published var status: AudioStatus = .stopped
    var status: AudioStatus = .stopped
    
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    
    // @Published notifies observers, including views, when the status property changes, triggering a refresh.
    var urlForMemo: URL {
        let fileManager = FileManager.default
        let tempDir = fileManager.temporaryDirectory
        let filePath = "TempMemo.m4a"
        //For caf file format
        //let filePath = "TempMemo.caf"
        return tempDir.appendingPathComponent(filePath)
    }
    
    func setupRecorder() {
        //For caf file format
//        let recordSettings: [String: Any] = [
//            AVFormatIDKey: Int(kAudioFormatLinearPCM),
//            AVSampleRateKey: 44100.0,
//            AVNumberOfChannelsKey: 1,
//            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
//        ]
        let recordSettings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: urlForMemo, settings: recordSettings)
            audioRecorder?.delegate = self
        } catch {
            print("Error creating audioRecorder: \(error.localizedDescription)")
        }
    }
    
    func record() {
        audioRecorder?.record()
        status = .recording
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        status = .stopped
    }
}

extension AudioBox: AVAudioRecorderDelegate {
    
    
    // Whether the recording stops successfully (e.g., the user stops it or an error occurs), the delegate method audioRecorderDidFinishRecording(_:successfully:) is automatically called by the AVAudioRecorder once the recording has finished.
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        //print("Recording finished status: \(flag ? "Success" : "Failure")")
        status = .stopped
    }
}
