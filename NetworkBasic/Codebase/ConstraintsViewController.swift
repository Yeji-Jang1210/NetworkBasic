//
//  ConstraintsViewController.swift
//  NetworkBasic
//
//  Created by 장예지 on 6/4/24.
//

import UIKit

/*
 1. AutoResizing
 2. NS(NextStep: 스티븐 잡스가 전에 다니던 회사 이름..)LayoutConstraints
    - isActive
    - addConstraints
 3. NSLayoutAnchor
 */

/*
Adaptive Layout
    - Size Class
    - Trait Collection
    - Universial
 */
class ConstraintsViewController: UIViewController {
    
    let emailTextField = UITextField()
    let signButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(emailTextField)
        view.addSubview(signButton)

        //⭐️ NSLayoutConstrains로 autolayout을 잡으려면 밑의 변수를 false로 바꿔줘야한다.
        //AutoResizing기능을 사용하지 않고 레이아웃을 잡겠다고 알려주는 변수
        //AutoResizing과 AutoLayout을 함께 쓰면 충돌이 나기 때문
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.backgroundColor = .systemGray
        
        signButton.translatesAutoresizingMaskIntoConstraints = false
        signButton.backgroundColor = .systemMint
        
//MARK: 2. NSLayoutConstraints
        //새로 생성한 제약조건은 false가 default
        let top = NSLayoutConstraint(item: emailTextField, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0)
        //top.isActive = true
        
        let leading = NSLayoutConstraint(item: emailTextField, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 50)
        //leading.isActive = true
        
        let trailing = NSLayoutConstraint(item: emailTextField, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -50)
        //trailing.isActive = true
        
        //height은 비교할 대상이 없다면 nil을 적어주면 된다.
        let height = NSLayoutConstraint(item: emailTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50)
        //height.isActive = true
        
        //일일히 isActive = true를 달아줄 필요가 없음
        view.addConstraints([top, leading, trailing, height])
        
//MARK: 3. NSLayoutAnchor
        NSLayoutConstraint.activate([
            signButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            signButton.heightAnchor.constraint(equalToConstant: 50),
            signButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
    }

}
