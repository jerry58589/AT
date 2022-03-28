//
//  ScheduleCollectionViewCell.swift
//  ATInterview
//
//  Created by JerryLo on 2022/3/27.
//

import Foundation
import UIKit

class ScheduleCollectionViewCell: UICollectionViewCell {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView.tableFooterView = UIView()
        tableView.separatorColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var hintLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 32.0)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "No Time"
        return label
    }()
    
    private var uiSchedule: UiSchedule?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.contentView.addSubview(tableView)
        self.contentView.addSubview(hintLabel)

        tableView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()//.inset(100)
            make.left.right.equalToSuperview()
        }
        
        hintLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    func updateUI(schedule: UiSchedule) {
        self.uiSchedule = schedule
        hintLabel.isHidden = uiSchedule?.cellTimeList.count != 0
        tableView.reloadData()
    }
}

extension ScheduleCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uiSchedule?.cellTimeList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TimeTableViewCell(style: .default, reuseIdentifier: "TimeTableViewCell")
        cell.selectionStyle = .none
        cell.updateUI(viewObject: (uiSchedule?.cellTimeList[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let timeInfo = uiSchedule?.cellTimeList[indexPath.row] {
            if timeInfo.isAvailable {
                print("Pressed available time:",uiSchedule?.timestamp.timestampDateStr() ?? "" ,timeInfo.time)
            }
            else {
                print("Pressed booked time:",uiSchedule?.timestamp.timestampDateStr() ?? "" , timeInfo.time)
            }
        }
    }
}
