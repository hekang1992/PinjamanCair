//
//  ProductListView.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/20.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ProductListView: UIView {
    
    private let disposeBag = DisposeBag()
    
    var model: proceedingModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.likely ?? ""
            let widowed = model.widowed ?? 0
            if widowed == 1 {
                typeLabel.isHidden = true
                typeImageView.isHidden = false
            }else {
                typeLabel.isHidden = false
                typeImageView.isHidden = true
            }
        }
    }
    
    var tapBlock: ((proceedingModel) -> Void)?
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "item_bg_image")
        return oneImageView
    }()
    
    lazy var unmLabel: UILabel = {
        let unmLabel = UILabel()
        unmLabel.textColor = UIColor.init(hex: "#C6C6C6")
        unmLabel.textAlignment = .left
        unmLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return unmLabel
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.init(hex: "#000000")
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return nameLabel
    }()
    
    lazy var typeLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.textColor = UIColor.init(hex: "#FFFFFF")
        typeLabel.textAlignment = .center
        typeLabel.text = "GO"
        typeLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        typeLabel.layer.cornerRadius = 4
        typeLabel.layer.masksToBounds = true
        typeLabel.backgroundColor = UIColor.init(hex: "#8BC3AB")
        return typeLabel
    }()
    
    lazy var typeImageView: UIImageView = {
        let typeImageView = UIImageView()
        typeImageView.image = UIImage(named: "ad_go_image")
        typeImageView.isHidden = true
        return typeImageView
    }()
    
    lazy var tapBtn: UIButton = {
        let tapBtn = UIButton(type: .custom)
        return tapBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(oneImageView)
        oneImageView.addSubview(unmLabel)
        oneImageView.addSubview(nameLabel)
        oneImageView.addSubview(typeLabel)
        oneImageView.addSubview(typeImageView)
        addSubview(tapBtn)
        oneImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 343, height: 77))
        }
        
        unmLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(20)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(unmLabel.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        
        typeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.width.height.equalTo(28)
        }
        
        typeImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.width.height.equalTo(28)
        }
        
        tapBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tapBtn
            .rx
            .tap
            .throttle(.milliseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self, let model else { return }
                self.tapBlock?(model)
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
