//
//  AccountViewController.swift
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

class AccountViewController: CommonViewController {
    
    private let viewModel = AccountViewModel()
    private var visualList: [visualModel] = []
    private var listItemViews: [UIView] = []
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "cen_bg_image")
        headImageView.contentMode = .scaleAspectFill
        return headImageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.init(hex: "#000000")
        nameLabel.textAlignment = .left
        nameLabel.text = "Account".localized
        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return nameLabel
    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 20
        whiteView.layer.masksToBounds = true
        whiteView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return whiteView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .clear
        return contentView
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "ac_en_image".localized)
        oneImageView.isUserInteractionEnabled = true
        return oneImageView
    }()
    
    private lazy var phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        phoneLabel.textColor = UIColor.init(hex: "#247255")
        phoneLabel.textAlignment = .left
        phoneLabel.font = UIFont.systemFont(ofSize: 22, weight: .black)
        return phoneLabel
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        return twoBtn
    }()
    
    lazy var threeBtn: UIButton = {
        let threeBtn = UIButton(type: .custom)
        return threeBtn
    }()
    
    lazy var fourBtn: UIButton = {
        let fourBtn = UIButton(type: .custom)
        return fourBtn
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(headImageView)
        headImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(482)
        }
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(20)
        }
        
        view.addSubview(whiteView)
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
        
        whiteView.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        
        contentView.addSubview(oneImageView)
        oneImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 345, height: 187))
        }
        
        oneImageView.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(48)
            make.left.equalToSuperview().inset(20)
            make.height.equalTo(22)
        }
        
        oneImageView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(phoneLabel.snp.bottom).offset(20)
        }
        
        stackView.addArrangedSubview(oneBtn)
        stackView.addArrangedSubview(twoBtn)
        stackView.addArrangedSubview(threeBtn)
        stackView.addArrangedSubview(fourBtn)
        
        setBindViewModel()
        
        oneBtn
            .rx
            .tap
            .throttle(.milliseconds(200), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.openOrderPage(with: .all)
            })
            .disposed(by: disposeBag)
        
        twoBtn
            .rx
            .tap
            .throttle(.milliseconds(200), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.openOrderPage(with: .inProgress)
            })
            .disposed(by: disposeBag)
        
        threeBtn
            .rx
            .tap
            .throttle(.milliseconds(200), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.openOrderPage(with: .repayment)
            })
            .disposed(by: disposeBag)
        
        fourBtn
            .rx
            .tap
            .throttle(.milliseconds(200), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.openOrderPage(with: .finished)
            })
            .disposed(by: disposeBag)
        
        self.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            viewModel.getAccountInfo()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getAccountInfo()
    }
    
    private func createListViews(with dataArray: [visualModel]) {
        listItemViews.forEach { $0.removeFromSuperview() }
        listItemViews.removeAll()
        
        for (index, item) in dataArray.enumerated() {
            let itemView = createSingleItemView(with: item, index: index)
            contentView.addSubview(itemView)
            listItemViews.append(itemView)
        }
        
        setupListViewsConstraints()
    }
    
    private func openOrderPage(with status: OrderStatus) {
        tabBarController?.selectedIndex = 1
        
        guard
            let tabBarController = tabBarController,
            let viewControllers = tabBarController.viewControllers,
            viewControllers.indices.contains(1),
            let nav = viewControllers[1] as? UINavigationController,
            let orderVc = nav.viewControllers.first(where: { $0 is OrderViewController }) as? OrderViewController
        else {
            return
        }
        
        orderVc.selectOrderStatus(status)
    }
    
    private func createSingleItemView(with model: visualModel, index: Int) -> UIView {
        let containerView = AccountListView()
        containerView.visualModel = model
        containerView.tapBlock = { [weak self] model in
            guard let self = self else { return }
            let pageUrl = model.mere ?? ""
            if pageUrl.contains(URLSchemeRecognizer.scheme_url) {
                URLSchemeRecognizer.recognizeScheme(from: pageUrl, with: self)
            }else {
                self.toH5Page(with: pageUrl)
            }
        }
        return containerView
    }
    
    private func setupListViewsConstraints() {
        guard !listItemViews.isEmpty else { return }
        
        var previousView: UIView? = oneImageView
        
        for (index, itemView) in listItemViews.enumerated() {
            itemView.snp.makeConstraints { make in
                make.left.equalTo(contentView)
                make.right.equalTo(contentView)
                make.height.equalTo(50)
                
                if index == 0 {
                    make.top.equalTo(previousView!.snp.bottom).offset(24)
                } else {
                    make.top.equalTo(previousView!.snp.bottom).offset(16)
                }
                
                if index == listItemViews.count - 1 {
                    make.bottom.equalTo(contentView.snp.bottom).offset(-20)
                }
            }
            previousView = itemView
        }
    }
}

extension AccountViewController {
    
    private func setBindViewModel() {
        viewModel
            .$accountModel
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] model in
                guard let self = self else { return }
                self.scrollView.mj_header?.endRefreshing()
                let remains = model.remains ?? ""
                if remains == "0" {
                    let phone = model.meantime?.userInfo?.phone ?? ""
                    self.configePhone(with: phone)
                    
                    let listArray = model.meantime?.visual ?? []
                    self.visualList = listArray
                    self.createListViews(with: listArray)
                }
            }
            .store(in: &cancellables)
        
        viewModel
            .$errorMsg
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] errorMsg in
                guard let self = self else { return }
                self.scrollView.mj_header?.endRefreshing()
            }
            .store(in: &cancellables)
    }
}

extension AccountViewController {
    
    private func configePhone(with phone: String) {
        self.phoneLabel.text = phone
    }
}
