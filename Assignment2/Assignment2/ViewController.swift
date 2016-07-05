    //
    //  ViewController.swift
    //  Assignment2
    //
    //  Created by Micah Reid on 7/1/16.
    //  Copyright © 2016 Micah Reid. All rights reserved.
    //

    import UIKit

    class MainController: UIViewController {
        @IBOutlet weak var problem2: UIButton!
        @IBOutlet weak var problem3: UIButton!
        @IBOutlet weak var problem4: UIButton!
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
        
        
    }

    class Problem2: UIViewController{
        
        var cells = [[Bool]](count:10, repeatedValue: Array(count:10, repeatedValue: false))
        var count = 0
        
        @IBOutlet weak var textBox: UITextView!
        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = ("Problem 2")
        }
        
        
        @IBAction func button(sender: AnyObject) {
            count = 0
            for x in 0...9 {
                for y in 0...9 {
                    if arc4random_uniform(3) == 1 {
                        cells[x][y] = true
                    } else {
                        cells[x][y] = false
                    }
                    
                }
            }
            var cells2 = cells
            for x in 0...9{
                var line = ""
                for y in 0...9{
                    if cells[x][y] == true{
                        count += 1
                        line += "x"
                    } else {
                        line += "o"
                    }
                }
                print ("\(line)")
                
            }
            print ("\(count)")
            
            
            var neighborCount = 0
            
            for x in 0...9{
                for y in 0...9{
                    neighborCount = 0
                    for q in (-1)...1{
                        for z in (-1)...1{
                            var checkX = x + q
                            var checkY = y + z
                            if checkX < 0{
                                checkX = 9
                            }
                            if checkY < 0{
                                checkY = 9
                            }
                            if checkX > 9 {
                                checkX = 0
                            }
                            if checkY  > 9 {
                                checkY = 0
                            }
                            if cells[checkX][checkY] == true {
                                neighborCount += 1
                            }
                            
                        }
                        
                        
                        
                    }
                    if cells[x][y] == true {
                        neighborCount -= 1
                    }
                    print ("\(neighborCount)")
                    if cells[x][y] == true {
                        if neighborCount < 2 || neighborCount > 3 {
                            cells2 [x][y] = false
                        }
                        
                    } else {
                        if neighborCount == 3 {
                            cells2 [x][y] = true
                        }
                    }
                }
            }
            count = 0
            for x in 0...9{
                for y in 0...9{
                    if cells2[x][y] == true{
                        count += 1
                    }
                }
            }
            textBox.text = "living cells = \(count)"
            
            
        }
        
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
    }

    class Problem3: UIViewController{
        var cells = [[Bool]](count:10, repeatedValue: Array(count:10, repeatedValue: false))
        
        @IBOutlet weak var textBox: UITextView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = ("Problem 3")
            
        }
        func step(cell: [[Bool]]) -> ([[Bool]]) {
            var cellLocal = cell
            var cellFinal = cell
            var neighborCount = 0
            
            for x in 0...9{
                for y in 0...9{
                    neighborCount = 0
                    for q in (-1)...1{
                        for z in (-1)...1{
                            var checkX = x + q
                            var checkY = y + z
                            if checkX < 0{
                                checkX = 9
                            }
                            if checkY < 0{
                                checkY = 9
                            }
                            if checkX > 9 {
                                checkX = 0
                            }
                            if checkY  > 9 {
                                checkY = 0
                            }
                            if cellLocal[checkX][checkY] == true {
                                neighborCount += 1
                            }
                            
                        }
                        
                        
                        
                    }
                    if cellLocal[x][y] == true {
                        neighborCount -= 1
                    }
                    if cellLocal[x][y] == true {
                        if neighborCount < 2 || neighborCount > 3 {
                            cellFinal [x][y] = false
                        }
                        
                    } else {
                        if neighborCount == 3 {
                            cellFinal [x][y] = true
                        }
                    }
                }
            }
            
            return cellFinal
        }
        @IBAction func button(sender: AnyObject) {
            
            for x in 0...9 {
                for y in 0...9 {
                    if arc4random_uniform(3) == 1 {
                        cells[x][y] = true
                    } else {
                        cells[x][y] = false
                    }
                    
                }
            }
            
            cells = step(cells)
            var count = 0
            for x in 0...9{
                for y in 0...9{
                    if cells[x][y] == true{
                        count += 1
                    }
                }
            }
            textBox.text = "living cells = \(count)"
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
    }

    class Problem4: UIViewController{
        
        @IBOutlet weak var textBox: UITextView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = ("Problem 4")
            
        }
        @IBAction func button(sender: AnyObject) {
            var cells = [[Bool]](count:10, repeatedValue: Array(count:10, repeatedValue: false))
            
            
            for x in 0...9 {
                for y in 0...9 {
                    if arc4random_uniform(3) == 1 {
                        cells[x][y] = true
                    } else {
                        cells[x][y] = false
                    
                    }
                }
                
                
                cells = steps(cells)
                var line = ""
                var count = 0

                for x in 0...9{
                    line = ""
                    for y in 0...9{
                        if cells[x][y] == true{
                            count += 1
                            line += "x"
                        } else {
                            line += "o"
                        }
                    }
                }
                    //print ("\(line)")

                textBox.text = "living cells = \(count)"

            }
            
        }
        func neighbors(coordinates: (Int,Int)) -> ([(Int, Int)]){
            var neighborCoordinates = [(Int,Int)]()
            for x in (-1)...1 {
                for y in (-1)...1 {
                    var tempCoordinates = (coordinates.0 + x, coordinates.1 + y)
                    switch tempCoordinates {
                    case (_, 10):
                        tempCoordinates.1 = 0
                    case (_, -1):
                        tempCoordinates.1 = 9
                    default:()
                    }
                    switch tempCoordinates {
                    case (10, _):
                        tempCoordinates.0 = 0
                    case(-1, _):
                        tempCoordinates.0 = 9
                    default:()
                    }
                    neighborCoordinates += [tempCoordinates]
                }
            }
            return neighborCoordinates
        }
        
            
            func steps(cell: [[Bool]]) -> ([[Bool]]){
                var cellLocal = cell
                var cellFinal = cell
                for x in 0...9{
                    for y in 0...9{
                        var neighborCount = 0
                        var neighborCoordinates = neighbors(x,y)
                        for q in 0...8{
                            if cellLocal[neighborCoordinates[q].0][neighborCoordinates[q].1] == true{
                                neighborCount += 1
                            }
                        }
                        
                        if cellLocal[x][y] == true {
                            if neighborCount < 2 || neighborCount > 3 {
                                cellFinal [x][y] = false
                            }
                            
                        } else {
                            if neighborCount == 3 {
                                cellFinal [x][y] = true
                            }
                        }
                    }
                }
                
                
                return cellFinal
            }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
    }
