//
//  ViewController.swift
//  NetworkBasic
//
//  Created by 장예지 on 6/3/24.
//

import UIKit

struct User {
    let name: String
    let age: Int
    let bgColor: UIColor
    
    //메모리 공간을 차지하지 않음
    var userAge: String {
        return "\(age)세"
    }
    
    init(name: String) {
        self.name = name
        self.age = .random(in: 1...100)
        self.bgColor = UIColor.random()
    }
}

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let list: [User] = [
        User(name: "뽀로로"),
        User(name: "무지"),
        User(name: "둘리"),
        User(name: "라이언")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureBarButtonImem()
    }
    
    func configureBarButtonImem(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(playButtonClicked))
    }
    
    @objc func playButtonClicked(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: AddEditViewController.id) as! AddEditViewController
        vc.type = .add
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
    
    //self: 클래스의 인스턴스
    //delegate, dataSource 프로퍼티는 프로토콜 자리...
    //타입으로서의 프로토콜(Protocol as Type)
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        
        let xib = UINib(nibName: BasicTableViewCell.id, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: BasicTableViewCell.id)
    }
}

//Delegate, DataSource의 역할?
//SearchBar, UITextField << Delegate만
//PickerView, UITableView << Delegate, DataSource 둘다
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BasicTableViewCell.id, for: indexPath) as! BasicTableViewCell
        
        let data = list[indexPath.row]
        cell.textLabel?.text = data.name
        cell.detailTextLabel?.text = data.userAge
        cell.backgroundColor = data.bgColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: UserViewController.id) as! UserViewController
//        vc.data = list[indexPath.row]
//        present(vc, animated: true)
//        let vc = storyboard?.instantiateViewController(withIdentifier: UserViewController.id) as! UserViewController
//        navigationController?.pushViewController(vc, animated: true)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: AddEditViewController.id) as! AddEditViewController
        vc.type = .edit
        navigationController?.pushViewController(vc, animated: true)
    }
}
