//
//  AddEditViewController.swift
//  NetworkBasic
//
//  Created by 장예지 on 6/3/24.
//

import UIKit

// 휴먼 에러 방지, 컴파일 타임 오류 처리 가능
enum ViewType: String {
    case add = "추가"
    case edit = "수정"
    
    //연산 프로퍼티 활용
    var title: String {
        switch self {
        case .add, .edit:
            return "\(self.rawValue)하기"
        }
    }
    
    var placeholder: String {
        switch self {
        case .add, .edit:
            return "\(self.rawValue)할 단어를 입력해 주세요."
        }
    }
}

class AddEditViewController: UIViewController {
    
    @IBOutlet var searchTextField: UITextField!
    
    var type: ViewType = .add
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = type.title
        searchTextField.placeholder = type.placeholder
        
        configureBarButtonImem()
    }
    
    func configureBarButtonImem(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: type.rawValue, style: .plain, target: self, action: #selector(saveButtonClicked))
    }
    
    @objc func saveButtonClicked() {
        switch type {
        case .add:
            //추가인경우
            dismiss(animated: true)
        case .edit:
            //편집인경우
            navigationController?.popViewController(animated: true)
        }
    }
}
