//
//  ViewController.swift
//  SmartSeating
//
//  Created by Dylan Maryk on 03/04/2019.
//  Copyright © 2019 dylanmaryk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var regularSeatButton: UIButton!
    @IBOutlet private weak var networkAreaButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regularSeatButton.layer.cornerRadius = regularSeatButton.frame.height / 2
        networkAreaButton.layer.cornerRadius = networkAreaButton.frame.height / 2
    }
    
}
