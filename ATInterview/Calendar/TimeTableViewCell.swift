//
//  TimeTableViewCell.swift
//  ATInterview
//
//  Created by JerryLo on 2022/3/27.
//

import Foundation
import UIKit

class TimeTableViewCell: UITableViewCell {
    
    private lazy var backView: UIView = {
        let backView = UIView()
        backView.layer.cornerRadius = 10
        backView.layer.masksToBounds = true
        return backView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)

        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(backView)
        backView.addSubview(nameLabel)

        backView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(10)
            make.left.right.equalToSuperview().inset(30)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    func updateUI(viewObject: UiCellTime) {
        nameLabel.text = viewObject.time
        
        if viewObject.isAvailable {
            backView.backgroundColor = .amazingTalkerGreen.withAlphaComponent(0.7)
        }
        else {
            backView.backgroundColor = .lightGray.withAlphaComponent(0.7)
        }
    }


}
