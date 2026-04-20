//
//  TapViewCell.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/20.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class TapViewCell: UITableViewCell {
    
    private let disposeBag = DisposeBag()
    
    var tapBlock: ((String) -> Void)?
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.init(hex: "#000000")
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return nameLabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hex: "#F6F7F9")
        bgView.layer.cornerRadius = 24
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    lazy var ocImageView: UIImageView = {
        let ocImageView = UIImageView()
        ocImageView.image = UIImage(named: "cli_a_a_image")
        return ocImageView
    }()
    
    lazy var phoneTx: UITextField = {
        let phoneTx = UITextField()
        phoneTx.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        phoneTx.textColor = UIColor.init(hex: "#000000")
        let view = UIView(frame: CGRectMake(0, 0, 20, 1))
        phoneTx.leftView = view
        phoneTx.leftViewMode = .always
        return phoneTx
    }()
    
    lazy var tapBtn: UIButton = {
        let tapBtn = UIButton(type: .custom)
        return tapBtn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(nameLabel)
        contentView.addSubview(bgView)
        bgView.addSubview(ocImageView)
        bgView.addSubview(phoneTx)
        contentView.addSubview(tapBtn)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.height.equalTo(14)
        }
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        ocImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(20)
        }
        
        phoneTx.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.top.bottom.equalToSuperview()
            make.right.equalTo(ocImageView.snp.left).offset(-5)
        }
        
        tapBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tapBtn
            .rx
            .tap
            .throttle(.microseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                self?.tapBlock?(self?.phoneTx.text ?? "")
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
