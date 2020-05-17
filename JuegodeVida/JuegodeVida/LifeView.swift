//
//  Cell.swift
//  JuegodeVida
//
//  Created by Tejas Thiyagarajan on 5/16/20.
//  Copyright © 2020 Tejas Thiyagarajan. All rights reserved.
//

import ScreenSaver

//write cell code here ... i think

class View: ScreenSaverView {

    class Cell {
        
        var col: Int
        var row: Int
        
        var amAlive: Bool
        var neighbors: Int
        var DEAD_COLOR: String
        var ALIVE_COLOR: String
        
        //initializing statement
        init(row: Int, col: Int) {
            self.row = row
            self.col = col
            amAlive = false
            neighbors = 0
            DEAD_COLOR = "#E8E8E8" //figure out colors later
            ALIVE_COLOR = "#FF6600"
        }
        
        //methods
        func toggleAlive() {
            amAlive = !amAlive
        }
        func setAlive(alive: Bool) {
            amAlive = true
        }
        func isAlive() -> Bool {
            return amAlive
        }
        
        func display (r: Int, c: Int, x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
            let rectangle = NSRect(x: Int(x), y: Int(y), width: Int(w), height: Int(h))
            if cell[r][c].isAlive() {
                NSColor.orange.setFill()
                rectangle.fill()
            } else {
                NSColor.white.setFill()
                rectangle.fill()
            }
            // finish display stuff later
        }
        
        
        func updateAlvin() {
            setAlive(alive: ((neighbors > 1 && neighbors < 4) && amAlive) || ((neighbors == 3) && !amAlive))
        }
        
        func calculateNeighbors() -> Int {
            neighbors = 0
            
            var r = row - 1
            var c =  col - 1
            
            while r < row + 2 {
                while c < col + 2 {
                    if (row != r || col != c) {
                        let rowjust = (r + 1024) % 1024 //add in ROWS and COLS variable later
                        let coljust = (c + 768) % 768 //add in ROWS and COLS variable later
                        //check for wrapping
                        if (cell[rowjust][coljust].isAlive()) { //error...
                            neighbors += 1
                        }
                    }
                    c += 1
                }
                r += 1
            }
        }
    }

    //main class in javanese terms
    var ROWS = 40
    var COLS = 60
    var CELL_WIDTH = 15
    var CELL_HEIGHT = 15
//    var LEFT_OFFSET = 12 // not necessary since there is no offset and grid fills full screen
//    var TOP_OFFSET = 12
//
//    var BOTTOM_GRID_OFFSET = TOP_OFFSET + (CELL_HEIGHT + 1) * ROWS

    var cell = [[Cell]]() //i think i figured it out... not sure

    func setup() { //figure out
//        size(1024, 768)
        
        initGrid()
        
        setUpCells()
    }

    func draw() { //figure out
        drawBackground(.black)
//        stroke(#000000) //processing stuff; not sure what is does
        
        calcNeighbors()
        updateAlive()
        
        displayCells()
    }

    func calcNeighbors() {
        var r = 0
        var c = 0
        
        while r < ROWS {
            while c < COLS {
                cell[r][c].calculateNeighbors()
                c += 1
            }
            r += 1
        }
    }

    func updateAlive() {
        var r = 0
        var c = 0
        
        while r < ROWS {
            while c < COLS {
                cell[r][c].updateAlvin()
                c += 1
            }
            r += 1
        }
    }

    func displayCells() {
        var r = 0
        var c = 0
        var positionx = 0
        var positiony = 0
        
        while r < ROWS {
            while c < COLS {
                cell[r][c].display(r: r, c: c, x: r * (bounds.width / 1024), y: c * (bounds.width / 786), w: bounds.width/1024, h: bounds.height/768)
                c += 1
            }
            r += 1
        }
    }

    func initGrid() {
        var r = 0
        var c = 0

        while r < ROWS {
            while c < COLS {
                cell[r][c].setAlive(alive: false)
                c += 1
            }
            r += 1
        }
    }

    func setUpCells() {
        //glider spaceship
        cell[ROWS-1][COLS-1].setAlive(alive: true)
        cell[ROWS-1][0].setAlive(alive: true)
        cell[ROWS-1][1].setAlive(alive: true)
        cell[0][1].setAlive(alive: true)
        cell[1][0].setAlive(alive: true)
    }

    func drawBackground(_ color: NSColor) {
        let background = NSBezierPath(rect: bounds)
        color.setFill()
        background.fill()
    }

}
