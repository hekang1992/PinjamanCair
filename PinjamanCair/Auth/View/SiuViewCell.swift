//
//  SiuViewCell.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/20.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SiuViewCell: UITableViewCell {
    
    var model: scatteredModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.likely ?? ""
            phoneTx.placeholder = model.birch ?? ""
            phoneTx.text = model.trunk ?? ""
        }
    }
    
    private let disposeBag = DisposeBag()
    
    var enterText: ((String) -> Void)?
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#000000")
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#F6F7F9")
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var phoneTx: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        textField.textColor = UIColor(hex: "#000000")
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 1))
        textField.leftView = view
        textField.leftViewMode = .always
        return textField
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupRx()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(bgView)
        bgView.addSubview(phoneTx)
        
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
        
        phoneTx.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupRx() {
        phoneTx.rx.text.orEmpty
            .subscribe(onNext: { [weak self] text in
                self?.enterText?(text)
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
