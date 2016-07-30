//
//  StandardEngine.swift
//  Assignment4
//
//  Created by Micah Reid on 7/17/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import Foundation
import UIKit

class StandardEngine: EngineProtocol {
    
    /*var delegate: EngineDelegate
    var grid: GridProtocol
    var refreshRate: Double
    var refreshTimer: NSTimer
    var rows: Int
    var cols: Int
    
    
    init(rows: Int, cols: Int, refreshRate: Double, grid: GridProtocol) {
        self.rows = rows
        self.cols = cols
        self.refreshRate = refreshRate
        self.delegate = SimulationViewController()
         didSet {
         if refreshInterval != 0 {
         if let refreshTimer = refreshTimer { refreshTimer.invalidate() }
         let sel = #selector(Example.timerDidFire(_:))
         refreshTimer = NSTimer.scheduledTimerWithTimeInterval(refreshInterval,
         target: self,
         selector: sel,
         userInfo: ["name": "fred"],
         repeats: true)
         }
         else if let refreshTimer = refreshTimer {
         refreshTimer.invalidate()
         self.refreshTimer = nil
         }
         }
        self.grid = grid
        self.refreshTimer = NSTimer.scheduledTimerWithTimeInterval(refreshInterval,
                                                                   target: self,
                                                                   selector: #selector(self.timerDidFire(_:)),
                                                                   userInfo: ["name": "fred"],
                                                                   repeats: true)
    }
    
    
    @objc func timerDidFire(timer:NSTimer) {
        self.rows += 1
        let center = NSNotificationCenter.defaultCenter()
        let n = NSNotification(name: "ExampleNotification",
                               object: nil,
                               userInfo: ["name": "fred"])
        center.postNotification(n)
        print ("\(timer.userInfo?["name"] ?? "not fred")")
    }

    
    
    
    
    func step() -> GridProtocol {
        var cellLocal: GridProtocol = self.grid
        var cellFinal = grid
        for x in 0...grid.rows - 1{
            for y in 0...grid.cols - 1{
                var neighborCount = 0
                var neighborCoordinates: [(Int, Int)] = Grid(rows: grid.rows, cols: grid.cols,chart: cellLocal.grid).neighbors(x,y)
                for q in 0...8{
                    switch cellLocal[neighborCoordinates[q]]{
                    case CellState.Living, CellState.Born:
                        neighborCount += 1
                    default:
                        break
                    }
                    
                }
                
                if cellLocal[x, y] == .Living || cellLocal[x, y] == .Born{
                    neighborCount -= 1
                }
                if cellLocal[x,y] == .Living || cellLocal[x, y] == .Born {
                    if neighborCount < 2 || neighborCount > 3 {
                        cellFinal [x, y] = .Died
                    } else {
                        cellFinal[x, y] = .Living
                    }
                    
                } else {
                    if neighborCount == 3 {
                        cellFinal [x, y] = .Born
                    } else {
                        cellFinal[x, y] = .Empty
                    }
                }
            }
        }
        
        
        return cellFinal
        
}

/*@objc func timerDidFire(timer:NSTimer) {
 //self.rows += 1
 Grid(rows: rows, cols: cols, chart: step().grid)
 let center = NSNotificationCenter.defaultCenter()
 let n = NSNotification(name: "ExampleNotification",
 object: nil,
 userInfo: ["name": "fred"])
 center.postNotification(n)
 print ("\(timer.userInfo?["name"] ?? "not fred")")
 }
 */
     */
    //my old code
    typealias Position = (row:Int, col: Int)
    typealias CellInitializer = (Position) -> CellState
    typealias Cell = (position: Position, state: CellState)


    private static var _sharedInstance: StandardEngine = StandardEngine(20,20)
    static var sharedInstance: StandardEngine { get { return _sharedInstance } }
    var grid: Grid
    
    var rows: Int = 20 {
        didSet {
            grid = Grid(self.rows, self.cols) { _,_ in .Empty }
            if let delegate = delegate { delegate.engineDidUpdate(grid) }
        }
    }
    
    var cols: Int = 20 {
        didSet {
            grid = Grid(self.rows, self.cols) { _,_ in .Empty }
            if let delegate = delegate { delegate.engineDidUpdate(grid) }
        }
    }
    
    var delegate: EngineDelegate?
    
    var refreshRate:  Double = 0.0
    var refreshTimer: NSTimer?
    
    subscript (i:Int, j:Int) -> CellState {
        get {
            return grid.cells[i*cols+j].state
        }
        set {
            grid.cells[i*cols+j].state = newValue
        }
    }
    
    
    
    init(_ rows: Int, _ cols: Int, cellInitializer: CellInitializer = {_ in .Empty }) {
        print("Standard Engine was initialized")
        self.rows = rows
        self.cols = cols
        self.grid = Grid(rows,cols, cellInitializer: cellInitializer)
        
        refreshTimer = NSTimer.scheduledTimerWithTimeInterval(refreshRate,
                                                       //delay is the time interval in miliseconds
            target: self,
            //class where the selector comes from (not always self)
            selector: #selector(stepHelper),
            //timerTriggered is a function you have to write
            //function that is going to be called
            userInfo: nil,
            //not relevant yet, but for passing around data, usually a dictionary
            repeats: true)

    }
    
    @objc func stepHelper() -> Void{
        step()
    }
    
    func step() -> Grid {
        var newGrid = Grid(self.rows, self.cols)
        newGrid.cells = grid.cells.map {
            switch grid.livingNeighbors($0.position) {
            case 2 where $0.state.isLiving(),
            3 where $0.state.isLiving():  return Cell($0.position, .Living)
            case 3 where !$0.state.isLiving(): return Cell($0.position, .Born)
            case _ where $0.state.isLiving():  return Cell($0.position, .Died)
            default:                           return Cell($0.position, .Empty)
            }
        }
        grid = newGrid
        if let delegate = delegate { delegate.engineDidUpdate(grid) }
        return grid
    }
    
    func setRefresh(refresh: Double){
        refreshRate = refresh
    }
    //new code from example

}

