
//
//  GridView.swift
//  FinalProject
//
//  Created by Micah Reid on 7/28/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import UIKit

class GridView: UIView {
    
    typealias Position = (row: Int, col: Int)
    typealias Cell = (position: Position, state: CellState)
    
    let maxDimension = 40

    var cols: Int = 20{
        didSet{
            setNeedsDisplay()
        }
    }
    var rows: Int = 20{
        didSet{
            setNeedsDisplay()
        }
    }
    var aliveColor = UIColor(red: 0, green: 0.8, blue: 0.1, alpha: 1)
    var bornColor = UIColor(red: 0, green: 0.8, blue: 0.1, alpha: 0.6)
    var emptyColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    var diedColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.8)
    var grid: GridProtocol = Grid(rows: 20, cols: 20){
        didSet{
            setNeedsDisplay()
        }
    }
    
    static var gridView :GridView = GridView()
    
    
    override func drawRect(rect: CGRect) {
        
        cols = StandardEngine.sharedInstance.grid.cols
        rows = StandardEngine.sharedInstance.grid.rows
        super.drawRect(rect)
        let width = self.bounds.width
        let circleWidth: CGFloat = width / CGFloat(maxDimension)
        
        let yIndent: CGFloat = CGFloat((width - CGFloat(cols) * circleWidth)/2)
        let xIndent: CGFloat = CGFloat((width - CGFloat(rows) * circleWidth)/2)
        for x in 0...cols - 1{
            for y in 0...rows - 1{
                switch StandardEngine.sharedInstance.grid.cells[rows * x + y].1{
                case .Alive: aliveColor.setFill()
                case .Empty: emptyColor.setFill()
                case .Born: bornColor.setFill()
                default: diedColor.setFill()
                }
                let circle = UIBezierPath(ovalInRect: CGRectMake(yIndent + CGFloat(x) * circleWidth, xIndent + CGFloat(y) * circleWidth, circleWidth, circleWidth))
                circle.fill()
            }
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            self.processTouch(touch )
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            self.processTouch(touch)
        }
    }
    
    func processTouch(touch: UITouch) {
        
        
        let circleWidth: CGFloat = self.bounds.width / CGFloat(maxDimension)
        let yIndent: CGFloat = CGFloat((self.bounds.width - CGFloat(rows) * circleWidth)/2)
        let xIndent: CGFloat = CGFloat((self.bounds.width - CGFloat(cols) * circleWidth)/2)
        
        
        let point = touch.locationInView(self)
        let x = point.x
        let y = point.y
        let gridX : Int = Int(x / circleWidth) - Int(xIndent / circleWidth)
        let newYIndent = Int(yIndent / circleWidth)
        let gridY : Int = Int(y / circleWidth) - newYIndent


        if(gridX < cols && gridX >= 0 && gridY < cols && gridY >= 0){
            StandardEngine.sharedInstance.grid.cells[rows * gridX + gridY].1 = StandardEngine.sharedInstance.grid.cells[rows * gridX + gridY].1.toggle()
        }

        self.setNeedsDisplay()
    }

    
}