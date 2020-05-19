//
//  BoardDrawDelegate.swift
//  GameofLife2
//
//  Created by Tejas Thiyagarajan on 5/18/20.
//  Copyright © 2020 Tejas Thiyagarajan. All rights reserved.
//

protocol BoardDrawDelegate {
    func displayCells(r: Int, c: Int, state: Bool)
}
