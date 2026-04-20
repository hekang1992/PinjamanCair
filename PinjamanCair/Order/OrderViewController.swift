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

class OrderViewController: CommonViewController {
    
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
    
    // MARK: - 按钮属性
    private var buttons: [UIButton] = []
    private var indicatorView: UIView!
    private var currentSelectedButton: UIButton?
    
    private let buttonTitles = ["All", "In progress", "Repayment", "Finished"]
    private let buttonSpacing: CGFloat = 32
    
    lazy var emptyView: OrderEmptyView = {
        let emptyView = OrderEmptyView()
        return emptyView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupButtons()
        setupIndicator()
        setupConstraints()
        
        if let allButton = buttons.first {
            updateButtonState(selected: allButton)
        }
    }
    
    private func setupViews() {
        view.addSubview(headImageView)
        view.addSubview(nameLabel)
        view.addSubview(whiteView)
        whiteView.addSubview(typeImageView)
        whiteView.addSubview(emptyView)
    }
    
    private func setupButtons() {
        for (index, title) in buttonTitles.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(title.localized, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            button.setTitleColor(.gray, for: .normal)
            button.backgroundColor = .clear
            button.tag = index
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
        
        if let lastButton = buttons.last {
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
        updateButtonState(selected: sender)
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
}
