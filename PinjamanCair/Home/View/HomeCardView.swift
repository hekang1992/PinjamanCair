//
//  HomeCardView.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/16.
//

import UIKit
import SnapKit
import Kingfisher

class HomeCardView: UIView {
    
    var interveningModel: interveningModel? {
        didSet {
            guard let interveningModel = interveningModel else { return }
            oneListView.nameLabel.text = "\(interveningModel.picket ?? "") :"
            oneListView.numLabel.text = interveningModel.choice ?? ""
            
            twoListView.nameLabel.text = "\(interveningModel.ifo ?? "") :"
            twoListView.numLabel.text = interveningModel.between ?? ""
            
            threeListView.nameLabel.text = "It will arrive in".localized
            threeListView.numLabel.text = " 3 minutes".localized
            
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
    
    lazy var oneListView: HomeLIstView = {
        let oneListView = HomeLIstView()
        return oneListView
    }()
    
    lazy var twoListView: HomeLIstView = {
        let twoListView = HomeLIstView()
        return twoListView
    }()
    
    lazy var threeListView: HomeLIstView = {
        let threeListView = HomeLIstView()
        return threeListView
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(twoImageView)
        addSubview(oneImageView)
        addSubview(oneListView)
        addSubview(twoListView)
        addSubview(threeListView)
        addSubview(applyImageView)
        applyImageView.addSubview(applyLabel)
        oneImageView.addSubview(logoImageView)
        oneImageView.addSubview(nameLabel)
        oneImageView.addSubview(descLabel)
        oneImageView.addSubview(moneyLabel)
        
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
        
        oneListView.snp.makeConstraints { make in
            make.top.equalTo(oneImageView.snp.bottom).offset(32)
            make.left.equalTo(oneImageView)
            make.height.equalTo(16)
            make.width.greaterThanOrEqualToSuperview()
        }
        
        twoListView.snp.makeConstraints { make in
            make.top.equalTo(oneListView.snp.bottom).offset(14)
            make.left.equalTo(oneImageView)
            make.height.equalTo(16)
            make.width.greaterThanOrEqualToSuperview()
        }
        
        threeListView.snp.makeConstraints { make in
            make.top.equalTo(twoListView.snp.bottom).offset(14)
            make.left.equalTo(oneImageView)
            make.height.equalTo(16)
            make.width.greaterThanOrEqualToSuperview()
        }
        
        applyImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(threeListView.snp.bottom).offset(32)
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
