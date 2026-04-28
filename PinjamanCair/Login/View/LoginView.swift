//
//  LoginView.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/16.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

enum LoginClickType {
    case login
    case sendcode
    case ment
    case voice
}

class LoginView: UIView {
    
    var loginBlock: ((LoginClickType) -> Void)?
    
    private let disposeBag = DisposeBag()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "login_ex_image")
        oneImageView.isUserInteractionEnabled = true
        return oneImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "login_logo_image")
        return logoImageView
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textColor = UIColor.init(hex: "#050505")
        oneLabel.textAlignment = .left
        oneLabel.text = "Login mobile number".localized
        oneLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return oneLabel
    }()
    
    lazy var oneView: UIView = {
        let oneView = UIView()
        oneView.backgroundColor = .white
        oneView.layer.cornerRadius = 26
        oneView.layer.masksToBounds = true
        return oneView
    }()
    
    lazy var numLabel: UILabel = {
        let numLabel = UILabel()
        numLabel.text = "+91".localized
        numLabel.textColor = UIColor.init(hex: "#050505")
        numLabel.textAlignment = .center
        numLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return numLabel
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.init(hex: "#A7A8B2")
        return lineView
    }()
    
    lazy var phoneTx: UITextField = {
        let phoneTx = UITextField()
        phoneTx.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: "Mobile phone number", attributes: [
            .foregroundColor: UIColor.init(hex: "#A7A8B2") as Any,
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ])
        phoneTx.attributedPlaceholder = attrString
        phoneTx.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        phoneTx.textColor = UIColor.init(hex: "#000000")
        return phoneTx
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textColor = UIColor.init(hex: "#050505")
        twoLabel.textAlignment = .left
        twoLabel.text = "Verification code".localized
        twoLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return twoLabel
    }()
    
    lazy var twoView: UIView = {
        let twoView = UIView()
        twoView.backgroundColor = .white
        twoView.layer.cornerRadius = 26
        twoView.layer.masksToBounds = true
        return twoView
    }()
    
    lazy var codeTx: UITextField = {
        let codeTx = UITextField()
        codeTx.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: "Verification code", attributes: [
            .foregroundColor: UIColor.init(hex: "#A7A8B2") as Any,
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ])
        codeTx.attributedPlaceholder = attrString
        codeTx.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        codeTx.textColor = UIColor.init(hex: "#000000")
        return codeTx
    }()
    
    lazy var sendCodeBtn: UIButton = {
        let sendCodeBtn = UIButton(type: .custom)
        sendCodeBtn.setBackgroundImage(UIImage(named: "send_code_image"), for: .normal)
        sendCodeBtn.setTitleColor(.white, for: .normal)
        sendCodeBtn.setTitle("Get code".localized, for: .normal)
        sendCodeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return sendCodeBtn
    }()
    
    lazy var voiceBtn: UIButton = {
        let voiceBtn = UIButton(type: .custom)
        voiceBtn.setImage(UIImage(named: "vic_bg_image"), for: .normal)
        voiceBtn.adjustsImageWhenHighlighted = false
        return voiceBtn
    }()
    
    lazy var siuBtn: UIButton = {
        let siuBtn = UIButton(type: .custom)
        siuBtn.setImage(UIImage(named: "mc_nor_image"), for: .normal)
        siuBtn.setImage(UIImage(named: "mc_sel_image"), for: .selected)
        siuBtn.isSelected = true
        return siuBtn
    }()
    
    lazy var mcBtn: UIButton = {
        let mcBtn = UIButton(type: .custom)
        mcBtn.setImage(UIImage(named: "en_mc_image".localized), for: .normal)
        return mcBtn
    }()
    
    lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom)
        loginBtn.setBackgroundImage(UIImage(named: "log_in_bg_image".localized), for: .normal)
        loginBtn.setTitle("Log in".localized, for: .normal)
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return loginBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(oneImageView)
        oneImageView.addSubview(logoImageView)
        
        oneImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            make.size.equalTo(CGSize(width: 343, height: 530))
            make.bottom.equalToSuperview().offset(-20)
        }
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(26)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(90)
        }
        
        oneImageView.addSubview(oneLabel)
        oneImageView.addSubview(oneView)
        
        oneLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(16)
        }
        oneView.snp.makeConstraints { make in
            make.left.equalTo(oneLabel)
            make.top.equalTo(oneLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(52)
        }
        
        oneView.addSubview(numLabel)
        oneView.addSubview(lineView)
        oneView.addSubview(phoneTx)
        
        numLabel.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(44)
        }
        lineView.snp.makeConstraints { make in
            make.centerY.equalTo(numLabel)
            make.left.equalTo(numLabel.snp.right)
            make.size.equalTo(CGSize(width: 1, height: 12))
        }
        phoneTx.snp.makeConstraints { make in
            make.left.equalTo(lineView.snp.right).offset(8)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-5)
        }
        
        oneImageView.addSubview(twoLabel)
        oneImageView.addSubview(twoView)
        
        twoLabel.snp.makeConstraints { make in
            make.top.equalTo(oneView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(16)
        }
        twoView.snp.makeConstraints { make in
            make.left.equalTo(oneLabel)
            make.top.equalTo(twoLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(52)
        }
        
        twoView.addSubview(sendCodeBtn)
        twoView.addSubview(codeTx)
        
        sendCodeBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-5)
            make.size.equalTo(CGSize(width: 79, height: 40))
        }
        codeTx.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.right.equalTo(sendCodeBtn.snp.left).offset(-10)
        }
        
        oneImageView.addSubview(voiceBtn)
        voiceBtn.snp.makeConstraints { make in
            make.top.equalTo(twoView.snp.bottom).offset(16)
            make.right.equalTo(twoView)
            make.width.height.equalTo(40)
        }
        
        oneImageView.addSubview(siuBtn)
        oneImageView.addSubview(mcBtn)
        
        siuBtn.snp.makeConstraints { make in
            make.width.height.equalTo(15)
            make.left.equalToSuperview().offset(27)
            make.top.equalTo(voiceBtn.snp.bottom).offset(20)
        }
        
        mcBtn.snp.makeConstraints { make in
            make.left.equalTo(siuBtn.snp.right).offset(5)
            make.top.equalTo(siuBtn.snp.top)
            if LanguageManager.currentLanguage() == .english {
                make.size.equalTo(CGSize(width: 271, height: 16))
            }else {
                make.size.equalTo(CGSize(width: 223, height: 27))
            }
        }
        
        oneImageView.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mcBtn.snp.bottom).offset(13)
            make.size.equalTo(CGSize(width: 330, height: 71))
        }
        
        bindTap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LoginView {
    
    private func bindTap() {
        siuBtn
            .rx
            .tap
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.siuBtn.isSelected.toggle()
            })
            .disposed(by: disposeBag)
        
        sendCodeBtn
            .rx
            .tap
            .throttle(.milliseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.loginBlock?(.sendcode)
            })
            .disposed(by: disposeBag)
        
        loginBtn
            .rx
            .tap
            .throttle(.milliseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.loginBlock?(.login)
            })
            .disposed(by: disposeBag)
        
        mcBtn
            .rx
            .tap
            .throttle(.milliseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.loginBlock?(.ment)
            })
            .disposed(by: disposeBag)
        
        voiceBtn
            .rx
            .tap
            .throttle(.milliseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.loginBlock?(.voice)
            })
            .disposed(by: disposeBag)
    }
    
}
