//
//  UserViewController.swift
//  NetworkBasic
//
//  Created by 장예지 on 6/3/24.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet var userLabel: UILabel!
    
    //카카오와 친구들일 때
    
    
    var data: User? //1.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let data = data else {
            userLabel.text = "손님"
            return
        }
        
        userLabel.text = "\(data.name)\n\(data.userAge)"
    }
    
}
