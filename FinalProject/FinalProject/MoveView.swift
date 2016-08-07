//
//  MoveView.swift
//  FinalProject
//
//  Created by Micah Reid on 8/6/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import UIKit

class MoveView: UIViewController{
    
    override func viewDidLoad() {
        print("test")
        performSegueWithIdentifier("toInstrumentation", sender: self)


    }
    override func viewDidAppear(animated: Bool) {
        performSegueWithIdentifier("toInstrumentation", sender: self)

    }
    
}
