//
//  HomeCardView.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/16.
//

import UIKit
import SnapKit

class HomeCardView: UIView {
    
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
        oneListView.backgroundColor = .red
        return oneListView
    }()
    
    lazy var twoListView: HomeLIstView = {
        let twoListView = HomeLIstView()
        twoListView.backgroundColor = .red
        return twoListView
    }()
    
    lazy var threeListView: HomeLIstView = {
        let threeListView = HomeLIstView()
        threeListView.backgroundColor = .red
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(twoImageView)
        addSubview(oneImageView)
        addSubview(oneListView)
        addSubview(twoListView)
        addSubview(threeListView)
        addSubview(applyImageView)
        applyImageView.addSubview(applyLabel)
        
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
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
