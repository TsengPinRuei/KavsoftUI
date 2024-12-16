//
//  HomeView.swift
//  YouTubeVideoPlayer
//
//  Created by 曾品瑞 on 2024/4/14.
//

import SwiftUI
import AVKit

struct HomeView: View {
    @GestureState private var drag: Bool=false
    
    @State private var add: Bool=false
    @State private var control: Bool=false
    @State private var finish: Bool=false
    @State private var landscape: Bool=false
    @State private var play: Bool=false
    @State private var seek: Bool=false
    @State private var endProgress: CGFloat=0
    @State private var startProgress: CGFloat=0
    @State private var timeout: DispatchWorkItem?
    @State private var status: NSKeyValueObservation?
    @State private var dragImage: UIImage?
    @State private var image: [UIImage]=[]
    @State private var player: AVPlayer? = {
        if let bundle=Bundle.main.path(forResource: "city", ofType: "mp4") {
            return AVPlayer(url: URL(filePath: bundle))
        } else {
            return nil
        }
    }()
    
    var size: CGSize
    var safeArea: EdgeInsets
    
    @ViewBuilder
    private func ControlView() -> some View {
        ZStack {
            Text("Release to cancel")
                .foregroundStyle(.white)
                .padding(.vertical, 5)
                .padding(.horizontal)
                .padding(.horizontal)
                .background(.black.opacity(0.4), in: .capsule(style: .continuous))
                .frame(maxHeight: .infinity, alignment: .top)
                .opacity((self.control && self.drag) ? 1:0)
                .animation(.easeInOut(duration: 0.2), value: (self.control && self.drag))
            
            HStack(spacing: 20) {
                Button { } label: {
                    Image(systemName: "backward.end.fill")
                        .font(.title2)
                        .fontWeight(.ultraLight)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.black.opacity(0.4), in: .circle)
                }
                .disabled(true)
                .opacity(0.5)
                
                Button {
                    if(self.finish) {
                        self.finish=false
                        self.player?.seek(to: .zero)
                        self.startProgress=CGFloat.zero
                        self.endProgress=CGFloat.zero
                    }
                    
                    if(self.play) {
                        self.player?.pause()
                        if let timeout=self.timeout {
                            timeout.cancel()
                        }
                    } else {
                        self.player?.play()
                        self.timeoutControl()
                    }
                    
                    withAnimation(.easeInOut(duration: 0.2)) {
                        self.play.toggle()
                    }
                } label: {
                    Image(systemName: self.finish ? "arrow.clockwise":(self.play ? "pause.fill":"play.fill"))
                        .font(.title)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.black.opacity(0.4), in: .circle)
                        .symbolEffect(.bounce, value: self.play)
                }
                .scaleEffect(1.1)
                
                Button { } label: {
                    Image(systemName: "forward.end.fill")
                        .font(.title2)
                        .fontWeight(.ultraLight)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.black.opacity(0.4), in: .circle)
                }
                .disabled(true)
                .opacity(0.5)
            }
            .opacity((self.control && !self.drag) ? 1:0)
            .animation(.easeInOut(duration: 0.2), value: (self.control && !self.drag))
            
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    self.landscape = !self.landscape
                }
            } label: {
                Image(systemName: "arrow.up.left.and.arrow.down.right.square")
                    .font(.title2)
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding(.trailing)
            .padding(.bottom)
            .padding(.bottom)
            .opacity((self.control && !self.drag) ? 1:0)
            .animation(.easeInOut(duration: 0.2), value: (self.control && !self.drag))
        }
    }
    @ViewBuilder
    private func SeekImageView(_ size: CGSize) -> some View {
        let currentSize: CGSize=CGSize(width: 200, height: 100)
        ZStack {
            if let dragImage=self.dragImage {
                Image(uiImage: dragImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: currentSize.width, height: currentSize.height)
                    .clipShape(.rect(cornerRadius: 10, style: .continuous))
                    .overlay(alignment: .bottom) {
                        if let current=self.player?.currentItem {
                            Text(CMTime(seconds: self.startProgress*current.duration.seconds, preferredTimescale: 600).timeString())
                                .font(.callout)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .offset(y: 25)
                        }
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(.white, lineWidth: 2)
                    }
            } else {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(.black)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(.white, lineWidth: 2)
                    }
            }
        }
        .frame(width: currentSize.width, height: currentSize.height)
        .opacity(self.drag ? 1:0)
        .offset(x: self.startProgress*(size.width-currentSize.width-20))
        .offset(x: 10)
    }
    @ViewBuilder
    private func SeekView(_ size: CGSize) -> some View {
        ZStack(alignment: .leading) {
            Rectangle().fill(.gray)
            
            Rectangle()
                .fill(.red)
                .frame(width: max(size.width*self.startProgress, 0))
        }
        .frame(height: 3)
        .overlay(alignment: .leading) {
            Circle()
                .fill(.red)
                .frame(width: 15, height: 15)
                .scaleEffect(
                    self.control || self.drag ? 1:0.001,
                    anchor: self.startProgress*size.width>15 ? .trailing:.leading
                )
                .frame(width: 50, height: 50)
                .contentShape(.rect)
                .offset(x: size.width*self.startProgress)
                .gesture(
                    DragGesture()
                        .updating(self.$drag) {(_, out, _) in
                            out=true
                        }
                        .onChanged {value in
                            if(self.play) {
                                self.player?.pause()
                            }
                            if let timeout=self.timeout {
                                timeout.cancel()
                            }
                            
                            let translation: CGFloat=value.translation.width
                            let progress: CGFloat=translation/size.width+self.endProgress
                            self.startProgress=max(min(progress, 1), 0)
                            self.seek=true
                            
                            let index: Int=Int(self.startProgress/0.01)
                            if(self.image.indices.contains(index)) {
                                self.dragImage=self.image[index]
                            }
                        }
                        .onEnded {value in
                            self.endProgress=self.startProgress
                            if let current=self.player?.currentItem {
                                let total: Double=current.duration.seconds
                                
                                self.player?.seek(to: .init(seconds: total*self.startProgress, preferredTimescale: 600))
                                
                                if(self.play) {
                                    self.player?.play()
                                    self.timeoutControl()
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                                    self.seek=false
                                }
                            }
                        }
                )
                .offset(x: self.startProgress*size.width>15 ? -15:0)
                .frame(width: 15, height: 15)
        }
    }
    
    private func generateImage() {
        Task.detached {
            guard let asset=self.player?.currentItem?.asset else { return }
            
            let generate: AVAssetImageGenerator=AVAssetImageGenerator(asset: asset)
            generate.appliesPreferredTrackTransform=true
            generate.maximumSize=CGSize(width: 250, height: 250)
            
            do {
                let total=try await asset.load(.duration).seconds
                var time: [CMTime]=[]
                
                for i in stride(from: 0, to: 1, by: 0.01) {
                    let current: CMTime=CMTime(seconds: i*total, preferredTimescale: 600)
                    time.append(current)
                }
                for await i in generate.images(for: time) {
                    let image: CGImage=try i.image
                    
                    await MainActor.run {
                        self.image.append(UIImage(cgImage: image))
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    private func timeoutControl() {
        if let timeout=self.timeout {
            timeout.cancel()
        } else {
            self.timeout=DispatchWorkItem {
                withAnimation(.easeInOut(duration: 0.4)) {
                    self.control=false
                }
            }
            
            if let timeout=self.timeout {
                DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: timeout)
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            let playerSize: CGSize=CGSize(width: self.landscape ? self.size.height:self.size.width, height: self.landscape ? self.size.width:self.size.height/3.5)
            
            ZStack {
                if let player=self.player {
                    PlayerView(player: player)
                        .overlay {
                            Rectangle()
                                .fill(.black.opacity(0.4))
                                .opacity((self.control || self.drag) ? 1:0)
                                .animation(.easeInOut(duration: 0.4), value: self.drag)
                        }
                        .overlay {
                            HStack(spacing: 60) {
                                DoubleTapView {
                                    let second: Double=player.currentTime().seconds-10
                                    player.seek(to: .init(seconds: second, preferredTimescale: 600))
                                }
                                
                                DoubleTapView(forward: true) {
                                    let second: Double=player.currentTime().seconds+10
                                    player.seek(to: .init(seconds: second, preferredTimescale: 600))
                                }
                            }
                        }
                        .overlay {
                            self.ControlView()
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.4)) {
                                self.control.toggle()
                            }
                            
                            if(self.play) {
                                self.timeoutControl()
                            }
                        }
                        .overlay(alignment: .bottomLeading) {
                            self.SeekImageView(playerSize).offset(y: self.landscape ? -85:-60)
                        }
                        .overlay(alignment: .bottom) {
                            self.SeekView(playerSize).offset(y: self.landscape ? -15:0)
                        }
                }
            }
            .background {
                Rectangle()
                    .fill(.black)
                    .padding(.leading, self.landscape ? -self.safeArea.bottom:0)
                    .padding(.trailing, self.landscape ? -self.safeArea.bottom:0)
            }
            .gesture(
                DragGesture()
                    .onEnded {value in
                        withAnimation(.easeInOut(duration: 0.2)) {
                            self.landscape = -value.translation.height>100 ? true:false
                        }
                    }
            )
            .frame(width: playerSize.width, height: playerSize.height)
            .frame(width: self.size.width, height: self.size.height/3.5, alignment: .bottomLeading)
            .offset(y: self.landscape ? -(self.size.width/1.5)+self.safeArea.bottom:0)
            .rotationEffect(Angle(degrees: self.landscape ? 90:0), anchor: .topLeading)
            .zIndex(1)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
                    ForEach(1...5, id: \.self) {index in
                        GeometryReader {
                            let size: CGSize=$0.size
                            
                            Image("city\(index)")
                                .resizable()
                                .scaledToFill()
                                .frame(width: size.width, height: size.height)
                                .clipShape(.rect(cornerRadius: 10, style: .continuous))
                        }
                        .frame(height: 200)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top)
                .padding(.top)
                .padding(.bottom)
                .padding(.bottom, self.safeArea.bottom)
            }
        }
        .padding(.top, self.safeArea.top)
        .onAppear {
            guard !self.add else { return }
            
            self.player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 600), queue: .main) {time in
                if let current=self.player?.currentItem {
                    let total: Double=current.duration.seconds
                    guard let duration=self.player?.currentTime().seconds else { return }
                    let progress: Double=duration/total
                    
                    self.startProgress=progress
                    if(!self.seek) {
                        self.startProgress=progress
                        self.endProgress=self.startProgress
                    }
                    
                    if(progress==1) {
                        self.finish=true
                        self.play=false
                    }
                }
            }
            
            self.add=true
            self.status=self.player?.observe(\.status, options: .new) {(player, _) in
                if(player.status == .readyToPlay) {
                    self.generateImage()
                }
            }
        }
        .onDisappear {
            self.status?.invalidate()
        }
    }
}

#Preview {
    ContentView()
}
