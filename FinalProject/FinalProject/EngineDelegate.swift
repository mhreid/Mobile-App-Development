//
//  EngineDelegate.swift
//  FinalProject
//
//  Created by Micah Reid on 7/29/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import Foundation

protocol EngineDelegate: class{
    func engineDidUpdate(withGrid: GridProtocol)
}