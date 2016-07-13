//
//  GridView.swift
//  Assignment3
//
//  Created by Micah Reid on 7/9/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import UIKit

@IBDesignable class GridView: UIView {
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
    @IBInspectable let aliveColor = UIColor(red: 0, green: 0.8, blue: 0.1, alpha: 1.0)
    @IBInspectable let bornColor = UIColor(red: 0, green: 0.8, blue: 0.1, alpha: 0.6)
    @IBInspectable let emptyColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
    @IBInspectable let diedColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 0.6)
    @IBInspectable let gridColor = UIColor.blackColor()
    @IBInspectable let gridWidth: CGFloat = 2
    
    
    enum CellState: String {
        case Living = "Living"
        case Born = "Born"
        case Empty = "Empty"
        case Died = "Died"
        
        func description(cell: CellState) -> String{
            return cell.rawValue
        }
        
        func allValues() -> [CellState]{
            return [Living, Born, Empty, Died]
        }
        

    }
    
    func toggle(cell:  CellState) -> CellState{
        switch cell{
        case .Living, .Born:
            return .Empty
        default:
            return .Living
        }
    }
    
    var grid : [[CellState]]!
    
    
    @IBInspectable var rows : Int  = 2{
        didSet{
            grid = [[CellState]] (count: rows, repeatedValue: Array(count: cols, repeatedValue: .Empty))
        }
    }
    @IBInspectable var cols : Int = 2{
        didSet{
            grid = [[CellState]] (count: rows, repeatedValue: Array(count: cols, repeatedValue: .Empty))
        }
    }
    
    override func drawRect(rect: CGRect) {
        let squareWidth = self.bounds.width / CGFloat(cols)
        let squareHeight = self.bounds.height / CGFloat(rows)
        
        gridColor.setStroke()
        let gridPath = UIBezierPath()
        
        gridPath.lineWidth = gridWidth
        for i in 0...rows - 1 {
            
            gridPath.moveToPoint(CGPoint(x: CGFloat(i) * squareWidth,
                y:0))
            gridPath.addLineToPoint(CGPoint(x:CGFloat(i) * squareWidth,
                y: self.bounds.height))
        }
        for i in 0...cols - 1 {
            
            gridPath.moveToPoint(CGPoint(x:0,
                y:CGFloat(i) * squareHeight))
            gridPath.addLineToPoint(CGPoint(x:self.bounds.width,
                y:CGFloat(i) * squareHeight))
        }
        gridPath.stroke()
        
        for x in 0...rows - 1{
            for y in 0...cols - 1 {
                let circle = UIBezierPath(ovalInRect: CGRectMake(CGFloat(x) * squareWidth + gridWidth, CGFloat(y) * squareHeight + gridWidth, squareWidth - 2 * gridWidth , squareWidth - 2 * gridWidth))
                switch grid[x][y]{
                case CellState.Living:
                    aliveColor.setFill()
                case CellState.Born:
                    bornColor.setFill()
                case CellState.Died:
                    diedColor.setFill()
                default:
                    emptyColor.setFill()
                }
 
                circle.fill()
            }
        }
    }
    
    func neighbors(coordinates: (Int,Int)) -> ([(Int, Int)]){
        var neighborCoordinates = [(Int,Int)]()
        for x in (-1)...1 {
            for y in (-1)...1 {
                var tempCoordinates = (coordinates.0 + x, coordinates.1 + y)
                    tempCoordinates.0 = tempCoordinates.0 % rows
                    tempCoordinates.1 = tempCoordinates.1 % cols
                if tempCoordinates.0 < 0{
                    tempCoordinates.0 = rows + tempCoordinates.0
                }
                if tempCoordinates.1 < 0{
                    tempCoordinates.1 = cols + tempCoordinates.1
                }
                
                neighborCoordinates += [tempCoordinates]
            }
        }
        return neighborCoordinates
    }
    
    func step() {
        var cellLocal = grid
        var cellFinal = grid
        for x in 0...rows - 1{
            for y in 0...cols - 1{
                var neighborCount = 0
                var neighborCoordinates = neighbors(x,y)
                for q in 0...8{
                    switch cellLocal[neighborCoordinates[q].0][neighborCoordinates[q].1]{
                        case CellState.Living, CellState.Born:
                        neighborCount += 1
                        default:
                        break
                    }
                    
                }
                
                if cellLocal[x][y] == .Living || cellLocal[x][y] == .Born {
                    if neighborCount < 2 || neighborCount > 3 {
                        cellFinal [x][y] = .Died
                    } else {
                        cellFinal[x][y] = .Living
                    }
                    
                } else {
                    if neighborCount == 3 {
                        cellFinal [x][y] = .Born
                    } else {
                        cellFinal[x][y] = .Empty
                    }
                }
            }
        }
        
        
        grid = cellFinal
        self.setNeedsDisplay()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            self.processTouch(touch )
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            self.processTouch(touch )
        }
    }
    
    //override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
   //     for touch in touches {
     //       self.processTouch(touch )
       // }
    //}
    
    func processTouch(touch: UITouch) {
        let squareWidth = self.bounds.width / CGFloat(cols)
        let squareHeight = self.bounds.height / CGFloat(rows)
        let point = touch.locationInView(self)
        let x = point.x
        let y = point.y
        var gridX = (Int(x) / Int(squareWidth))
        var gridY = (Int(y) / Int(squareHeight))
        if gridX < 0 {
            gridX = 1
        }
        if gridX > rows - 1{
            gridX = rows - 1
        }
        if gridY < 1{
            gridY = 0
        }
        if gridY > cols - 1{
            gridY = cols - 1
        }
        grid[gridX][gridY] = toggle(grid[gridX][gridY])
        let rect = CGRectMake(CGFloat(gridX) * squareWidth, CGFloat(gridY) * squareWidth, squareWidth, squareHeight)
        self.setNeedsDisplayInRect(rect)
    }
    
    
}