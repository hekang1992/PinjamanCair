//
//  OrderViewController.swift
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

enum OrderStatus: Int {
    case all = 10
    case inProgress = 11
    case repayment = 12
    case finished = 13
    
    var type: String {
        switch self {
        case .all:
            return "4"
        case .inProgress:
            return "7"
        case .repayment:
            return "6"
        case .finished:
            return "5"
        }
    }
}

class OrderViewController: CommonViewController {
    
    private(set) var selectedStatus: OrderStatus = .all
    
    private let viewModel = OrderViewModel()
    
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
        nameLabel.text = "Order".localized
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
    
    lazy var typeImageView: UIImageView = {
        let typeImageView = UIImageView()
        typeImageView.image = UIImage(named: "oc_bg_image")
        typeImageView.isUserInteractionEnabled = true
        return typeImageView
    }()
    
    private var buttons: [UIButton] = []
    private var indicatorView: UIView!
    private var currentSelectedButton: UIButton?
    
    private let buttonTitles = ["All", "In progress", "Repayment", "Finished"]
    private let buttonSpacing: CGFloat = 32
    
    lazy var emptyView: OrderEmptyView = {
        let emptyView = OrderEmptyView()
        return emptyView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 46
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(OrderViewCell.self, forCellReuseIdentifier: "OrderViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupButtons()
        setupIndicator()
        setupConstraints()
        setupRefresh()
        setBindViewModel()
        
        applySelectedStatus(shouldLoad: false)
    }
    
    private func setupRefresh() {
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            self.orderListInfo(with: self.selectedStatus.type)
        })
    }
    
    private func setupViews() {
        view.addSubview(headImageView)
        view.addSubview(nameLabel)
        view.addSubview(whiteView)
        whiteView.addSubview(typeImageView)
        whiteView.addSubview(emptyView)
        whiteView.addSubview(tableView)
    }
    
    private func setupButtons() {
        for (index, title) in buttonTitles.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(title.localized, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            button.setTitleColor(.gray, for: .normal)
            button.backgroundColor = .clear
            button.tag = index + 10
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            typeImageView.addSubview(button)
            buttons.append(button)
        }
    }
    
    private func setupIndicator() {
        indicatorView = UIView()
        indicatorView.backgroundColor = UIColor.init(hex: "#8BC3AB")
        indicatorView.layer.cornerRadius = 1
        indicatorView.layer.masksToBounds = true
        typeImageView.addSubview(indicatorView)
    }
    
    private func setupConstraints() {
        headImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(482)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(20)
        }
        
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
        
        typeImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16)
            make.size.equalTo(CGSize(width: 351, height: 50))
        }
        
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(typeImageView.snp.bottom).offset(2)
            make.left.right.bottom.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(typeImageView.snp.bottom).offset(2)
            make.left.right.bottom.equalToSuperview()
        }
        
        var previousButton: UIButton?
        for button in buttons {
            button.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.height.equalTo(30)
                
                if let title = button.titleLabel?.text {
                    let width = (title as NSString).size(withAttributes: [.font: UIFont.systemFont(ofSize: 12)]).width + 4
                    make.width.equalTo(width)
                }
                
                if previousButton == nil {
                    make.left.equalToSuperview().offset(0)
                } else {
                    make.left.equalTo(previousButton!.snp.right).offset(buttonSpacing)
                }
            }
            previousButton = button
        }
        
        if buttons.last != nil {
            var totalWidth: CGFloat = 0
            for button in buttons {
                if let title = button.titleLabel?.text {
                    let width = (title as NSString).size(withAttributes: [.font: UIFont.systemFont(ofSize: 12)]).width + 4
                    totalWidth += width
                }
            }
            totalWidth += CGFloat(buttons.count - 1) * buttonSpacing
            
            let containerWidth: CGFloat = 351
            let leftMargin = (containerWidth - totalWidth) / 2
            
            if let firstButton = buttons.first {
                firstButton.snp.updateConstraints { make in
                    make.left.equalToSuperview().offset(leftMargin)
                }
            }
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let status = OrderStatus(rawValue: sender.tag) else { return }
        selectedStatus = status
        applySelectedStatus(shouldLoad: true)
    }
    
    func selectOrderStatus(_ status: OrderStatus, shouldLoad: Bool = true) {
        selectedStatus = status
        guard isViewLoaded else { return }
        applySelectedStatus(shouldLoad: shouldLoad)
    }
    
    private func applySelectedStatus(shouldLoad: Bool) {
        guard let button = buttons.first(where: { $0.tag == selectedStatus.rawValue }) else { return }
        updateButtonState(selected: button)
        if shouldLoad {
            orderListInfo(with: selectedStatus.type)
        }
    }
    
    private func updateButtonState(selected button: UIButton) {
        for btn in buttons {
            btn.setTitleColor(.gray, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        }
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        currentSelectedButton = button
        
        updateIndicatorPosition(for: button)
    }
    
    private func updateIndicatorPosition(for button: UIButton) {
        self.typeImageView.layoutIfNeeded()
        
        let indicatorWidth: CGFloat = 18
        let indicatorHeight: CGFloat = 4
        
        let buttonFrameInContainer = typeImageView.convert(button.frame, from: button.superview)
        let buttonCenterX = buttonFrameInContainer.midX
        let indicatorX = buttonCenterX - indicatorWidth / 2
        
        indicatorView.snp.remakeConstraints { make in
            make.bottom.equalToSuperview().offset(-2)
            make.width.equalTo(indicatorWidth)
            make.height.equalTo(indicatorHeight)
            make.left.equalToSuperview().offset(indicatorX)
        }
        
        UIView.animate(withDuration: 0.2) {
            self.typeImageView.layoutIfNeeded()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        orderListInfo(with: selectedStatus.type)
    }
}

extension OrderViewController {
    
    private func setBindViewModel() {
        
        viewModel
            .$orderModel
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] model in
                guard let self = self else { return }
                let remains = model.remains ?? ""
                if remains == "0" {
                    let listArray = model.meantime?.visual ?? []
                    if listArray.isEmpty {
                        emptyView.isHidden = false
                        tableView.isHidden = true
                    }else {
                        emptyView.isHidden = true
                        tableView.isHidden = false
                    }
                    self.tableView.reloadData()
                }else {
                    ToastConfig.showMessage(model.judgment ?? "")
                }
                self.tableView.mj_header?.endRefreshing()
            }
            .store(in: &cancellables)
        
        viewModel
            .$errorMsg
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] errorMsg in
                guard let self = self else { return }
                emptyView.isHidden = false
                self.tableView.mj_header?.endRefreshing()
            }
            .store(in: &cancellables)
        
    }
    
    private func orderListInfo(with type: String) {
        let parameters = ["conduct": type]
        viewModel.orderLisrlInfo(parameters: parameters)
    }
    
}

extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.orderModel?.meantime?.visual?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listModel = viewModel.orderModel?.meantime?.visual?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderViewCell", for: indexPath) as! OrderViewCell
        cell.model = listModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listModel = viewModel.orderModel?.meantime?.visual?[indexPath.row]
        let pageUrl = listModel?.sentinel ?? ""
        if pageUrl.hasPrefix(URLSchemeRecognizer.scheme_url) {
            URLSchemeRecognizer.recognizeScheme(from: pageUrl, with: self)
        }else if pageUrl.hasPrefix("http") {
            self.toH5Page(with: pageUrl)
        }else {
            
        }
    }
    
}
