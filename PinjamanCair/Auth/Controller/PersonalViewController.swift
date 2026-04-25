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
    
    private var riddle: String = ""
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        locationManager.getCurrentLocation { locationDict in }
        riddle = String(Int(Date().timeIntervalSince1970))
    }
    
    private func setupViews() {
        view.addSubview(headImageView)
        view.addSubview(headView)
        view.addSubview(nextBtn)
        view.addSubview(whiteView)
        whiteView.addSubview(oneImageView)
        whiteView.addSubview(tableView)
        
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
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(oneImageView.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
        
        setupBindings()
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.toProductVc()
        }
        
        nextBtn
            .rx
            .tap
            .throttle(.milliseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                let listArray = viewModel.listModel?.meantime?.scattered ?? []
                var parameters = ["undoubtedly": productID]
                for model in listArray {
                    let key = model.remains ?? ""
                    var value = model.cut ?? ""
                    if value.isEmpty {
                        value = model.trunk ?? ""
                    }
                    parameters[key] = value
                }
                viewModel.savePerInfo(parameters: parameters)
            })
            .disposed(by: disposeBag)
        
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
                    self.tableView.reloadData()
                }else {
                    ToastConfig.showMessage(model.judgment ?? "")
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
                    let parameters = ["wild": "4", "riddle": riddle]
                    viewModel.pointInfo(parameters: parameters)
                    self.toProductVc()
                }else {
                    ToastConfig.showMessage(model.judgment ?? "")
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

extension PersonalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listModel?.meantime?.scattered?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.listModel?.meantime?.scattered?[indexPath.row]
        let type = model?.pausing ?? ""
        if type == "heb" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SiuViewCell", for: indexPath) as! SiuViewCell
            cell.model = model
            cell.enterText = { [weak self] text in
                guard let self = self else { return }
                model?.trunk = text
                model?.cut = text
            }
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TapViewCell", for: indexPath) as! TapViewCell
            cell.model = model
            cell.tapBlock = { [weak self] text in
                guard let self = self else { return }
                self.view.endEditing(true)
                self.tapClickCell(with: model, cell: cell)
            }
            return cell
        }
    }
    
}

extension PersonalViewController {
    
    private func tapClickCell(with listModel: scatteredModel? = nil, cell: TapViewCell) {
        let popView = PopEnumView(frame: self.view.bounds)
        if let listModel = listModel {
            popView.nameLabel.text = listModel.likely ?? ""
            let modelArray = listModel.speed ?? []
            popView.modelArray = modelArray
            popView.selectedString = listModel.trunk ?? ""
            let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)
            self.present(alertVc!, animated: true)
            
            popView.saveBlock = { [weak self] model in
                guard let self = self else { return }
                self.dismiss(animated: true) {
                    cell.phoneTx.text = model?.alive ?? ""
                    listModel.trunk = model?.alive ?? ""
                    listModel.cut = model?.cut ?? ""
                }
            }
            
            popView.closeBlock = { [weak self] in
                guard let self = self else { return }
                self.dismiss(animated: true)
            }
        }
    }
    
}
