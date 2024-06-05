//
//  SnapKitViewController.swift
//  NetworkBasic
//
//  Created by 장예지 on 6/4/24.
//

import UIKit
import SnapKit

class SnapKitViewController: UIViewController {
    
    let photoImageView = UIImageView()
    
    //변수에 함수를 저장할 수 있기 때문에 가능한 구문
    //이름 없는 함수를 만든 후 호출 () <-로 호출
    let titleTextField: UITextField = {
        let view = UITextField()
        view.backgroundColor = .systemGray6
        view.placeholder = "제목을 입력해주세요"
        view.borderStyle = .none
        view.textAlignment = .center
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    let dateTextField = UITextField()
    let contentTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //항상 addSubView 먼저!!
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    func configureHierarchy(){
        //array:[UIView]
        
        //취향의 차이!
//        let array = [photoImageView, emailTextField, dateTextField, contentTextView]
//        for item in array {
//            view.addSubview(item)
//        }
        
        view.addSubview(photoImageView)
        view.addSubview(titleTextField)
        view.addSubview(dateTextField)
        view.addSubview(contentTextView)
    }
    
    func configureLayout(){
        //make말고 remake...등등 있음
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
            make.height.equalTo(300)
        }
        
        titleTextField.snp.makeConstraints { make in
            //imageView의 bottom과 20만큼 떨어져 있음
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
            make.height.equalTo(50)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
            make.height.equalTo(50)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(20)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureUI(){
        view.backgroundColor = .systemBackground
        
        photoImageView.backgroundColor = .gray
        photoImageView.contentMode = .scaleAspectFill
        
        dateTextField.backgroundColor = .systemGray5
        
        contentTextView.backgroundColor = .systemGray4
    }
}
