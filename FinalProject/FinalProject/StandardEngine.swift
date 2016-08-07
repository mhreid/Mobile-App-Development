//
//  StandardEngine.swift
//  FinalProject
//
//  Created by Micah Reid on 7/29/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import Foundation

class StandardEngine: EngineProtocol{
    typealias Position = (row: Int, col: Int)
    typealias Cell = (position: Position, state: CellState)
    
    var editPoints: [(Int, Int)] = []
    var editRow: Int = 0
    var tableContents: Dictionary<String,[[Int]]> = ["Blinker": [[11, 11], [12, 11], [11, 12], [12, 12], [13, 12], [11, 13], [12, 13]], "Tumbler": [[11, 12], [11, 13], [11, 15], [11, 16], [12, 12], [12, 13], [12, 15], [12, 16], [13, 13], [13, 15], [14, 11], [14, 13], [14, 15], [14, 17], [15, 11], [15, 13], [15, 15], [15, 17], [16, 11], [16, 12], [16, 16], [16, 17]], "Pentadecthlon": [[11, 10], [11, 15], [12, 8], [12, 9], [12, 11], [12, 12], [12, 13], [12, 14], [12, 16], [12, 17], [13, 10], [13, 15]], "Glider Gun": [[50, 11], [50, 12], [52, 12], [16, 13], [38, 13], [40, 13], [50, 13], [51, 13], [16, 14], [18, 14], [38, 14], [39, 14], [16, 15], [17, 15], [24, 15], [26, 15], [39, 15], [24, 16], [25, 16], [25, 17], [52, 37], [53, 37], [54, 37], [52, 38], [18, 39], [19, 39], [20, 39], [39, 39], [40, 39], [53, 39], [18, 40], [39, 40], [41, 40], [45, 40], [19, 41], [25, 41], [26, 41], [39, 41], [44, 41], [45, 41], [25, 42], [27, 42], [31, 42], [44, 42], [46, 42], [25, 43], [30, 43], [31, 43], [36, 43], [37, 43], [30, 44], [32, 44], [36, 44], [38, 44], [36, 45], [55, 46], [56, 46], [55, 47], [57, 47], [55, 48], [44, 51], [45, 51], [46, 51], [44, 52], [45, 53]]]
 
    var names: [String] = ["Blinker", "Pentadecthlon", "Glider Gun", "Tumbler"]
    var editRows: Int = 60
    var editCols: Int = 60

    
    private static var _sharedInstance: StandardEngine = StandardEngine(rows: 20, cols: 20)
    static var sharedInstance: StandardEngine { get { return _sharedInstance } }
    
    var mutate: Bool = false
    var gridView: GridView = GridView()
    var grid: GridProtocol{
        didSet{
            self.gridView.grid = self.grid
        }
    }
    var refreshRate:  Double{
        didSet{
            refreshTimer?.invalidate()
            refreshTimer = NSTimer.scheduledTimerWithTimeInterval(refreshRate, target: self, selector: #selector(stepHelper), userInfo: nil, repeats: on)
        }
    }
    var refreshTimer: NSTimer?
    var rows: Int = 20 {
        didSet {
            grid = Grid(rows: self.rows, cols:  self.cols)
            if let delegate = delegate { delegate.engineDidUpdate(grid) }
        }
    }
    
    var cols: Int = 20 {
        didSet {
            grid = Grid(rows: self.rows, cols: self.cols)
            if let delegate = delegate { delegate.engineDidUpdate(grid) }
        }
    }
    var on: Bool{
        didSet{
            refreshTimer?.invalidate()
            refreshTimer = NSTimer.scheduledTimerWithTimeInterval(refreshRate, target: self, selector: #selector(stepHelper), userInfo: nil, repeats: on)
        }
    }
    
    weak var delegate: EngineDelegate?
    
    required init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        refreshRate = 1
        self.grid = Grid(rows: rows,cols: cols)
        on = false

    }
    
    @objc func stepHelper(){
        step()
    }
    

    
    func step() -> GridProtocol {
        var newGrid = Grid(rows: rows, cols: cols)
        newGrid.cells = grid.cells.map {
            switch grid.livingNeighbors($0.position) {
            case 2 where $0.state.isLiving(),
            3 where $0.state.isLiving():  return Cell($0.position, .Alive)
            case 3 where !$0.state.isLiving(): return Cell($0.position, .Born)
            case _ where $0.state.isLiving():  return Cell($0.position, .Died)
            default:                           return Cell($0.position, .Empty)
            }
        }
        if mutate {
            if arc4random_uniform(5) == 1{
                let y = arc4random_uniform(UInt32(rows))
                let x = arc4random_uniform(UInt32(cols))
                
                newGrid.cells[Int(x) * rows + Int(y)] = ((Int(x), Int(y)) , CellState.Alive)
            }
        }

        grid = newGrid
        if let delegate = delegate{ delegate.engineDidUpdate(grid) }
        return grid
    }
    
}