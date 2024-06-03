//
//  ReusableProtocol.swift
//  NetworkBasic
//
//  Created by 장예지 on 6/3/24.
//

import UIKit

//AnyObject: 클래스 제약인 이유?

protocol ReusableProtocol: AnyObject {
    static var id: String { get } //최소 조건 지금은 set은 선택사항
}

//Non-class type 'User' cannot conform to class protocol 'ReusableProtocol'
struct StructTypeUser /*: ReusableProtocol */{
    
}

extension UITableViewCell: ReusableProtocol {
    static var id: String {
        return String(describing: self)
    }
}

extension UIViewController: ReusableProtocol {
    static var id: String {
        return String(describing: self)
    }
}
