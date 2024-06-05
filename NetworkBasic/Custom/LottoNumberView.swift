//
//  LottoNumberView.swift
//  NetworkBasic
//
//  Created by 장예지 on 6/5/24.
//

import UIKit
import SnapKit

class LottoNumberView: UIView {
    
    let backgroundView: UIView = {
        let object = UIView()
        object.backgroundColor = .orange
        return object
    }()
    
    let lottoNumberLabel: UILabel = {
        let object = UILabel()
        object.textColor = .white
        object.textAlignment = .center
        object.font = .boldSystemFont(ofSize: 20)
        return object
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        let height = bounds.height
        layer.cornerRadius = height/2
    }
    
    func configureHierarchy(){
        self.addSubview(backgroundView)
        self.addSubview(lottoNumberLabel)
    }
    
    func configureLayout(){
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(backgroundView.snp.width).multipliedBy(1)
        }
        
        lottoNumberLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
