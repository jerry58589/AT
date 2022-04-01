//
//  ScheduleCollectionViewCell.swift
//  ATInterview
//
//  Created by JerryLo on 2022/3/27.
//

import Foundation
import UIKit
import RxSwift
import RxDataSources

class ScheduleCollectionViewCell: UICollectionViewCell {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView.tableFooterView = UIView()
        tableView.separatorColor = UIColor.clear
        tableView.register(TimeTableViewCell.self, forCellReuseIdentifier: "TimeTableViewCell")
        
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
    
    private let tableViewDataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, UiCellTime>>(
            configureCell: { (dataSource, tableView, indexPath, item) -> TimeTableViewCell in
                let cell = tableView.dequeueReusableCell(withIdentifier: "TimeTableViewCell", for: indexPath) as! TimeTableViewCell
                cell.updateUI(viewObject: item)
                return cell
            }
        )
    
    private let disposeBag = DisposeBag()
    private let tableViewSubject = PublishSubject<[SectionModel<String, UiCellTime>]>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        dateBinding()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.contentView.addSubview(tableView)
        self.contentView.addSubview(hintLabel)

        tableView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        hintLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    private func dateBinding() {
        tableViewSubject
            .bind(to: tableView.rx.items(dataSource: tableViewDataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .map { indexPath in
                return (indexPath, self.tableViewDataSource[indexPath])
            }
            .subscribe(onNext: { (indexPath, uiCellTime) in
                if uiCellTime.isAvailable {
                    print("Pressed available time:", uiCellTime.time)
                }
                else {
                    print("Pressed booked time:", uiCellTime.time)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func updateUI(schedule: UiSchedule) {
        hintLabel.isHidden = schedule.cellTimeList.count != 0
        tableViewSubject.onNext(genTimeTableViewData(viewObject: schedule))
    }
    
    private func genTimeTableViewData(viewObject: UiSchedule) -> [SectionModel<String, UiCellTime>] {
        return [viewObject].map({return SectionModel(model: "", items: $0.cellTimeList)})
    }
}
