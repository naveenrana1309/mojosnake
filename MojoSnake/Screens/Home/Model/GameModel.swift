//
//  GameModel.swift
//  MojoSnake
//
//  Created by Naveen Rana on 20/07/25.
//

import Foundation

enum Direction {
    case up, down, left, right
}

struct Position: Hashable {
    var x: Int
    var y: Int
}
