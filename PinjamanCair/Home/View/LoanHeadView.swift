//
//  LoanHeadView.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/16.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

class LoanHeadView: UIView {
    
    private let disposeBag = DisposeBag()
    
    var applyBlock: ((String) -> Void)?
    
    var interveningModel: interveningModel? {
        didSet {
            guard let interveningModel = interveningModel else { return }
            
            applyLabel.text = interveningModel.months ?? ""
            
            let logoUrl = interveningModel.pitch ?? ""
            logoImageView.kf.setImage(with: URL(string: logoUrl))
            nameLabel.text = interveningModel.pine ?? ""
            descLabel.text = interveningModel.mount ?? ""
            moneyLabel.text = interveningModel.enigma ?? ""
        }
    }
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "home_card_image")
        return oneImageView
    }()
    
    lazy var twoImageView: UIImageView = {
        let twoImageView = UIImageView()
        twoImageView.image = UIImage(named: "home_ct_image")
        return twoImageView
    }()
    
    lazy var applyImageView: UIImageView = {
        let applyImageView = UIImageView()
        applyImageView.image = UIImage(named: "apply_btn_image")
        return applyImageView
    }()
    
    lazy var applyLabel: UILabel = {
        let applyLabel = UILabel()
        applyLabel.textColor = UIColor.init(hex: "#247255")
        applyLabel.textAlignment = .center
        applyLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return applyLabel
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
        moneyLabel.textColor = UIColor.init(hex: "#247255")
        moneyLabel.textAlignment = .left
        moneyLabel.font = UIFont.systemFont(ofSize: 46, weight: .black)
        return moneyLabel
    }()
    
    lazy var tapBtn: UIButton = {
        let tapBtn = UIButton(type: .custom)
        return tapBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(twoImageView)
        addSubview(oneImageView)
        addSubview(applyImageView)
        applyImageView.addSubview(applyLabel)
        oneImageView.addSubview(logoImageView)
        oneImageView.addSubview(nameLabel)
        oneImageView.addSubview(descLabel)
        oneImageView.addSubview(moneyLabel)
        addSubview(tapBtn)
        
        twoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(115)
            make.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 198, height: 198))
        }
        
        oneImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343, height: 155))
        }
        
        applyImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(oneImageView.snp.bottom).offset(32)
            make.size.equalTo(CGSize(width: 335, height: 60))
        }
        applyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.right.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(32)
            make.width.height.equalTo(32)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.left.equalTo(logoImageView.snp.right).offset(5)
            make.height.equalTo(20)
        }
        
        descLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView)
            make.top.equalTo(logoImageView.snp.bottom).offset(16)
            make.height.equalTo(15)
        }
        
        moneyLabel.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(4)
            make.left.equalTo(logoImageView)
            make.height.equalTo(56)
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
