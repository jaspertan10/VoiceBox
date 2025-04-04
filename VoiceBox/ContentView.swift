//
//  ContentView.swift
//  VoiceBox
//
//  Created by Jasper Tan on 4/3/25.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @State private var audioBox = AudioBox()
    @State private var hasMicAccess = false
    @State private var displayNotification = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Button {
                        //Action
                        if (audioBox.status == .stopped) {
                            if hasMicAccess == true {
                                print("Record: \(audioBox.status)")
                                audioBox.record()
                            } else {
                                requestMicrophoneAccess()
                            }
                        } else {
                            audioBox.stopRecording()
                        }
                        
                    } label: {
                        Image(systemName: audioBox.status == .stopped ? "microphone.slash" : "microphone")
                    }
                    .font(.title)

                }
            }
            .onAppear {
                audioBox.setupRecorder()
            }
            .navigationTitle("VoiceBox")
            .alert("", isPresented: $displayNotification) {
                Button("OK") {}
            } message: {
                Text("Go to Settings > VoiceBox > Allow VoiceBox to Access Microphone.\nSet switch to enable.")
            }

        }
    }
    
    private func requestMicrophoneAccess() {
        let session = AVAudioSession.sharedInstance()
        session.requestRecordPermission { granted in
            hasMicAccess = granted
            
            if granted == true {
                audioBox.record()
            } else {
                displayNotification = true
            }
        }
        
    }
}

#Preview {
    ContentView()
}
