//
//  ContactTableViewCell.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/21.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ContactTableViewCell: UITableViewCell {
    
    var model: intrudingModel? {
        didSet {
            guard let model = model else { return }
            oneLabel.text = model.likely ?? ""
            nameLabel.text = model.action ?? ""
            phoneTx.placeholder = model.flew ?? ""
            
            nameLabel1.text = model.arrival ?? ""
            phoneTx1.placeholder = model.wait ?? ""
        }
    }
    
    private let disposeBag = DisposeBag()
    
    var tapBlock: ((String) -> Void)?
    
    var tap1Block: (() -> Void)?
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textColor = UIColor.init(hex: "#000000")
        oneLabel.textAlignment = .center
        oneLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return oneLabel
    }()
    
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
    
    lazy var nameLabel1: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.init(hex: "#000000")
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return nameLabel
    }()
    
    lazy var bgView1: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hex: "#F6F7F9")
        bgView.layer.cornerRadius = 24
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    lazy var ocImageView1: UIImageView = {
        let ocImageView = UIImageView()
        ocImageView.image = UIImage(named: "tim_c_image")
        return ocImageView
    }()
    
    lazy var phoneTx1: UITextField = {
        let phoneTx = UITextField()
        phoneTx.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        phoneTx.textColor = UIColor.init(hex: "#000000")
        let view = UIView(frame: CGRectMake(0, 0, 20, 1))
        phoneTx.leftView = view
        phoneTx.leftViewMode = .always
        return phoneTx
    }()
    
    lazy var tapBtn1: UIButton = {
        let tapBtn = UIButton(type: .custom)
        return tapBtn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(oneLabel)
        oneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(18)
        }
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(bgView)
        bgView.addSubview(ocImageView)
        bgView.addSubview(phoneTx)
        contentView.addSubview(tapBtn)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(oneLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(14)
        }
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.height.equalTo(48)
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
        
        contentView.addSubview(nameLabel1)
        contentView.addSubview(bgView1)
        bgView1.addSubview(ocImageView1)
        bgView1.addSubview(phoneTx1)
        contentView.addSubview(tapBtn1)
        
        nameLabel1.snp.makeConstraints { make in
            make.top.equalTo(bgView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(14)
        }
        bgView1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(nameLabel1)
            make.top.equalTo(nameLabel1.snp.bottom).offset(12)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        ocImageView1.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(20)
        }
        
        phoneTx1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.top.bottom.equalToSuperview()
            make.right.equalTo(ocImageView1.snp.left).offset(-5)
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
        
        tapBtn1
            .rx
            .tap
            .throttle(.microseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                self?.tap1Block?()
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
