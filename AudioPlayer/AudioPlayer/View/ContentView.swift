//
//  ContentView.swift
//  AudioPlayer
//
//  Created by 曾品瑞 on 2024/5/21.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @Binding var show: Bool
    
    @State private var animate: Bool=false
    @State private var play: Bool=false
    @State private var player: AVAudioPlayer?
    @State private var current: TimeInterval=0
    @State private var total: TimeInterval=0
    
    let name: String="DeserveIt"
    var animation: Namespace.ID
    
    @ViewBuilder
    private func BackgroundView() -> some View {
        Rectangle()
            .fill(.ultraThickMaterial)
            .overlay {
                Image(.deserveItBG)
                    .resizable()
                    .scaledToFill()
                    .blur(radius: 100)
            }
    }
    @ViewBuilder
    private func CardView(_ size: CGSize) -> some View {
        GeometryReader {
            let size: CGSize=$0.size
            
            Image(.deserveItBG)
                .resizable()
                .scaledToFit()
                .clipShape(.rect(cornerRadius: 10, style: .continuous))
                .frame(width: size.width, height: size.height)
        }
        .frame(height: size.width)
        .padding(10)
    }
    @ViewBuilder
    private func ControlView() -> some View {
        HStack {
            Spacer()
            
            Button("", systemImage: "backward.fill") { }.font(.title)
            
            Spacer()
            
            Button("", systemImage: self.play ? "pause.fill":"play.fill") {
                self.play ? self.stopAudio():self.playAudio()
            }
            .font(.system(size: 50))
            .frame(height: 50)
            .contentTransition(.symbolEffect(.replace))
            
            Spacer()
            
            Button("", systemImage: "forward.fill") { }.font(.title)
            
            Spacer()
        }
        .foregroundStyle(.white)
    }
    @ViewBuilder
    private func NameView() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Deserve It")
                .font(.title)
                .fontWeight(.semibold)
            
            Text("Justin")
                .font(.headline)
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    @ViewBuilder
    private func PlayerView(_ size: CGSize) -> some View {
        GeometryReader {
            let size: CGSize=$0.size
            let spacing: CGFloat=size.height*0.1
            
            VStack(spacing: spacing) {
                VStack(spacing: spacing) {
                    self.NameView()
                    
                    self.SliderView()
                }
                .frame(height: size.height/2.5, alignment: .top)
                
                self.ControlView()
                
                self.VoiceView()
            }
        }
    }
    @ViewBuilder
    private func SliderView() -> some View {
        VStack(spacing: 10) {
            Slider(
                value:
                    Binding(
                        get: { self.current },
                        set: { value in self.seekAudio(to: value) }
                    ),
                in: 0...self.total
            )
            .tint(.white)
            .foregroundStyle(.white)
            
            HStack {
                Text(self.timeString(time: self.current))
                
                Spacer()
                
                Text(self.timeString(time: self.total))
            }
        }
    }
    @ViewBuilder
    private func VoiceView() -> some View {
        HStack(spacing: 20) {
            Image(systemName: "speaker.fill")
            
            Capsule()
                .fill(.ultraThinMaterial)
                .environment(\.colorScheme, .light)
                .frame(height: 5)
            
            Image(systemName: "speaker.wave.3.fill")
        }
    }
    
    private func playAudio() {
        self.player?.play()
        self.play=true
    }
    private func seekAudio(to time: TimeInterval) {
        self.player?.currentTime=time
    }
    private func setUpAudio() {
        guard let url=Bundle.main.url(forResource: self.name, withExtension: "mp3") else { return }
        
        do {
            self.player=try AVAudioPlayer(contentsOf: url)
            self.player?.prepareToPlay()
            self.total=self.player?.duration ?? 0
        } catch { }
    }
    private func stopAudio() {
        self.player?.pause()
        self.play=false
    }
    private func timeString(time: TimeInterval) -> String {
        let minute: Int=Int(time)/60
        let second: Int=Int(time)%60
        return String(format: "%02d:%02d", minute, second)
    }
    private func updateProgress() {
        guard let player=self.player else { return }
        self.current=player.currentTime
    }
    
    var body: some View {
        GeometryReader {
            let size: CGSize=$0.size
            let safeArea: EdgeInsets=$0.safeAreaInsets
            
            ZStack {
                self.BackgroundView()
                
                VStack {
                    self.CardView(size)
                    
                    self.PlayerView(size)
                }
                .padding(.top)
                .padding(.top, safeArea.top)
                .padding(.bottom, safeArea.bottom)
                .padding(.horizontal)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .top)
                .clipped()
            }
            .ignoresSafeArea()
        }
        .ignoresSafeArea(edges: .bottom)
        .preferredColorScheme(.dark)
        .onAppear(perform: self.setUpAudio)
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) {_ in
            self.updateProgress()
        }
    }
}

#Preview {
    ContentView(show: .constant(true), animation: Namespace().wrappedValue)
}
