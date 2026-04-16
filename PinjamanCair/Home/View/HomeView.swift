//
//  HomeView.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/16.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class HomeView: UIView {
    
    var tabBarHeight: CGFloat {
        let bottomSafeArea = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        return 49 + bottomSafeArea
    }
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .clear
        return contentView
    }()
    
    lazy var cardView: HomeCardView = {
        let cardView = HomeCardView(frame: .zero)
        return cardView
    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 12
        whiteView.layer.masksToBounds = true
        whiteView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return whiteView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        oneBtn.setImage(UIImage(named: "pc_as_image"), for: .normal)
        oneBtn.adjustsImageWhenHighlighted = false
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.setImage(UIImage(named: "pc_ast_image"), for: .normal)
        twoBtn.adjustsImageWhenHighlighted = false
        return twoBtn
    }()
    
    lazy var threeBtn: UIButton = {
        let threeBtn = UIButton(type: .custom)
        threeBtn.setImage(UIImage(named: "pc_asf_image"), for: .normal)
        threeBtn.adjustsImageWhenHighlighted = false
        return threeBtn
    }()
    
    lazy var fourBtn: UIButton = {
        let fourBtn = UIButton(type: .custom)
        fourBtn.setImage(UIImage(named: "pc_adt_image"), for: .normal)
        fourBtn.adjustsImageWhenHighlighted = false
        return fourBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        
        contentView.addSubview(cardView)
        contentView.addSubview(whiteView)
        
        cardView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(370)
        }
        
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(cardView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(1000)
        }
        
        if LanguageManager.currentLanguage() == .english {
            contentView.addSubview(oneBtn)
            contentView.addSubview(twoBtn)
            contentView.addSubview(threeBtn)
            
            oneBtn.snp.makeConstraints { make in
                make.top.equalTo(whiteView).offset(16)
                make.centerX.equalToSuperview()
                make.size.equalTo(CGSize(width: 343, height: 39))
            }
            
            twoBtn.snp.makeConstraints { make in
                make.top.equalTo(oneBtn.snp.bottom).offset(16)
                make.centerX.equalToSuperview()
                make.size.equalTo(CGSize(width: 343, height: 201))
            }
            
            threeBtn.snp.makeConstraints { make in
                make.top.equalTo(twoBtn.snp.bottom).offset(16)
                make.centerX.equalToSuperview()
                make.size.equalTo(CGSize(width: 343, height: 283))
                make.bottom.equalToSuperview().offset(-(tabBarHeight + 10))
            }
        }else {
            contentView.addSubview(fourBtn)
            fourBtn.snp.makeConstraints { make in
                make.top.equalTo(whiteView).offset(16)
                make.centerX.equalToSuperview()
                make.size.equalTo(CGSize(width: 343, height: 201))
                make.bottom.equalToSuperview().offset(-(tabBarHeight + 10))
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
