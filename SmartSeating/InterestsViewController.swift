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
    
    private var interestsResponse: InterestsResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dropDown = DropDown()
        dropDown.dataSource = ["cats", "dogs", "skiing", "cooking", "football", "Marvel comics", "Game of Thrones"]
        let interestsRequest = InterestsRequest(interests: ["football", "ancient history"])
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
