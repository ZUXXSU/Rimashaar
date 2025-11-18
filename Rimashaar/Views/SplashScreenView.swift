import SwiftUI
import AVKit
import AVFoundation

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VideoPlayerView(videoName: "splashvideo", videoType: "mp4")
                .background(Color.white)
                .accessibilityHidden(true)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    // This is an example of how to integrate a UIKit component (AVPlayerViewController)
    // into a SwiftUI view using UIViewControllerRepresentable.
    struct VideoPlayerView: UIViewControllerRepresentable {
        let videoName: String
        let videoType: String

        func makeUIViewController(context: Context) -> AVPlayerViewController {
            guard let path = Bundle.main.path(forResource: videoName, ofType: videoType) else {
                fatalError("Video file not found: \(videoName).\(videoType)")
            }
            let player = AVPlayer(url: URL(fileURLWithPath: path))
            let playerViewController = AVPlayerViewController()
            
            playerViewController.view.backgroundColor = .white
            playerViewController.player = player
            playerViewController.showsPlaybackControls = false
            playerViewController.videoGravity = .resizeAspect

            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
                player.seek(to: CMTime.zero)
                player.play()
            }

            player.play()
            return playerViewController
        }

        func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
            // No update needed
        }
    }
}
