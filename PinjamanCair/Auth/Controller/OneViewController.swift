//
//  OneViewController.swift
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

class OneViewController: CommonViewController {
    
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
        oneImageView.image = UIImage(named: "au_01_image".localized)
        return oneImageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var tapBtn: UIButton = {
        let tapBtn = UIButton(type: .custom)
        tapBtn.setBackgroundImage(UIImage(named: "qn_en_image".localized), for: .normal)
        tapBtn.adjustsImageWhenHighlighted = false
        return tapBtn
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
        
        whiteView.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(oneImageView.snp.bottom).offset(5)
            make.left.right.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(tapBtn)
        tapBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343, height: 365))
            make.bottom.equalToSuperview().offset(-20)
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.toProductVc()
        }
        
        nextBtn
            .rx
            .tap
            .throttle(.microseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.tapCamera()
            })
            .disposed(by: disposeBag)
        
        tapBtn
            .rx
            .tap
            .throttle(.microseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.tapCamera()
            })
            .disposed(by: disposeBag)
        
        setupBindings()
        
    }
    
}

extension OneViewController {
    
    private func setupBindings() {
        viewModel
            .$uploadModel
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] model in
                guard let self = self else { return }
                let remains = model.remains ?? ""
                if remains == "0" {
                    let ventured = model.meantime?.ventured ?? 1
                    if ventured == 0 {
                        // no alert
                    }else {
                        // alert
                        self.popNameView(with: model)
                    }
                }else {
                    ToastConfig.showMessage(model.remains ?? "")
                }
            }
            .store(in: &cancellables)
        
        viewModel
            .$saveModel
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] model in
                guard let self = self else { return }
                let remains = model.remains ?? ""
                if remains == "0" {
                    self.dismiss(animated: true) {
                        let twoVc = TwoViewController()
                        twoVc.productID = self.productID
                        twoVc.nextPageModel = self.nextPageModel
                        self.navigationController?.pushViewController(twoVc, animated: true)
                    }
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

extension OneViewController {
    
    private func tapCamera() {
        
        cameraController = CameraController(
            presenter: self,
            initialCameraPosition: .rear,
            completion: { [weak self] imageData, error in
                guard let self = self, let imageData else { return }
                let parameters = ["cut": "11", "sitting": "1"]
                self.viewModel.uploadImageInfo(parameters: parameters, imageData: imageData)
            }
        )
        cameraController?.startCamera()
        
    }
}

extension OneViewController {
    
    private func popNameView(with model: BaseModel) {
        let popView = PopNameView(frame: self.view.bounds)
        popView.modelArray = model.meantime?.warbler ?? []
        let alertVc = TYAlertController(alert: popView, preferredStyle: .actionSheet)
        self.present(alertVc!, animated: true)
        
        popView.saveBlock = { [weak self] in
            guard let self = self else { return }
            let modelArray = model.meantime?.warbler ?? []
            var parameters: [String: Any] = ["undoubtedly": productID]
            for model in modelArray {
                let key = model.remains ?? ""
                let value = model.provokingly ?? ""
                parameters[key] = value
            }
            
            viewModel.saveImageInfo(parameters: parameters)
        }
    }
    
}
