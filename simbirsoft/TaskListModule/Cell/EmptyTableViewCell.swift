//
//  EmptyTableViewVell.swift
//  simbirsoft
//
//  Created by Рустем on 03.07.2023.
//

import UIKit
import SnapKit

class EmptyTableViewCell: UITableViewCell {
    let timeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leadingMargin.equalTo(contentView.snp_leadingMargin).offset(15)
        }
        timeLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        timeLabel.textColor = .lightGray
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
