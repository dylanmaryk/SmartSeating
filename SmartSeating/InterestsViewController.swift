//
//  InterestsViewController.swift
//  SmartSeating
//
//  Created by Dylan Maryk on 03/04/2019.
//  Copyright © 2019 dylanmaryk. All rights reserved.
//

import Alamofire
import DropDown
import PromiseKit
import RxGesture
import RxSwift
import UIKit

struct InterestsRequest: Encodable {
    let interests: [String]
}

struct InterestsResponse: Decodable {
    let seat: String
    let neighbors: [Neighbor]
}

struct Neighbor: Decodable {
    let assignedSeat: String
    let interests: [String]
}

class InterestsViewController: UIViewController {
    
    @IBOutlet weak var interest1Label: UILabel! {
        didSet {
            interest1Label.rx.tapGesture().when(.recognized).subscribe(onNext: { [unowned self] _ in
                self.dropDown.anchorView = self.interest1Label
                self.dropDown.show()
                self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                    self.interest1Label.textColor = .black
                    self.interest1Label.text = item
                    self.interest2Label.isHidden = false
                    self.interest2Divider.isHidden = false
                    self.dropDown.anchorView = self.interest2Label
                }
            }).disposed(by: disposeBag)
        }
    }
    
    @IBOutlet weak var interest2Label: UILabel! {
        didSet {
            interest2Label.rx.tapGesture().when(.recognized).subscribe(onNext: { [unowned self] _ in
                self.dropDown.anchorView = self.interest2Label
                self.dropDown.show()
                self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                    self.interest2Label.textColor = .black
                    self.interest2Label.text = item
                    self.interest3Label.isHidden = false
                    self.interest3Divider.isHidden = false
                    self.dropDown.anchorView = self.interest3Label
                }
            }).disposed(by: disposeBag)
        }
    }
    
    @IBOutlet weak var interest3Label: UILabel! {
        didSet {
            interest3Label.rx.tapGesture().when(.recognized).subscribe(onNext: { [unowned self] _ in
                self.dropDown.anchorView = self.interest3Label
                self.dropDown.show()
                self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                    self.interest3Label.textColor = .black
                    self.interest3Label.text = item
                    self.interest4Label.isHidden = false
                    self.interest4Divider.isHidden = false
                    self.dropDown.anchorView = self.interest4Label
                }
            }).disposed(by: disposeBag)
        }
    }
    
    @IBOutlet weak var interest4Label: UILabel!
    
    @IBOutlet weak var interest1Divider: UIView!
    @IBOutlet weak var interest2Divider: UIView!
    @IBOutlet weak var interest3Divider: UIView!
    @IBOutlet weak var interest4Divider: UIView!
    
    @IBOutlet weak var doneButton: UIButton! {
        didSet {
            doneButton.rx.tapGesture().when(.recognized).subscribe(onNext: { [unowned self] _ in
                self.request()
            }).disposed(by: disposeBag)
        }
    }
    
    private let dropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.dataSource = ["football",
                               "ancient history",
                               "arts",
                               "Rust",
                               "tourism",
                               "books",
                               "numismatics",
                               "computer science",
                               "mathematics",
                               "basketball",
                               "tennis",
                               "tv shows",
                               "series",
                               "movies",
                               "chess",
                               "video games",
                               "strikeball",
                               "theatre",
                               "gardening",
                               "body building",
                               "business",
                               "cynology",
                               "veganism",
                               "HLS",
                               "sports ing general",
                               "cooking",
                               "volonteerism"]
        dropDown.direction = .bottom
        return dropDown
    }()
    private let disposeBag = DisposeBag()
    
    private var interestsResponse: InterestsResponse?
    
    private func request() {
        let interestsRequest = InterestsRequest(interests: [interest1Label.text!,
                                                            interest2Label.text!,
                                                            interest3Label.text!])
        let interestsRequestDict = try! JSONDecoder().decode([String : [String]].self,
                                                             from: try! JSONEncoder().encode(interestsRequest))
        firstly {
            Alamofire
                .request("http://51.15.36.48:7777/request_seat",
                         method: .post,
                         parameters: interestsRequestDict,
                         encoding: JSONEncoding.default)
                .debugLog()
                .responseString { response in
                    print(response)
                }
                .responseDecodable(InterestsResponse.self)
            }
            .done { response in
                print(response)
                self.interestsResponse = response
                self.performSegue(withIdentifier: "yourSeatViewController", sender: nil)
            }
            .catch { error in
                print(error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as! YourSeatViewController).interestsResponse = interestsResponse
    }
    
}

extension Request {
    
    func debugLog() -> Self {
        debugPrint(self)
        return self
    }
    
}
