//
//  GameofLife2View.swift
//  GameofLife2
//
//  Created by Tejas Thiyagarajan on 5/17/20.
//  Copyright © 2020 Tejas Thiyagarajan. All rights reserved.
//

import Foundation
import ScreenSaver
//import OSLog

class View: ScreenSaverView, BoardDrawDelegate {
    let ROWS = 100
    let COLS = 100
    var rs = Int.random(in: 0..<100)
    var rs1 = Int.random(in: 0..<100)
    
    let DEAD_COLOR = NSColor.black
    let ALIVE_COLOR = NSColor.orange

    
    var game: Game
    var boxHeight: CGFloat
    var boxWidth : CGFloat
    
    override init?(frame: NSRect, isPreview: Bool) {
        self.game = ConwayMatrix(rows: ROWS, cols: COLS,
//                                 onCells: [(10, 10),(10, 11),(10, 12)])

                                 onCells: [(rs, rs),(rs, rs+1),(rs, rs+2),
                                           (rs+1, rs+2),(rs+2, rs),(rs1, rs1),(rs1, rs1+1),(rs1, rs1+2),
                                           (rs1+1, rs1+2),(rs1+2, rs1)])
//                                    onCells: [(25, 25),(25, 26),(25, 27),
//                                              (26, 27),(27, 25)])
        boxHeight = CGFloat(0)
        boxWidth = CGFloat(0)
        super.init(frame: frame, isPreview: isPreview)

        boxWidth = bounds.width/CGFloat(COLS)
        boxHeight = bounds.height/CGFloat(ROWS)
        drawBackground(DEAD_COLOR)
    }
    
    @available(*, unavailable)
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func animateOneFrame() {
        super.animateOneFrame()
        game.computeNextStep()
        setNeedsDisplay(bounds)
    }
    
    override func draw(_ rect: NSRect) {
        game.displayBoard(drawBoard: self)
    }

    func displayCells(r: Int, c: Int, state: Bool) {
        let rect = NSRect(x: CGFloat(c) * boxWidth, y: CGFloat(r) * boxHeight, width: boxWidth, height: boxHeight)
        
        display(rect: rect, color: state ? ALIVE_COLOR : DEAD_COLOR)
        setNeedsDisplay(rect)
    }
    
    func display (rect: NSRect, color: NSColor) {
        color.setFill()
        rect.fill()
    }

    func drawBackground(_ color: NSColor) {
        let background = NSBezierPath(rect: bounds)
        color.setFill()
        background.fill()
    }

}
