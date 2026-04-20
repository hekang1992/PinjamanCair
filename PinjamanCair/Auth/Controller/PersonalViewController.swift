//
//  PersonalViewController.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/15.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Combine
import MJRefresh
import TYAlertController

class PersonalViewController: CommonViewController {
    
    var productID: String = ""
    
    var cameraController: CameraController?
    
    private let viewModel = ImageViewModel()
    
    var nextPageModel: proceedingModel? {
        didSet {
            guard let nextPageModel = nextPageModel else { return }
            self.headView.configTitle(nextPageModel.likely ?? "")
        }
    }
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "cen_bg_image")
        headImageView.contentMode = .scaleAspectFill
        return headImageView
    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 20
        whiteView.layer.masksToBounds = true
        whiteView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return whiteView
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.setBackgroundImage(UIImage(named: "log_in_bg_image"), for: .normal)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.setTitle("Next".localized, for: .normal)
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return nextBtn
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "au_02_image".localized)
        return oneImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(headImageView)
        view.addSubview(headView)
        view.addSubview(nextBtn)
        view.addSubview(whiteView)
        whiteView.addSubview(oneImageView)
        
        headImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(482)
        }
        
        headView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(42)
            make.left.right.equalToSuperview()
        }
        
        nextBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-38)
            make.size.equalTo(CGSize(width: 330, height: 71))
        }
        
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(nextBtn.snp.top).offset(-5)
        }
        
        oneImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 348, height: 42))
        }
        
        setupBindings()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let parameters = ["undoubtedly": productID]
        viewModel.getPerInfo(parameters: parameters)
    }
    
}

extension PersonalViewController {
    
    private func setupBindings() {
        viewModel
            .$listModel
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] model in
                guard let self = self else { return }
                let remains = model.remains ?? ""
                if remains == "0" {
                    
                }else {
                    ToastConfig.showMessage(model.remains ?? "")
                }
            }
            .store(in: &cancellables)
        
        viewModel
            .$errorMsg
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { errorMsg in
                
            }
            .store(in: &cancellables)
        
    }
    
}

