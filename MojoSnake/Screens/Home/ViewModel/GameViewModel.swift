//
//  GameViewModel.swift
//  MojoSnake
//
//  Created by Naveen Rana on 20/07/25.
//

import Foundation
import SwiftUI
import AudioToolbox

class GameViewModel: ObservableObject {
    let rows = 20
    let columns = 20
    let cellSize: CGFloat = 20

    @Published var snake: [Position] = [Position(x: 10, y: 10)]
    @Published var food: Position = Position(x: 5, y: 5)
    @Published var direction: Direction = .right
    @Published var nextDirection: Direction = .right
    @Published var isGameOver = false
    @Published var score = 0
    
    //@Published var foodImageName: String = "insect"
    private let foodOptions = ["insect", "apple", "coin"]
    @Published var highScore = UserDefaults.standard.integer(forKey: "HighScore")

    private var timer: Timer?

    func startGame() {
        AnalyticsManager.shared.logEvent(event: .gamestart)
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
            self.updateGame()
        }
    }

    func resetGame() {
        snake = [Position(x: 10, y: 10)]
        direction = .right
        nextDirection = .right
        food = generateFood()
        score = 0
        isGameOver = false
        startGame()
    }

    func updateDirectionFromSwipe(horizontal: CGFloat, vertical: CGFloat) {
        if abs(horizontal) > abs(vertical) {
            if horizontal > 0 && direction != .left {
                nextDirection = .right
            } else if horizontal < 0 && direction != .right {
                nextDirection = .left
            }
        } else {
            if vertical > 0 && direction != .up {
                nextDirection = .down
            } else if vertical < 0 && direction != .down {
                nextDirection = .up
            }
        }
        updateGame()
    }

    func updateDirectionFromTap(tapX: Int, tapY: Int) {
        guard let head = snake.first else { return }
        let dx = tapX - head.x
        let dy = tapY - head.y

        if abs(dx) > abs(dy) {
            if dx > 0 && direction != .left {
                nextDirection = .right
            } else if dx < 0 && direction != .right {
                nextDirection = .left
            }
        } else {
            if dy > 0 && direction != .up {
                nextDirection = .down
            } else if dy < 0 && direction != .down {
                nextDirection = .up
            }
        }
        updateGame()
    }

    private func updateGame() {
        guard !isGameOver else { return }

        direction = nextDirection
        var newHead = snake[0]

        switch direction {
        case .up:    newHead.y -= 1
        case .down:  newHead.y += 1
        case .left:  newHead.x -= 1
        case .right: newHead.x += 1
        }

        // Wrap around logic
        newHead.x = (newHead.x + columns) % columns
        newHead.y = (newHead.y + rows) % rows

        if snake.contains(newHead) {
            isGameOver = true
            timer?.invalidate()
            if score > highScore {
                highScore = score
                UserDefaults.standard.set(highScore, forKey: "HighScore")
                AnalyticsManager.shared.logEvent(event: .highscore(score: String(highScore)))
                AnalyticsManager.shared.logEvent(event: .gameover)

            }
            return
        }
        // 👇 Play move sound before inserting the new head
       // playMoveSound()
        
        snake.insert(newHead, at: 0)

        if newHead == food {
            score += 1
            vibrateSound()
            food = generateFood()
        } else {
            snake.removeLast()
        }
    }

    func generateFood() -> Position {
           var newFood: Position
           repeat {
               newFood = Position(x: Int.random(in: 0..<columns), y: Int.random(in: 0..<rows))
           } while snake.contains(newFood)
           //foodImageName = foodOptions.randomElement()!
           return newFood
       }
    
    func rotationAngle(for direction: Direction) -> Angle {
        switch direction {
        case .up: return .degrees(0)
        case .right: return .degrees(90)
        case .down: return .degrees(180)
        case .left: return .degrees(270)
        }
    }
    
    func playMoveSound() {
        let soundID: SystemSoundID = 1104
        AudioServicesPlaySystemSound(soundID)

    }
    
    func vibrateSound() {
        let soundID: SystemSoundID = 1104
        AudioServicesPlayAlertSound(soundID)

    }

}
