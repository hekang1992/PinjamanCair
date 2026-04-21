//
//  PopNameView.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/20.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PopNameView: UIView {
    
    var modelArray: [warblerModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var saveBlock: (() -> Void)?
    
    var tapBlock: ((String, TapViewCell) -> Void)?
    
    private let disposeBag = DisposeBag()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "com_ac_bg_image")
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
        nameLabel.textColor = UIColor.init(hex: "#000000")
        nameLabel.textAlignment = .center
        nameLabel.text = "Information Confirmation".localized
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return nameLabel
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 46
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(SiuViewCell.self, forCellReuseIdentifier: "SiuViewCell")
        tableView.register(TapViewCell.self, forCellReuseIdentifier: "TapViewCell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(oneImageView)
        oneImageView.addSubview(confirmBtn)
        oneImageView.addSubview(nameLabel)
        oneImageView.addSubview(tableView)
        
        oneImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 351, height: 527))
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
        
        confirmBtn
            .rx
            .tap
            .throttle(.microseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                self?.saveBlock?()
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PopNameView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let model = self.modelArray?[index]
        if index == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TapViewCell", for: indexPath) as! TapViewCell
            cell.nameLabel.text = model?.whence ?? ""
            cell.phoneTx.placeholder = model?.whence ?? ""
            cell.phoneTx.text = model?.provokingly ?? ""
            self.endEditing(true)
            cell.tapBlock = { [weak self] name in
                self?.tapBlock?(name, cell)
            }
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SiuViewCell", for: indexPath) as! SiuViewCell
            cell.nameLabel.text = model?.whence ?? ""
            cell.phoneTx.placeholder = model?.whence ?? ""
            cell.phoneTx.text = model?.provokingly ?? ""
            cell.enterText = { [weak self] text in
                guard let self = self else { return }
                model?.provokingly = text
            }
            return cell
        }
        
    }
    
}
