//
//  AppHeadView.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/16.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class AppHeadView: UIView {
    
    private let disposeBag = DisposeBag()
    
    var backBlock: (() -> Void)?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .clear
        return bgView
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "logo_a_rp")
        return oneImageView
    }()
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setBackgroundImage(UIImage(named: "back_ic_image"), for: .normal)
        backBtn.adjustsImageWhenHighlighted = false
        return backBtn
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.init(hex: "#000000")
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return nameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(backBtn)
        bgView.addSubview(nameLabel)
        
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(21)
            make.width.height.equalTo(30)
            make.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(backBtn.snp.right).offset(16)
            make.height.equalTo(20)
        }
        
        backBtn
            .rx
            .tap
            .throttle(.milliseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.backBlock?()
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AppHeadView {
    
    func configTitle(_ title: String) {
        self.nameLabel.text = title
    }
    
}
