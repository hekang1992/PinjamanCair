//
//  SplashViewController.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/15.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Combine
import FBSDKCoreKit
import IQKeyboardManagerSwift

class SplashViewController: CommonViewController {
    
    private let viewModel = SplashViewModel()
    private let networkMonitor = NetworkMonitor.shared
    private var hasInitApp = false
    
    lazy var againBtn: UIButton = {
        let againBtn = UIButton(type: .custom)
        againBtn.setBackgroundImage(UIImage(named: "try_again_image"), for: .normal)
        againBtn.adjustsImageWhenHighlighted = false
        againBtn.isHidden = true
        return againBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        setupBackgroundImage()
        monitorNetwork()
        setBindViewModel()
    }
    
    private func setupBackgroundImage() {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "launch_image")
        bgImageView.contentMode = .scaleAspectFill
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(againBtn)
        againBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            make.size.equalTo(CGSize(width: 160, height: 48))
        }
        
        againBtn
            .rx
            .tap
            .throttle(.milliseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.hasInitApp = false
                self.appInitInfo()
            })
            .disposed(by: disposeBag)
    }
    
}

extension SplashViewController {
    
    private func monitorNetwork() {
        networkMonitor.startListening { [weak self] status in
            guard let self = self else { return }
            print("status======\(status.description)")
            switch status {
            case .unknown:
                UserDefaults.standard.set("UNKNOWN", forKey: "app_network_key")
                
            case .notReachable:
                UserDefaults.standard.set("OTHER", forKey: "app_network_key")
                
            case .reachable(let type):
                switch type {
                case .ethernetOrWiFi:
                    UserDefaults.standard.set("WIFI", forKey: "app_network_key")
                    self.appInitInfo()
                    networkMonitor.stopListening()
                    
                case .cellular:
                    UserDefaults.standard.set("5G", forKey: "app_network_key")
                    self.appInitInfo()
                    networkMonitor.stopListening()
                }
            }
        }
        
    }
}

extension SplashViewController {
    
    private func appInitInfo() {
        guard !hasInitApp else { return }
        hasInitApp = true
        
        let parameters = SystemParamManager.allParameters
        
        viewModel.appInitInfo(parameters: parameters)
    }
    
    private func setBindViewModel() {
        viewModel
            .$splashModel
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] model in
                guard let self = self else { return }
                self.handleSplashModel(model)
            }
            .store(in: &cancellables)
        
        viewModel
            .$errorMsg
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] errorMsg in
                self?.againBtn.isHidden = false
            }
            .store(in: &cancellables)
    }
    
    private func handleSplashModel(_ model: BaseModel) {
        let remains = model.remains ?? ""
        if remains == "0" {
            self.againBtn.isHidden = true
            if let fkModel = model.meantime?.postpone {
                self.uploadfk(fkModel)
            }
            
            let languaceCode = model.meantime?.future ?? ""
            LanguageManager.setAppLanguage(futureValue: "1")
            LanguageManager.setAppLanguage(futureValue: "2")
//            LanguageManager.setAppLanguage(futureValue: languaceCode)
            
            Task {
                try? await Task.sleep(nanoseconds: 250_000_000)
                NotificationCenter.default.post(name: .changeRootViewController, object: nil)
            }
        }else {
            self.againBtn.isHidden = false
        }
    }
    
    private func uploadfk(_ model: postponeModel) {
        
        Settings.shared.displayName = model.questions ?? ""
        Settings.shared.appURLSchemeSuffix = model.observers ?? ""
        Settings.shared.appID = model.fortunate ?? ""
        Settings.shared.clientToken = model.denying ?? ""
        
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            didFinishLaunchingWithOptions: nil
        )
        
    }
}
