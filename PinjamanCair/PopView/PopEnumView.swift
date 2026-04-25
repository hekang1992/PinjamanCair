//
//  PopEnumView.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/20.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PopEnumView: UIView {
    
    var modelArray: [speedModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var selectedString: String? {
        didSet {
            if let str = selectedString, let models = modelArray {
                for (index, model) in models.enumerated() {
                    if model.alive == str {
                        selectedIndexPath = IndexPath(row: index, section: 0)
                        tableView.reloadData()
                        break
                    }
                }
            }
        }
    }
    
    var saveBlock: ((speedModel?) -> Void)?
    
    var closeBlock: (() -> Void)?
    
    private let disposeBag = DisposeBag()
    
    private var selectedIndexPath: IndexPath?
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "enc_ad_image")
        oneImageView.isUserInteractionEnabled = true
        return oneImageView
    }()
    
    lazy var confirmBtn: UIButton = {
        let confirmBtn = UIButton(type: .custom)
        confirmBtn.setBackgroundImage(UIImage(named: "log_in_bg_image".localized), for: .normal)
        confirmBtn.setTitle("Confirm".localized, for: .normal)
        confirmBtn.setTitleColor(.white, for: .normal)
        confirmBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return confirmBtn
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor(hex: "#000000")
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return nameLabel
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 46
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(CustomEnumCell.self, forCellReuseIdentifier: "CustomEnumCell")
        return tableView
    }()
    
    lazy var tapBtn: UIButton = {
        let tapBtn = UIButton(type: .custom)
        tapBtn.setImage(UIImage(named: "fock_bg_image"), for: .normal)
        tapBtn.adjustsImageWhenHighlighted = false
        return tapBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        bindEvents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(oneImageView)
        oneImageView.addSubview(confirmBtn)
        oneImageView.addSubview(nameLabel)
        oneImageView.addSubview(tableView)
        addSubview(tapBtn)
        
        oneImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 351, height: 507))
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(24)
            make.top.equalToSuperview().offset(133)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(confirmBtn.snp.top).offset(-5)
        }
        
        confirmBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 330, height: 71))
        }
        
        tapBtn.snp.makeConstraints { make in
            make.top.equalTo(oneImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 32, height: 32))
        }
    }
    
    private func bindEvents() {
        confirmBtn
            .rx
            .tap
            .throttle(.microseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                let selectedModel = self?.getSelectedModel()
                if selectedModel == nil {
                    ToastConfig.showMessage("Please choose one".localized)
                    return
                }
                self?.saveBlock?(selectedModel)
            })
            .disposed(by: disposeBag)
        
        tapBtn
            .rx
            .tap
            .throttle(.microseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                self?.closeBlock?()
            })
            .disposed(by: disposeBag)
        
    }
    
    private func getSelectedModel() -> speedModel? {
        guard let indexPath = selectedIndexPath,
              let model = modelArray?[indexPath.row] else {
            return nil
        }
        return model
    }
}

extension PopEnumView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomEnumCell", for: indexPath) as? CustomEnumCell else {
            return UITableViewCell()
        }
        
        let model = modelArray?[indexPath.row]
        let title = model?.alive ?? ""
        let isSelected = (selectedIndexPath == indexPath)
        
        cell.configure(title: title, isSelected: isSelected)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let previousIndexPath = selectedIndexPath,
           let previousCell = tableView.cellForRow(at: previousIndexPath) as? CustomEnumCell {
            previousCell.setSelected(false)
        }
        
        selectedIndexPath = indexPath
        if let currentCell = tableView.cellForRow(at: indexPath) as? CustomEnumCell {
            currentCell.setSelected(true)
        }
    }
}

class CustomEnumCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#333333")
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        
        containerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
            make.height.greaterThanOrEqualTo(48)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(12)
        }
    }
    
    func configure(title: String, isSelected: Bool) {
        titleLabel.text = title
        
        if isSelected {
            containerView.backgroundColor = UIColor(hex: "#8BC3AB")
            titleLabel.textColor = .white
            titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        } else {
            containerView.backgroundColor = UIColor.init(hex: "#F7F8F8")
            titleLabel.textColor = UIColor(hex: "#333333")
            titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        }
    }
    
    func setSelected(_ selected: Bool) {
        if selected {
            containerView.backgroundColor = UIColor(hex: "#8BC3AB")
            titleLabel.textColor = .white
            titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        } else {
            containerView.backgroundColor = UIColor.init(hex: "#F7F8F8")
            titleLabel.textColor = UIColor(hex: "#333333")
            titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        }
    }
    
}

