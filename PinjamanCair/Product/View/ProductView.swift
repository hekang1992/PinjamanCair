//
//  ProductView.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/20.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Kingfisher

class ProductView: UIView {
    
    var tapBlock: ((proceedingModel) -> Void)?
    
    var model: BaseModel? {
        didSet {
            guard let model = model else { return }
            let headModel = model.meantime?.seven ?? sevenModel()
            let logoUrl = headModel.pitch ?? ""
            logoImageView.kf.setImage(with: URL(string: logoUrl))
            nameLabel.text = headModel.pine ?? ""
            descLabel.text = headModel.sit ?? ""
            moneyLabel.text = headModel.accustomed ?? ""
            let modelArray = model.meantime?.proceeding ?? []
            
            setupListItems(with: modelArray)
        }
    }
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "home_card_image")
        return oneImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.cornerRadius = 5
        logoImageView.layer.masksToBounds = true
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.init(hex: "#000000")
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return nameLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textColor = UIColor.init(hex: "#000000").withAlphaComponent(0.3)
        descLabel.textAlignment = .left
        descLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return descLabel
    }()
    
    lazy var moneyLabel: UILabel = {
        let moneyLabel = UILabel()
        moneyLabel.textColor = UIColor.init(hex: "#247255")
        moneyLabel.textAlignment = .left
        moneyLabel.font = UIFont.systemFont(ofSize: 46, weight: .black)
        return moneyLabel
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    // 竖向列表的容器视图
    lazy var listContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        return containerView
    }()
    
    lazy var descImageView: UIImageView = {
        let descImageView = UIImageView()
        descImageView.image = UIImage(named: "pe_an_image".localized)
        descImageView.contentMode = .scaleAspectFit
        return descImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(scrollView)
        scrollView.addSubview(oneImageView)
        oneImageView.addSubview(logoImageView)
        oneImageView.addSubview(nameLabel)
        oneImageView.addSubview(descLabel)
        oneImageView.addSubview(moneyLabel)
        scrollView.addSubview(descImageView)
        scrollView.addSubview(listContainerView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        oneImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343, height: 155))
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(32)
            make.width.height.equalTo(32)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.left.equalTo(logoImageView.snp.right).offset(5)
            make.height.equalTo(20)
        }
        
        descLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView)
            make.top.equalTo(logoImageView.snp.bottom).offset(16)
            make.height.equalTo(15)
        }
        
        moneyLabel.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(4)
            make.left.equalTo(logoImageView)
            make.height.equalTo(56)
        }
        
        descImageView.snp.makeConstraints { make in
            make.top.equalTo(oneImageView.snp.bottom).offset(24)
            make.left.equalTo(oneImageView)
            make.size.equalTo(CGSize(width: 103, height: 27))
        }
        
        listContainerView.snp.makeConstraints { make in
            make.top.equalTo(descImageView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(343)
            make.bottom.equalToSuperview().offset(-200)
        }
    }
    
    private func setupListItems(with models: [proceedingModel]) {
        listContainerView.subviews.forEach { $0.removeFromSuperview() }
        
        guard !models.isEmpty else { return }
        
        var previousView: UIView?
        
        for (index, model) in models.enumerated() {
            let itemView = createListItemView(with: model, num: index)
            listContainerView.addSubview(itemView)
            
            itemView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.width.equalTo(343)
                make.height.equalTo(77)
                
                if let previous = previousView {
                    make.top.equalTo(previous.snp.bottom).offset(12)
                } else {
                    make.top.equalToSuperview()
                }
                
                if index == models.count - 1 {
                    make.bottom.equalToSuperview()
                }
            }
            
            previousView = itemView
        }
    }
    
    private func createListItemView(with model: proceedingModel, num: Int) -> UIView {
        let containerView = ProductListView()
        containerView.model = model
        containerView.unmLabel.text = String(format: "0%d", num + 1)
        containerView.tapBlock = { [weak self] model in
            guard let self = self else { return }
            self.tapBlock?(model)
        }
        return containerView
    }
}
