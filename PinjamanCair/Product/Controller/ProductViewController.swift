//
//  ProductViewController.swift
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

class ProductViewController: CommonViewController {
    
    var productID: String = ""
    
    var motionless: String = ""
    
    var nextStepModel: proceedingModel?
    
    private let viewModel = ProductViewModel()
    
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
    
    lazy var productView: ProductView = {
        let productView = ProductView()
        return productView
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.setBackgroundImage(UIImage(named: "log_in_bg_image"), for: .normal)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.setTitle("Get code".localized, for: .normal)
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return nextBtn
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
        whiteView.addSubview(productView)
        
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
        
        productView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
        
        productView.tapBlock = { [weak self] model in
            guard let self = self else { return }
            let widowed = model.widowed ?? 0
            if widowed == 1 {
                self.clickToPageVc(nextStepModel: model)
            }else {
                let productModel = viewModel.productModel
                let orderedModel = productModel?.meantime?.ordered ?? proceedingModel()
                self.clickToPageVc(nextStepModel: orderedModel)
            }
        }
        
        nextBtn
            .rx
            .tap
            .throttle(.microseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                let productModel = viewModel.productModel
                let orderedModel = productModel?.meantime?.ordered ?? proceedingModel()
                let cardModel = productModel?.meantime?.seven
                self.clickToPageVc(nextStepModel: orderedModel, cardModel: cardModel)
            })
            .disposed(by: disposeBag)
        
        setupBindings()
        
        self.productView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            let parameters = ["undoubtedly": productID]
            viewModel.productDetailInfo(parameters: parameters)
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let parameters = ["undoubtedly": productID]
        viewModel.productDetailInfo(parameters: parameters)
        locationManager.getCurrentLocation { locationDict in }
    }
    
}

extension ProductViewController {
    
    private func setupBindings() {
        viewModel
            .$productModel
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] model in
                guard let self = self else { return }
                let remains = model.remains ?? ""
                if remains == "0" {
                    self.productView.model = model
                    let ns = model.meantime?.seven?.months ?? ""
                    self.nextBtn.setTitle(ns, for: .normal)
                    self.headView.configTitle(model.meantime?.seven?.pine ?? "")
                }
                self.productView.scrollView.mj_header?.endRefreshing()
            }
            .store(in: &cancellables)
        
        viewModel
            .$errorMsg
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] errorMsg in
                self?.productView.scrollView.mj_header?.endRefreshing()
            }
            .store(in: &cancellables)
        
        viewModel
            .$imageModel
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] model in
                guard let self = self else { return }
                let remains = model.remains ?? ""
                if remains == "0" {
                    let kingbirds = model.meantime?.intervening?.kingbirds ?? ""
                    let driving = model.meantime?.intervening?.driving ?? ""
                    if kingbirds.isEmpty {
                        let oneVc = OneViewController()
                        oneVc.productID = productID
                        oneVc.nextPageModel = self.nextStepModel
                        self.navigationController?.pushViewController(oneVc, animated: true)
                    }else if driving.isEmpty {
                        let twoVc = TwoViewController()
                        twoVc.productID = productID
                        twoVc.nextPageModel = self.nextStepModel
                        self.navigationController?.pushViewController(twoVc, animated: true)
                    }else {
                        let threeVc = ThreeViewController()
                        threeVc.productID = productID
                        threeVc.nextPageModel = self.nextStepModel
                        self.navigationController?.pushViewController(threeVc, animated: true)
                    }
                }
            }
            .store(in: &cancellables)
        
        viewModel
            .$orderModel
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] model in
                guard let self = self else { return }
                let remains = model.remains ?? ""
                if remains == "0" {
                    let pageUrl = model.meantime?.mere ?? ""
                    if pageUrl.hasPrefix(URLSchemeRecognizer.scheme_url) {
                        URLSchemeRecognizer.recognizeScheme(from: pageUrl, with: self)
                    }else {
                        self.toH5Page(with: pageUrl)
                    }
                    let parameters = ["wild": "8",
                                      "riddle": String(Int(Date().timeIntervalSince1970)),
                                      "alone": self.motionless]
                    viewModel.pointInfo(parameters: parameters)
                }else {
                    ToastConfig.showMessage(model.judgment ?? "")
                }
            }
            .store(in: &cancellables)
        
    }
    
}

extension ProductViewController {
    
    func clickToPageVc(nextStepModel: proceedingModel? = nil, cardModel: sevenModel? = nil) {
        self.nextStepModel = nextStepModel
        let auth = nextStepModel?.leafy ?? ""
        switch auth {
        case "lighta":
            let parameters = ["undoubtedly": productID]
            viewModel.imageInfo(parameters: parameters)
            
        case "lightb":
            let personalVc = PersonalViewController()
            personalVc.productID = productID
            personalVc.nextPageModel = nextStepModel
            self.navigationController?.pushViewController(personalVc, animated: true)
            
        case "lightc":
            let pwVc = WorkViewController()
            pwVc.productID = productID
            pwVc.nextPageModel = nextStepModel
            self.navigationController?.pushViewController(pwVc, animated: true)
            
        case "lightd":
            let pcVc = ContactViewController()
            pcVc.productID = productID
            pcVc.nextPageModel = nextStepModel
            self.navigationController?.pushViewController(pcVc, animated: true)
            
        case "lighte":
            let pcVc = BankViewController()
            pcVc.productID = productID
            pcVc.nextPageModel = nextStepModel
            self.navigationController?.pushViewController(pcVc, animated: true)
            
        case "":
            let motionless = cardModel?.motionless ?? ""
            self.motionless = motionless
            let parameters = ["motionless": motionless]
            viewModel.orderInfo(parameters: parameters)
            
        default:
            break
        }
    }
    
}
