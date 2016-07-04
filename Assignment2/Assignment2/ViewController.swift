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
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        for x in 0...9 {
            for y in 0...9 {
                if arc4random_uniform(3) == 1 {
                    cells[x][y] = true
                }
                
            }
        }
        for x in 0...9{
            for y in 0...9{
                if cells[x][y] == true{
                    count += 1
                }
            }
        }
        var neighborCount = 0

        for x in 0...9{
            for y in 0...9{
                neighborCount = 0
                for q in -1...1{
                    for z in -1...1{
                        if cells[(10+x+q)%10][(10+y+z)%10] == true && (q != 0 && z != 0){
                            neighborCount += 1
                    }
                        
                    if cells[x][y] == true {
                        if neighborCount < 2 || neighborCount > 3 {
                            cells [x][y] = false
                        }

                        } else {
                            if neighborCount == 3 {
                                cells [x][y] = true
                            }
                        }
                    }
                }
            }
        }
        
        count = 0
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
        // Dispose of any resources that can be recreated.
    }
}

class Problem3: UIViewController{


    @IBOutlet weak var textBox: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ("Problem 3")
    }
    func step(cell: [[Bool]]) -> ([[Bool]]) {
        var neighborCount = 0
        var cells = cell
        for x in 0...9{
            for y in 0...9{
                neighborCount = 0
                for q in -1...1{
                    for z in -1...1{
                        if cells[(10+x+q)%10][(10+y+z)%10] == true && (q != 0 && z != 0){
                            neighborCount += 1
                        }
                        
                        if cells[x][y] == true {
                            if neighborCount < 2 || neighborCount > 3 {
                                cells [x][y] = false
                            }
                            
                        } else {
                            if neighborCount == 3 {
                                cells [x][y] = true
                            }
                        }
                    }
                }
            }
        }
        

        
        return cells
    }
    @IBAction func button(sender: AnyObject) {
        var cells = [[Bool]](count:10, repeatedValue: Array(count:10, repeatedValue: false))
        var count = 0
        for x in 0...9 {
            for y in 0...9 {
                if arc4random_uniform(3) == 1 {
                    cells[x][y] = true
                }
            }
            
        }
        cells = step(cells)
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
        // Dispose of any resources that can be recreated.
    }
}

class Problem4: UIViewController{
    
    
    @IBOutlet weak var textBox: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ("Problem 4")
    }

    @IBAction func button(sender: AnyObject) {
        textBox.text = "happy birthday"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
