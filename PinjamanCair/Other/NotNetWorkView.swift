//
//  NotNetWorkView.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/28.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class NotNetWorkView: UIView {
    
    private let disposeBag = DisposeBag()
    
    var tapBlock: (() -> Void)?
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "not_net_image")
        return oneImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "No network"
        nameLabel.textColor = UIColor.init(hex: "#000000")
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return nameLabel
    }()
    
    lazy var tapBtn: UIButton = {
        let tapBtn = UIButton(type: .custom)
        tapBtn.setBackgroundImage(UIImage(named: "em_icm_image"), for: .normal)
        tapBtn.setTitleColor(.white, for: .normal)
        tapBtn.setTitle("Retry", for: .normal)
        tapBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return tapBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(oneImageView)
        addSubview(nameLabel)
        addSubview(tapBtn)
        
        oneImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 260, height: 190))
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(oneImageView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 17))
        }
        
        tapBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 162, height: 63))
        }
        
        tapBtn
            .rx
            .tap
            .throttle(.milliseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.tapBlock?()
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
