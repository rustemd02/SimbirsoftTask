//
//  TaskTableViewCell.swift
//  simbirsoft
//
//  Created by Рустем on 01.07.2023.
//

import UIKit
import SnapKit

class TaskTableViewCell: UITableViewCell {
    let timeStartLabel = UILabel()
    let timeFinishLabel = UILabel()
    let taskTitle = UILabel()
    let taskBackgroundView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(taskBackgroundView)
        contentView.addSubview(timeStartLabel)
        contentView.addSubview(timeFinishLabel)
        contentView.addSubview(taskTitle)
        
//        contentView.snp.makeConstraints { make in
//            make.height.equalTo(100)
//        }
//        taskBackgroundView.backgroundColor = .black
//        taskBackgroundView.snp.makeConstraints { make in
//            make.edges.equalTo(contentView).offset(25)
//        }
        
        timeStartLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        timeStartLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leadingMargin.equalTo(contentView.snp_leadingMargin).offset(15)
        }
        
        timeFinishLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        timeFinishLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottomMargin.equalToSuperview().offset(-10)
        }
        
        taskTitle.font = .systemFont(ofSize: 20, weight: .semibold)
        taskTitle.textAlignment = .right
        taskTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(contentView.snp.trailing).inset(15)
            make.leading.greaterThanOrEqualTo(timeStartLabel.snp.trailing).offset(15)
        }



        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
