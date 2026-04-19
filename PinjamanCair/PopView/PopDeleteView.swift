//
//  PopDeleteView.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/19.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PopDeleteView: UIView {
    
    private let disposeBag = DisposeBag()
    
    var oneBlock: (() -> Void)?
    
    var twoBlock: (() -> Void)?
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "can_en_image".localized)
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
    
    lazy var siuBtn: UIButton = {
        let siuBtn = UIButton(type: .custom)
        siuBtn.setImage(UIImage(named: "mc_nor_image"), for: .normal)
        siuBtn.setImage(UIImage(named: "mc_sel_image"), for: .selected)
        return siuBtn
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "I have read and agree to the above"
        nameLabel.textColor = UIColor.init(hex: "#000000")
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return nameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(oneImageView)
        oneImageView.addSubview(oneBtn)
        oneImageView.addSubview(twoBtn)
        oneImageView.addSubview(threeBtn)
        oneImageView.addSubview(siuBtn)
        oneImageView.addSubview(nameLabel)
        
        oneImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 351, height: 583))
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
        
        oneImageView.addSubview(siuBtn)
        oneImageView.addSubview(nameLabel)
        
        siuBtn.snp.makeConstraints { make in
            make.bottom.equalTo(threeBtn.snp.top).offset(-25)
            make.height.width.equalTo(12)
            make.left.equalToSuperview().offset(40)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(siuBtn)
            make.left.equalTo(siuBtn.snp.right).offset(8)
            make.height.equalTo(20)
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
        
        siuBtn.rx.tap.bind(onNext: { [weak self] in
            guard let self = self else { return }
            self.siuBtn.isSelected.toggle()
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
