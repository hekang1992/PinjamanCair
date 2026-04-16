//
//  HomeLIstView.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/16.
//

import UIKit
import SnapKit

class HomeLIstView: UIView {

    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.init(hex: "#39564C")
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return nameLabel
    }()
    
    lazy var numLabel: UILabel = {
        let numLabel = UILabel()
        numLabel.textColor = UIColor.init(hex: "#000000")
        numLabel.textAlignment = .left
        numLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return numLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameLabel)
        addSubview(numLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(16)
            make.left.equalToSuperview()
        }
        
        numLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(nameLabel.snp.right).offset(5)
            make.height.equalTo(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
