//
//  ConwayMatrix.swift
//  GameofLife2
//
//  Created by Tejas Thiyagarajan on 5/17/20.
//  Copyright © 2020 Tejas Thiyagarajan. All rights reserved.
//

class ConwayMatrix: Game {

    var cell: [[Int]]
    var changelog: [(Int, Int, Int)] //array to store changes
    var ROWS: Int
    var COLS: Int
    
    init(rows: Int, cols: Int, onCells :[(Int, Int)]) {
        self.ROWS = rows
        self.COLS = cols
        cell = Array(repeating: Array(repeating: 0, count: COLS), count: ROWS)
        changelog = Array()
        
        // set the input set of cells that should be on and turn them on
        for i in onCells {
            cell[i.0][i.1] = 1
        }
    }
    
    func calculateNeighbors(row: Int, col: Int) {
        var neighbors = 0
        
        var r = row - 1
        // 3x3 walk
        while r < row + 2 {
            var c =  col - 1
            while c < col + 2 {
                if (row != r || col != c) {
                    let rowjust = (r + ROWS) % ROWS //add in ROWS and COLS variable later
                    let coljust = (c + COLS) % COLS //add in ROWS and COLS variable later
                    //check for wrapping
//                    if !( r < 0 || c < 0 || r > ROWS - 1 || c > COLS - 1) {
                        neighbors += cell[rowjust][coljust]
//                    }
                }
                c += 1
            }
            r += 1
        }
        
        // alive cell
        if(cell[row][col] == 1) {
            switch neighbors {
            case 0...1:
                //dead
                changelog.append((row, col, 0))
            case 4...9:
                //dead
                changelog.append((row, col, 0))
            default:
                break
            }
        }
        else { //dead cell
            switch neighbors {
                case 3:
                    //alive
                    changelog.append((row, col, 1))
            default:
                break
            }
        }

    }

    public func computeNextStep() {
        var r = 0
        
        while r < ROWS {
            var c = 0
            while c < COLS {
                calculateNeighbors(row: r, col: c)
                c += 1
            }
            r += 1
        }

        for i in changelog {
            cell[i.0][i.1] = i.2
        }
    }
    
    func displayBoard(drawBoard: BoardDrawDelegate) {
        for i in 0..<ROWS {
            for j in 0..<COLS {
                drawBoard.displayCells(r: i, c: j, state: cell[i][j] == 1 ? true : false)
            }
        }
    }
}
