//
//  YourSeatViewController.swift
//  SmartSeating
//
//  Created by Dylan Maryk on 03/04/2019.
//  Copyright © 2019 dylanmaryk. All rights reserved.
//

import Gradients
import UIKit

class YourSeatViewController: UIViewController {
    
    @IBOutlet private weak var getYourTicketButton: UIButton!
    
    var interestsResponse: InterestsResponse? {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradientLayer = Gradients.linear(to: .right,
                                             colors: [UIColor(red: 69/255, green: 248/255, blue: 245/255,
                                                              alpha: 1).cgColor,
                                                      UIColor(red: 33/255, green: 67/255, blue: 238/255,
                                                              alpha: 1).cgColor],
                                             locations: [0, 1])
        gradientLayer.cornerRadius = getYourTicketButton.frame.height / 2
        gradientLayer.frame = getYourTicketButton.bounds
        getYourTicketButton.layer.addSublayer(gradientLayer)
    }
    
}
