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
    
    @IBOutlet private weak var yourSeatLabel: UILabel!
    @IBOutlet private weak var neighbor1Label: UILabel!
    @IBOutlet private weak var neighbor2Label: UILabel!
    @IBOutlet private weak var neighbor1Interest1Label: UILabel!
    @IBOutlet private weak var neighbor1Interest2Label: UILabel!
    @IBOutlet private weak var neighbor1Interest3Label: UILabel!
    @IBOutlet private weak var neighbor1Interest4Label: UILabel!
    @IBOutlet private weak var neighbor1Interest5Label: UILabel!
    @IBOutlet private weak var neighbor2Interest1Label: UILabel!
    @IBOutlet private weak var neighbor2Interest2Label: UILabel!
    @IBOutlet private weak var neighbor2Interest3Label: UILabel!
    @IBOutlet private weak var neighbor2Interest4Label: UILabel!
    @IBOutlet private weak var neighbor2Interest5Label: UILabel!
    
    @IBOutlet private weak var getYourTicketButton: UIButton!
    
    var interestsResponse: InterestsResponse? {
        didSet {
            yourSeatLabel.text = interestsResponse?.seat
            neighbor1Label.text = interestsResponse?.neighbors[0].assignedSeat ?? ""
            neighbor2Label.text = interestsResponse?.neighbors[1].assignedSeat ?? ""
            neighbor1Interest1Label.text = interestsResponse?.neighbors[0].interests[0] ?? ""
            neighbor1Interest2Label.text = interestsResponse?.neighbors[0].interests[1] ?? ""
            neighbor1Interest3Label.text = interestsResponse?.neighbors[0].interests[2] ?? ""
            neighbor1Interest4Label.text = interestsResponse?.neighbors[0].interests[3] ?? ""
            neighbor1Interest5Label.text = interestsResponse?.neighbors[0].interests[4] ?? ""
            neighbor2Interest1Label.text = interestsResponse?.neighbors[1].interests[0] ?? ""
            neighbor2Interest2Label.text = interestsResponse?.neighbors[1].interests[1] ?? ""
            neighbor2Interest3Label.text = interestsResponse?.neighbors[1].interests[2] ?? ""
            neighbor2Interest4Label.text = interestsResponse?.neighbors[1].interests[3] ?? ""
            neighbor2Interest5Label.text = interestsResponse?.neighbors[1].interests[4] ?? ""
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
