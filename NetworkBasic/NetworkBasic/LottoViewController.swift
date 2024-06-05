//
//  LottoViewController.swift
//  NetworkBasic
//
//  Created by 장예지 on 6/4/24.
//

import UIKit
import Alamofire
import SnapKit

/*
 할일 1. responseString로 point 되는 내용을 어떻게 화면에 띄우지
 //String => Struct (Decoding) => View
 
 항리 2. 코드 실행 순서 이해 -> 네트워크 응답을 받는데 5초도 걸릴 수 있음
 */
class LottoViewController: UIViewController {
    
    let baseUrl = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo="
    
    var lotto: Lotto? {
        didSet {
            refreshUI()
        }
    }
    
    let roundTextField: UITextField = {
        let object = UITextField()
        object.borderStyle = .roundedRect
        object.placeholder = "회차를 입력해주세요"
        return object
    }()
    
    let lottoNumberStackView: UIStackView = {
        let object = UIStackView()
        object.axis = .horizontal
        object.alignment = .fill
        object.spacing = 10
        object.distribution = .fillEqually
        return object
    }()
    
    let raffelLabel: UILabel = {
        let object = UILabel()
        object.font = .boldSystemFont(ofSize: 14)
        object.text = "당첨번호 안내"
        return object
    }()
    
    let raffelDateLabel: UILabel = {
        let object = UILabel()
        object.font = .boldSystemFont(ofSize: 12)
        object.text = "2024-05-21 추첨"
        return object
    }()
    
    let seperatorView: UIView = {
        let object = UIView()
        object.backgroundColor = .darkGray
        return object
    }()
    
    let resultLabel: UILabel = {
        let object = UILabel()
        object.font = .boldSystemFont(ofSize: 24)
        object.text = "당첨결과"
        return object
    }()
    
    let bonusNumberLabel: UILabel = {
        let object = UILabel()
        object.textColor = .black
        object.font = .systemFont(ofSize: 10)
        object.textAlignment = .center
        object.text = "보너스"
        return object
    }()
    
    let pickerView: UIPickerView = {
        let object = UIPickerView()
        return object
    }()
    
    var selectedRow = UserDefaults.standard.integer(forKey: "recentlyRound") - 1
    
    var selectRound: Int {
        get {
            return selectedRow + 1
        }
    }
    var recentlyRound: Int = UserDefaults.standard.integer(forKey: "recentlyRound")
    var lottoNumberViews: [LottoNumberView] = []
    lazy var appearList = [raffelDateLabel, seperatorView, resultLabel, lottoNumberStackView, bonusNumberLabel]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureHierarchy()
        configureLayout()
        configureUI()
        print(recentlyRound)
        searchRecentlyRound(recentlyRound)
        
    }
    
    func searchRecentlyRound(_ number: Int){
        
        recentlyRound = number == 0 ? 1 : number
            
        print("최신회차: \(recentlyRound)")
        
        let url = "\(baseUrl)\(String(recentlyRound))"
        AF.request(url).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let lotto):
                self.searchRecentlyRound(self.recentlyRound+1)
            case .failure(let error):
                print(error)
                self.callAPI(number: self.recentlyRound-1)
                UserDefaults.standard.set(self.recentlyRound-1, forKey: "recentlyRound")
                
                DispatchQueue.main.async {
                    self.pickerView.selectRow(self.recentlyRound-1, inComponent: 0, animated: true)
                }
            }
        }
    }
    
    func configureHierarchy(){
        view.addSubview(roundTextField)
        view.addSubview(raffelLabel)
        view.addSubview(raffelDateLabel)
        view.addSubview(seperatorView)
        view.addSubview(lottoNumberStackView)
        view.addSubview(resultLabel)
        view.addSubview(bonusNumberLabel)
        
        for index in 0...7 {
            
            let item = LottoNumberView()
            
            switch index{
            case 0...1:
                item.backgroundView.backgroundColor = LottoColor.yellow
            case 2...3:
                item.backgroundView.backgroundColor = LottoColor.red
            case 4...5:
                item.backgroundView.backgroundColor = LottoColor.gray
            case 6:
                let plusItem = UIImageView()
                plusItem.image = UIImage(systemName: "plus")
                plusItem.contentMode = .scaleAspectFit
                plusItem.tintColor = .darkGray
                lottoNumberStackView.addArrangedSubview(plusItem)
                continue
            case 7:
                item.backgroundView.backgroundColor = LottoColor.red
            default:
                return
            }
            
            lottoNumberViews.append(item)
            lottoNumberStackView.addArrangedSubview(item)
            
        }
    }
    
    func configureLayout(){
        roundTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        raffelLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(roundTextField.snp.bottom).offset(40)
        }
        
        raffelDateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(roundTextField.snp.bottom).offset(40)
        }
        
        seperatorView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(raffelDateLabel.snp.bottom).offset(20)
            make.height.equalTo(1)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(seperatorView.snp.bottom).offset(24)
        }
        
        lottoNumberStackView.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        bonusNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(lottoNumberStackView.snp.bottom).offset(10)
            make.trailing.equalTo(lottoNumberStackView.snp.trailing)
            make.width.equalTo(lottoNumberStackView.snp.height)
        }
    }
    
    func configureUI(){
        roundTextField.inputView = pickerView
        appearList.map{ $0.isHidden = true }
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func refreshUI(){
        guard let lotto = lotto else { return }
        
        appearList.map{ $0.isHidden = false }
        raffelDateLabel.text = "\(lotto.drwNoDate) 추첨"
        resultLabel.text = "\(lotto.drwNo)회 당첨결과"
        
        for (index, number) in lotto.numberList.enumerated() {
            lottoNumberViews[index].lottoNumberLabel.text = "\(number)"
        }
        
        roundTextField.text = selectRound == 0 ? "" : "\(selectRound)"
    }
    
    func callAPI(number: Int){
        print(number)
        let url = "\(baseUrl)\(String(number))"
        AF.request(url).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let lotto):
                self.lotto = lotto
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return recentlyRound
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row) 회차"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
        callAPI(number: selectRound)
    }
    
}
