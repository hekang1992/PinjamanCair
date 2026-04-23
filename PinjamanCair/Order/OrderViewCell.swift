//
//  OrderViewCell.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/23.
//

import UIKit
import SnapKit
import Kingfisher

class OrderViewCell: UITableViewCell {
    
    var model: visualModel? {
        didSet {
            guard let model = model else { return }
            let logoUrl = model.pitch ?? ""
            logoImageView.kf.setImage(with: URL(string: logoUrl))
            nameLabel.text = model.pine ?? ""
            typreLabel.text = model.months ?? ""
            oneLabel.text = model.wood ?? ""
            twoLabel.text = model.stayed ?? ""
            let keep = model.keep ?? ""
            let edge = model.edge ?? ""
            threeLabel.text = String(format: "%@ : %@", keep, edge)
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hex: "#F7F8F8")
        bgView.layer.cornerRadius = 8
        bgView.layer.masksToBounds = true
        return bgView
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

    lazy var typreLabel: UILabel = {
        let typreLabel = UILabel()
        typreLabel.textColor = UIColor.init(hex: "#247255")
        typreLabel.textAlignment = .right
        typreLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return typreLabel
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textColor = UIColor.init(hex: "#000000")
        oneLabel.textAlignment = .left
        oneLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return oneLabel
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textColor = UIColor.init(hex: "#000000")
        twoLabel.textAlignment = .left
        twoLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return twoLabel
    }()
    
    lazy var threeLabel: UILabel = {
        let threeLabel = UILabel()
        threeLabel.textColor = UIColor.init(hex: "#000000")
        threeLabel.textAlignment = .left
        threeLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return threeLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgView)
        bgView.addSubview(logoImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(typreLabel)
        bgView.addSubview(oneLabel)
        bgView.addSubview(twoLabel)
        bgView.addSubview(threeLabel)
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343, height: 134))
            make.bottom.equalToSuperview().offset(-12)
        }
        logoImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(12)
            make.width.height.equalTo(24)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.left.equalTo(logoImageView.snp.right).offset(5)
            make.height.equalTo(20)
        }
        typreLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(20)
        }
        
        oneLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(14)
        }
        twoLabel.snp.makeConstraints { make in
            make.top.equalTo(oneLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(24)
        }
        threeLabel.snp.makeConstraints { make in
            make.top.equalTo(twoLabel.snp.bottom).offset(14)
            make.left.equalTo(oneLabel)
            make.height.equalTo(15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
