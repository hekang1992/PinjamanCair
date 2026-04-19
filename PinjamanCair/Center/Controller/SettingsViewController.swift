//
//  SettingsViewController.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/18.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import TYAlertController
import Combine

class SettingsViewController: CommonViewController {
    
    private let viewModel = AccountViewModel()
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "cen_bg_image")
        headImageView.contentMode = .scaleAspectFill
        return headImageView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hex: "#FFFFFF")
        bgView.layer.cornerRadius = 14
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(headImageView)
        headImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(482)
        }
        
        view.addSubview(headView)
        headView.configTitle("Settings".localized)
        headView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(42)
            make.left.right.equalToSuperview()
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
        
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
        
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "login_logo_image")
        
        bgView.addSubview(oneImageView)
        oneImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(32)
            make.width.height.equalTo(80)
        }
        
        let nameLabel = UILabel()
        nameLabel.text = "Pinjaman Cair"
        nameLabel.textColor = UIColor.init(hex: "#247255")
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .black)
        bgView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(oneImageView.snp.bottom).offset(16)
            make.height.equalTo(22)
        }
        
        
        let oneView = UIView(frame: .zero)
        oneView.layer.cornerRadius = 8
        oneView.layer.masksToBounds = true
        oneView.backgroundColor = UIColor.init(hex: "#F7F8F8")
        
        bgView.addSubview(oneView)
        oneView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
        }
        
        let oneLabel = UILabel()
        oneLabel.text = "Version".localized
        oneLabel.textColor = UIColor.init(hex: "#000900")
        oneLabel.textAlignment = .left
        oneLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        let twoLabel = UILabel()
        twoLabel.text = "1.0.0".localized
        twoLabel.textColor = UIColor.init(hex: "#000900")
        twoLabel.textAlignment = .left
        twoLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        oneView.addSubview(oneLabel)
        oneLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(22)
        }
        
        oneView.addSubview(twoLabel)
        twoLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(22)
        }
        
        let twoView = UIView(frame: .zero)
        twoView.layer.cornerRadius = 8
        twoView.layer.masksToBounds = true
        twoView.backgroundColor = UIColor.init(hex: "#F7F8F8")
        
        bgView.addSubview(twoView)
        twoView.snp.makeConstraints { make in
            make.top.equalTo(oneView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
        }
        
        let logoutLabel = UILabel()
        logoutLabel.text = "Log out".localized
        logoutLabel.textColor = UIColor.init(hex: "#000900")
        logoutLabel.textAlignment = .left
        logoutLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        twoView.addSubview(logoutLabel)
        logoutLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(22)
        }
        
        let tapBtn = UIButton(type: .custom)
        twoView.addSubview(tapBtn)
        tapBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tapBtn
            .rx
            .tap
            .throttle(.milliseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.logoutInfo()
            })
            .disposed(by: disposeBag)
        
        if LanguageManager.currentLanguage() == .english {
            let deleteBtn = UIButton(type: .custom)
            deleteBtn.setTitle("Account cancellation", for: .normal)
            deleteBtn.setTitleColor(UIColor.init(hex: "#979D97"), for: .normal)
            deleteBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            view.addSubview(deleteBtn)
            
            deleteBtn.snp.makeConstraints { make in
                make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
                make.centerX.equalToSuperview()
                make.height.equalTo(20)
            }
            
            deleteBtn
                .rx
                .tap
                .bind(onNext: { [weak self] in
                    self?.deleteInfo()
                })
                .disposed(by: disposeBag)
            
        }
        
        setBindViewModel()
        
    }
    
}

extension SettingsViewController {
    
    private func setBindViewModel() {
        viewModel
            .$accountModel
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] model in
                guard let self = self else { return }
                let remains = model.remains ?? ""
                ToastConfig.showMessage(model.judgment ?? "")
                if remains == "0" {
                    self.dismiss(animated: true)
                    UserSessionManager.clearAll()
                    NotificationCenter.default.post(name: .changeRootViewController, object: nil)
                    
                }
            }
            .store(in: &cancellables)
        
        viewModel
            .$errorMsg
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { errorMsg in
                ToastConfig.showMessage("Network error".localized)
            }
            .store(in: &cancellables)
    }
    
    private func logoutInfo() {
        let popView = PopLogView(frame: self.view.bounds)
        let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        
        popView.oneBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        popView.twoBlock = { [weak self] in
            guard let self = self else { return }
            viewModel.outInfo()
        }
    }
    
    private func deleteInfo() {
        let popView = PopDeleteView(frame: self.view.bounds)
        let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        
        popView.oneBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        popView.twoBlock = { [weak self] in
            guard let self = self else { return }
            let status = popView.siuBtn.isSelected
            
            if status == false {
                ToastConfig.showMessage("Please read and agree to the above content")
                return
            }
            viewModel.deleteInfo()
        }
    }
    
}
