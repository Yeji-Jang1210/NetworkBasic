//
//  FrameViewController.swift
//  NetworkBasic
//
//  Created by 장예지 on 6/4/24.
//

import UIKit

//Storyboard 기반 작업
//1. StoryboardScene > 2. Swift File( Cocoa Touch Class) > 3. Storyboard에서 연결

//Frame based layout -> Auto Resizing -> Auto layout -> Adaptive layout

//AutoResizing 설정을 하면 AutoResizing 기반으로 Constraints가 잡힌다.
// >> 따라서 뷰의 크기나 위치를 수정하기 위해 추가적으로 Constraints 제약 조건 설정하는 것은 불가능하다.
// >> 충돌이 날 수 있기 때문

//Codebase 기반 작업
class FrameViewController: UIViewController {
    
    //1. 뷰 객체에 대한 프로퍼티 선언(클래스 인스턴스)
    let emailTextField = UITextField()
    let signButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        //2. 루트뷰에 뷰 추가
        //늦게 추가 된 오브젝트가 가장 위에 뜬다. - 뷰 계층 순서 유의!!
        view.addSubview(emailTextField)
        view.addSubview(signButton)
        
        //3. 뷰 객체와 크기와 위치 설정
        emailTextField.frame = CGRect(x: 40, y: 100, width: 300, height: 50)
        emailTextField.backgroundColor = .systemOrange
        
        //디바이스의 실제적인 너비 아는 법
        let device = UIScreen.main.bounds
        
        signButton.frame = CGRect(x: 50, y: 170, width: device.width - 100, height: 50)
        signButton.setTitle("Sign", for: .normal)
        signButton.backgroundColor = .green
        signButton.layer.cornerRadius = signButton.frame.height / 2
    }

}
