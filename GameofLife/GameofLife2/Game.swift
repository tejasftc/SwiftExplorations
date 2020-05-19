//
//  Game.swift
//  GameofLife2
//
//  Created by Tejas Thiyagarajan on 5/18/20.
//  Copyright © 2020 Tejas Thiyagarajan. All rights reserved.
//

protocol Game {
    func computeNextStep()
    func displayBoard(drawBoard: BoardDrawDelegate)
}
