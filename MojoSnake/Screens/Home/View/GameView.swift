import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
    var interstitial = InterstitialAdView(adUnitId: .interstitialAd)
    @StateObject private var versionVM = VersionCheckViewModel()

    var body: some View {
        VStack {
            HStack {
                BannerAdView(adUnitId: .homeBanner).clipped()
                
            }.frame(maxHeight: 300).padding(.bottom,20)            
            
            VStack {
                Text("Score: \(viewModel.score)")
                    .font(.title2)
                Text("High Score: \(viewModel.highScore)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }.frame(maxWidth: .infinity, maxHeight: 100)
                
                
               
            
            ZStack {
                Rectangle()
                    .stroke(Color.gray, lineWidth: 1)
                    .frame(width: CGFloat(viewModel.columns) * viewModel.cellSize,
                           height: CGFloat(viewModel.rows) * viewModel.cellSize)
                
                ForEach(viewModel.snake, id: \.self) { segment in
                    Circle()
                        .fill(Color.green)
                        .frame(width: viewModel.cellSize, height: viewModel.cellSize)
                        .position(x: CGFloat(segment.x) * viewModel.cellSize + viewModel.cellSize / 2,
                                  y: CGFloat(segment.y) * viewModel.cellSize + viewModel.cellSize / 2)
                }
                
                Circle()
                    .fill(Color.red)
                    .frame(width: viewModel.cellSize , height: viewModel.cellSize)
                    .position(x: CGFloat(viewModel.food.x) * viewModel.cellSize + viewModel.cellSize / 2,
                              y: CGFloat(viewModel.food.y) * viewModel.cellSize + viewModel.cellSize / 2)
            }
            .frame(width: CGFloat(viewModel.columns) * viewModel.cellSize,
                   height: CGFloat(viewModel.rows) * viewModel.cellSize)
            .background(Color.black.opacity(0.05))
            .alert("Update Available", isPresented: $versionVM.showUpdateAlert) {
                            Button("Update") {
                                if let url = URL(string: versionVM.updateUrl) {
                                    UIApplication.shared.open(url)
                                }
                            }
                            if !versionVM.forceUpdate {
                                Button("Later", role: .cancel) {}
                            }
                        } message: {
                            Text("A new version of the app is available.")
                        }
            .gesture(
                DragGesture()
                    .onEnded { value in
                        viewModel.updateDirectionFromSwipe(horizontal: value.translation.width,
                                                           vertical: value.translation.height)
                    }
            )
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onEnded { value in
                        let tapX = Int(value.location.x / viewModel.cellSize)
                        let tapY = Int(value.location.y / viewModel.cellSize)
                        viewModel.updateDirectionFromTap(tapX: tapX, tapY: tapY)
                    }
            )
            .padding()
            
            if viewModel.isGameOver {

                Button(action: {
                    viewModel.resetGame()
                }) {
                    Text("Restart")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .frame(width: 200) // Optional: set fixed width
                
                .padding(.top)
                .onAppear {
                    interstitial.showAd()

                }
            }
        }.onLoad {
            versionVM.checkForUpdate()

        }
        .onAppear {
            viewModel.startGame()
        }
        Spacer()

    }
}

#Preview {
    GameView()
}

