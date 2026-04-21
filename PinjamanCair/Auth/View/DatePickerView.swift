//
//  DatePickerView.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/21.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class DatePickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private let disposeBag = DisposeBag()
    
    private let pickerView = UIPickerView()
    private var days: [String] = []
    private var months: [String] = []
    private var years: [String] = []
    
    private var currentDay = "09"
    private var currentMonth = "09"
    private var currentYear = "1992"
    
    var selectedDayIndex: Int = 0
    var selectedMonthIndex: Int = 0
    var selectedYearIndex: Int = 0
    
    private let selectedColor = UIColor.init(hex: "#8BC3AB")
    
    var onDateChanged: ((String, String, String) -> Void)?
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "Day".localized
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(hex: "#000000")
        return label
    }()
    
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "Month".localized
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(hex: "#000000")
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "Year".localized
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(hex: "#000000")
        return label
    }()
    
    private let labelsContainerView = UIView()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "enc_ad_image")
        oneImageView.isUserInteractionEnabled = true
        return oneImageView
    }()
    
    lazy var confirmBtn: UIButton = {
        let confirmBtn = UIButton(type: .custom)
        confirmBtn.setBackgroundImage(UIImage(named: "log_in_bg_image".localized), for: .normal)
        confirmBtn.setTitle("Confirm".localized, for: .normal)
        confirmBtn.setTitleColor(.white, for: .normal)
        confirmBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return confirmBtn
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor(hex: "#000000")
        nameLabel.textAlignment = .center
        nameLabel.text = "Select Date".localized
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return nameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPicker()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPicker()
    }
    
    private func setupPicker() {
        generateData()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white
        addSubview(oneImageView)
        oneImageView.addSubview(confirmBtn)
        oneImageView.addSubview(nameLabel)
        oneImageView.addSubview(labelsContainerView)
        labelsContainerView.addSubview(dayLabel)
        labelsContainerView.addSubview(monthLabel)
        labelsContainerView.addSubview(yearLabel)
        oneImageView.addSubview(pickerView)
        
        oneImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 351, height: 527))
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(24)
            make.top.equalToSuperview().offset(133)
        }
        
        labelsContainerView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(25)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(1.0/3.0)
            make.centerY.equalToSuperview()
        }
        
        monthLabel.snp.makeConstraints { make in
            make.left.equalTo(dayLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(1.0/3.0)
            make.centerY.equalToSuperview()
        }
        
        yearLabel.snp.makeConstraints { make in
            make.left.equalTo(monthLabel.snp.right)
            make.width.equalToSuperview().multipliedBy(1.0/3.0)
            make.centerY.equalToSuperview()
        }
        
        pickerView.snp.makeConstraints { make in
            make.top.equalTo(labelsContainerView.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(confirmBtn.snp.top).offset(-10)
        }
        
        confirmBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 330, height: 71))
        }
        
        scrollToDate(day: currentDay, month: currentMonth, year: currentYear)
        
        confirmBtn
            .rx
            .tap
            .throttle(.milliseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                onDateChanged?(currentDay, currentMonth, currentYear)
            })
            .disposed(by: disposeBag)
    }
    
    private func generateData() {
        days = (1...31).map { String(format: "%02d", $0) }
        months = (1...12).map { String(format: "%02d", $0) }
        let currentYearInt = Calendar.current.component(.year, from: Date())
        years = (1900...currentYearInt).map { String($0) }
    }
    
    func setDate(dateString: String) {
        let components = dateString.split(separator: "-").map(String.init)
        if components.count == 3,
           let day = Int(components[0]),
           let month = Int(components[1]),
           let year = Int(components[2]),
           (1...31).contains(day),
           (1...12).contains(month),
           (1900...Calendar.current.component(.year, from: Date())).contains(year) {
            
            currentDay = String(format: "%02d", day)
            currentMonth = String(format: "%02d", month)
            currentYear = String(year)
        } else {
            currentDay = "09"
            currentMonth = "09"
            currentYear = "1992"
        }
        
        scrollToDate(day: currentDay, month: currentMonth, year: currentYear)
    }
    
    private func scrollToDate(day: String, month: String, year: String) {
        if let dayIndex = days.firstIndex(of: day),
           let monthIndex = months.firstIndex(of: month),
           let yearIndex = years.firstIndex(of: year) {
            selectedDayIndex = dayIndex
            selectedMonthIndex = monthIndex
            selectedYearIndex = yearIndex
            
            pickerView.selectRow(dayIndex, inComponent: 0, animated: false)
            pickerView.selectRow(monthIndex, inComponent: 1, animated: false)
            pickerView.selectRow(yearIndex, inComponent: 2, animated: false)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return days.count
        case 1: return months.count
        case 2: return years.count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        
        switch component {
        case 0:
            label.text = days[row]
        case 1:
            label.text = months[row]
        case 2:
            label.text = years[row]
        default:
            label.text = ""
        }
        
        let isSelected = (component == 0 && row == selectedDayIndex) ||
        (component == 1 && row == selectedMonthIndex) ||
        (component == 2 && row == selectedYearIndex)
        
        if isSelected {
            label.backgroundColor = selectedColor
            label.textColor = .white
        } else {
            label.backgroundColor = .clear
            label.textColor = .black
        }
        
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            selectedDayIndex = row
            currentDay = days[row]
        case 1:
            selectedMonthIndex = row
            currentMonth = months[row]
        case 2:
            selectedYearIndex = row
            currentYear = years[row]
        default:
            break
        }
        
        pickerView.reloadAllComponents()
        
    }
}
