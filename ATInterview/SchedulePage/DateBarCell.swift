//
//  DateBarCell.swift
//  ATInterview
//
//  Created by JerryLo on 2022/3/27.
//

import Foundation
import UIKit

class DateBarCell: UICollectionViewCell {
    private lazy var weekdayLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 1
        label.textAlignment = .center

        return label
    }()
    
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 1
        label.textAlignment = .center

        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.contentView.addSubview(weekdayLabel)
        self.contentView.addSubview(dayLabel)
        
        weekdayLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(5)
            make.top.equalToSuperview().inset(10)
            
        }
        
        dayLabel.snp.makeConstraints { make in
            make.left.right.equalTo(weekdayLabel)
            make.bottom.equalToSuperview().inset(10)
        }
        
        self.backgroundColor = UIColor.lightGray
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height/2
    }
    
    func updateUI(schedule: UiSchedule, isSelected: Bool) {
        weekdayLabel.text = schedule.weekday
        dayLabel.text = schedule.timestamp.timestampDateStr(dateFormat: "dd")
        
        if isSelected {
            self.contentView.backgroundColor = .amazingTalkerGreen.withAlphaComponent(0.7)
        }
        else {
            self.contentView.backgroundColor = .white
        }
    }
}
