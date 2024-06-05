//
//  Snap2ViewController.swift
//  NetworkBasic
//
//  Created by 장예지 on 6/4/24.
//

import UIKit
import SnapKit

//safeAreaLayoutGuide
//addSubView
//illegal
//offset,inset


class Snap2ViewController: UIViewController {
    
    let redView = UIView()
    let blueView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    func configureHierarchy(){
        //view.addSubview(blueView)
        view.addSubview(redView)
        redView.addSubview(blueView)
    }
    
    func configureLayout(){
        redView.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide)
            make.width.height.equalTo(300)
            
            //size: width와 height을 포함하고있는 프로퍼티
            //make.size.equalTo(300)
        }
        
        blueView.snp.makeConstraints { make in
            //offset은 무조건 +
            make.edges.equalToSuperview().inset(50)
        }
    }
    
    func configureUI(){
        view.backgroundColor = .systemBackground
        redView.backgroundColor = .systemRed
        blueView.backgroundColor = .systemBlue
    }
}
