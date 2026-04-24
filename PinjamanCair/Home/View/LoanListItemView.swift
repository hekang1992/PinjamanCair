//
//  LoanListItemView.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/24.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

class LoanListItemView: UIView {
    
    var applyBlock: ((String) -> Void)?
    
    private let disposeBag = DisposeBag()
    
    var interveningModel: interveningModel? {
        didSet {
            guard let interveningModel = interveningModel else { return }
            
            let logoUrl = interveningModel.pitch ?? ""
            logoImageView.kf.setImage(with: URL(string: logoUrl))
            nameLabel.text = interveningModel.pine ?? ""
            descLabel.text = interveningModel.mount ?? ""
            moneyLabel.text = interveningModel.enigma ?? ""
            
            typeLabel.text = interveningModel.months ?? ""
        }
    }
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "wo_bg_image")
        return oneImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.cornerRadius = 5
        logoImageView.layer.masksToBounds = true
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.init(hex: "#000000")
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return nameLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textColor = UIColor.init(hex: "#000000").withAlphaComponent(0.3)
        descLabel.textAlignment = .left
        descLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return descLabel
    }()
    
    lazy var moneyLabel: UILabel = {
        let moneyLabel = UILabel()
        moneyLabel.textColor = UIColor.init(hex: "#000000")
        moneyLabel.textAlignment = .left
        moneyLabel.font = UIFont.systemFont(ofSize: 24, weight: .black)
        return moneyLabel
    }()
    
    lazy var typeImageView: UIImageView = {
        let typeImageView = UIImageView()
        typeImageView.image = UIImage(named: "tc_im_imager")
        return typeImageView
    }()
    
    lazy var typeLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.textColor = UIColor.init(hex: "#FFFFFF")
        typeLabel.textAlignment = .center
        typeLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return typeLabel
    }()
    
    lazy var tapBtn: UIButton = {
        let tapBtn = UIButton(type: .custom)
        return tapBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(oneImageView)
        
        oneImageView.addSubview(logoImageView)
        oneImageView.addSubview(nameLabel)
        oneImageView.addSubview(descLabel)
        oneImageView.addSubview(moneyLabel)
        oneImageView.addSubview(typeImageView)
        typeImageView.addSubview(typeLabel)
        addSubview(tapBtn)
        
        oneImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(32)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.left.equalTo(logoImageView.snp.right).offset(5)
            make.height.equalTo(20)
        }
        
        descLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView)
            make.top.equalTo(logoImageView.snp.bottom).offset(12)
            make.height.equalTo(15)
        }
        
        moneyLabel.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(5)
            make.left.equalTo(logoImageView)
            make.height.equalTo(24)
        }
        
        typeImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-18)
            make.bottom.equalToSuperview().offset(-16)
            make.size.equalTo(CGSize(width: 126, height: 42))
        }
        
        typeLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tapBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tapBtn
            .rx
            .tap
            .throttle(.milliseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self, let interveningModel else { return }
                let productID = interveningModel.grove ?? ""
                self.applyBlock?(productID)
            })
            .disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
