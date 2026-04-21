//
//  ThreeViewController.swift
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

class ThreeViewController: CommonViewController {
    
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
    
    lazy var typeImageView: UIImageView = {
        let typeImageView = UIImageView()
        typeImageView.image = UIImage(named: "suc_bg_a_image".localized)
        typeImageView.contentMode = .scaleAspectFit
        return typeImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.init(hex: "#333332")
        nameLabel.textAlignment = .left
        nameLabel.text = "Real name".localized
        nameLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return nameLabel
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textColor = UIColor.init(hex: "#000000")
        oneLabel.textAlignment = .left
        oneLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return oneLabel
    }()
    
    lazy var oneView: UIView = {
        let oneView = UIView()
        oneView.backgroundColor = UIColor.init(hex: "#F6F7F9")
        oneView.layer.cornerRadius = 14
        oneView.layer.masksToBounds = true
        return oneView
    }()
    
    lazy var idLabel: UILabel = {
        let idLabel = UILabel()
        idLabel.textColor = UIColor.init(hex: "#333332")
        idLabel.textAlignment = .left
        idLabel.text = "ID number".localized
        idLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return idLabel
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textColor = UIColor.init(hex: "#000000")
        twoLabel.textAlignment = .left
        twoLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return twoLabel
    }()
    
    lazy var twoView: UIView = {
        let twoView = UIView()
        twoView.backgroundColor = UIColor.init(hex: "#F6F7F9")
        twoView.layer.cornerRadius = 14
        twoView.layer.masksToBounds = true
        return twoView
    }()
    
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.textColor = UIColor.init(hex: "#333332")
        timeLabel.textAlignment = .left
        timeLabel.text = "Date of birth".localized
        timeLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return timeLabel
    }()
    
    lazy var threeLabel: UILabel = {
        let threeLabel = UILabel()
        threeLabel.textColor = UIColor.init(hex: "#000000")
        threeLabel.textAlignment = .left
        threeLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return threeLabel
    }()
    
    lazy var threeView: UIView = {
        let threeView = UIView()
        threeView.backgroundColor = UIColor.init(hex: "#F6F7F9")
        threeView.layer.cornerRadius = 14
        threeView.layer.masksToBounds = true
        return threeView
    }()
    
    lazy var ttmageView: UIImageView = {
        let ttmageView = UIImageView()
        ttmageView.image = UIImage(named: "cli_a_a_image")
        return ttmageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        self.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            let parameters = ["undoubtedly": productID]
            viewModel.imageInfo(parameters: parameters)
        })
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
        
        scrollView.addSubview(typeImageView)
        typeImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 300, height: 190))
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.toProductVc()
        }
        
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(oneView)
        oneView.addSubview(oneLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(typeImageView.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(14)
        }
        
        oneView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.height.equalTo(48)
        }
        
        oneLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-5)
        }
        
        scrollView.addSubview(idLabel)
        scrollView.addSubview(twoView)
        twoView.addSubview(twoLabel)
        
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(oneView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(14)
        }
        
        twoView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(nameLabel)
            make.top.equalTo(idLabel.snp.bottom).offset(12)
            make.height.equalTo(48)
        }
        
        twoLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-5)
        }
        
        scrollView.addSubview(timeLabel)
        scrollView.addSubview(threeView)
        threeView.addSubview(threeLabel)
        threeView.addSubview(ttmageView)
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(twoView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(14)
        }
        
        threeView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(nameLabel)
            make.top.equalTo(timeLabel.snp.bottom).offset(12)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        threeLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-5)
        }
        
        ttmageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(20)
        }
        
        nextBtn
            .rx
            .tap
            .throttle(.microseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.toProductVc()
            })
            .disposed(by: disposeBag)
        
        setupBindings()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let parameters = ["undoubtedly": productID]
        viewModel.imageInfo(parameters: parameters)
    }
    
}

extension ThreeViewController {
    
    private func setupBindings() {
        viewModel
            .$imageModel
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] model in
                guard let self = self else { return }
                let remains = model.remains ?? ""
                if remains == "0" {
                    self.oneLabel.text = model.meantime?.intervening?.user_info?.somewhere ?? ""
                    self.twoLabel.text = model.meantime?.intervening?.user_info?.left ?? ""
                    self.threeLabel.text = model.meantime?.intervening?.user_info?.quarter ?? ""
                }else {
                    ToastConfig.showMessage(model.judgment ?? "")
                }
                self.scrollView.mj_header?.endRefreshing()
            }
            .store(in: &cancellables)
        
        viewModel
            .$errorMsg
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] errorMsg in
                guard let self else { return }
                self.scrollView.mj_header?.endRefreshing()
            }
            .store(in: &cancellables)
        
    }
    
}

