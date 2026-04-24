//
//  LoginViewController.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/16.
//

import UIKit
import SnapKit
import Combine

class LoginViewController: CommonViewController {
    
    private var countdownTimer: Timer?
    
    private var remainingSeconds: Int = 0
    
    private let viewModel = LoginViewModel()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "login_bg_image")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()
    
    lazy var loginView: LoginView = {
        let loginView = LoginView(frame: .zero)
        return loginView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(headView)
        headView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(42)
            make.left.right.equalToSuperview()
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
        
        loginView.loginBlock = { [weak self] type in
            guard let self else { return }
            switch type {
            case .ment:
                break
                
            case .sendcode:
                self.codeInfo()
                
            case .login:
                self.loginInfo()
            }
        }
        
        locationManager.getCurrentLocation { locationDict in }
        
        setupBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loginView.phoneTx.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopCountdown()
    }
    
    @MainActor
    deinit {
        stopCountdown()
    }
}

extension LoginViewController {
    
    private func codeInfo() {
        let phone = loginView.phoneTx.text ?? ""
        guard !phone.isEmpty else {
            ToastConfig.showMessage("Please enter your phone number".localized)
            return
        }
        let parameters = ["self": phone]
        viewModel.codeInfo(parameters: parameters)
    }
    
    private func startCountdown(seconds: Int = 60) {
        stopCountdown()
        
        remainingSeconds = seconds
        updateSendCodeButtonState()
        
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            
            if self.remainingSeconds > 0 {
                self.remainingSeconds -= 1
                self.updateSendCodeButtonState()
            } else {
                self.stopCountdown()
            }
        }
    }
    
    private func stopCountdown() {
        countdownTimer?.invalidate()
        countdownTimer = nil
        remainingSeconds = 0
        updateSendCodeButtonState()
    }
    
    private func updateSendCodeButtonState() {
        
        if remainingSeconds > 0 {
            loginView.sendCodeBtn.isEnabled = false
            loginView.sendCodeBtn.setTitle("\(remainingSeconds)s", for: .normal)
        } else {
            loginView.sendCodeBtn.isEnabled = true
            loginView.sendCodeBtn.setTitle("Get code".localized, for: .normal)
        }
    }
    
    private func loginInfo() {
        let phone = loginView.phoneTx.text ?? ""
        let code = loginView.codeTx.text ?? ""
        guard !phone.isEmpty else {
            ToastConfig.showMessage("Please enter your phone number".localized)
            return
        }
        guard !code.isEmpty else {
            ToastConfig.showMessage("Please enter the verification code".localized)
            return
        }
        guard loginView.siuBtn.isSelected else {
            ToastConfig.showMessage("Please read and agree to the Privacy Policy".localized)
            return
        }
        let parameters = ["heroic": phone, "unseen": code]
        viewModel.loginInfo(parameters: parameters)
        
    }
    
    
}

extension LoginViewController {
    
    private func setupBindings() {
        
        viewModel
            .$codeModel
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] model in
                guard let self = self else { return }
                let remains = model.remains ?? ""
                if remains == "0" {
                    startCountdown(seconds: 60)
                }
                ToastConfig.showMessage(model.judgment ?? "")
            }
            .store(in: &cancellables)
        
        viewModel
            .$loginModel
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { model in
                ToastConfig.showMessage(model.judgment ?? "")
                let remains = model.remains ?? ""
                if remains == "0" {
                    let phone = model.meantime?.heroic ?? ""
                    let token = model.meantime?.safe ?? ""
                    UserSessionManager.save(phone: phone, token: token)
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
}
