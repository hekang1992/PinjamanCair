//
//  PopLogView.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/19.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PopLogView: UIView {
    
    private let disposeBag = DisposeBag()
    
    var oneBlock: (() -> Void)?
    
    var twoBlock: (() -> Void)?
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "saf_en_image".localized)
        oneImageView.isUserInteractionEnabled = true
        return oneImageView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        return twoBtn
    }()
    
    lazy var threeBtn: UIButton = {
        let threeBtn = UIButton(type: .custom)
        return threeBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(oneImageView)
        oneImageView.addSubview(oneBtn)
        oneImageView.addSubview(twoBtn)
        oneImageView.addSubview(threeBtn)
        
        oneImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 351, height: 493))
        }
        
        oneBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 32, height: 32))
            make.centerX.equalToSuperview()
        }
        
        twoBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 327, height: 55))
            make.bottom.equalTo(oneBtn.snp.top).offset(-56)
        }
        
        threeBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 327, height: 55))
            make.bottom.equalTo(twoBtn.snp.top).offset(-16)
        }
        
        oneBtn.rx.tap.bind(onNext: { [weak self] in
            guard let self = self else { return }
            self.oneBlock?()
        }).disposed(by: disposeBag)
        
        threeBtn.rx.tap.bind(onNext: { [weak self] in
            guard let self = self else { return }
            self.oneBlock?()
        }).disposed(by: disposeBag)
        
        twoBtn.rx.tap.bind(onNext: { [weak self] in
            guard let self = self else { return }
            self.twoBlock?()
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
