//
//  TaskDetailViewController.swift
//  simbirsoft
//
//  Created by Рустем on 01.07.2023.
//

import UIKit
import SnapKit

protocol TaskDetailViewControllerProtocol: AnyObject {
    
}

class TaskDetailViewController: UIViewController {
    var presenter: TaskDetailPresenterProtocol?
    
    var task: Task?
    var taskTitleLabel = UILabel()
    var taskDescriptionLabel = UILabel()
    var taskStartTimeLabel = UILabel()
    var taskFinishTimeLabel = UILabel()
    
    var taskTitleBackgroundView = UIView()
    var taskTimeLineView = UIView()
    var taskTimeLineBackgroundView = UIView()
    var taskDescriptionBackgroundView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let task = task else { return }
        view.backgroundColor = .white
        setupUI(task: task)
    }
    
    func setupUI(task: Task) {
        view.addSubview(taskTitleBackgroundView)
        taskTitleBackgroundView.backgroundColor = #colorLiteral(red: 0.9318734407, green: 0.9466862082, blue: 0.9566014409, alpha: 1)
        taskTitleBackgroundView.layer.cornerRadius = 10
        taskTitleBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.height.equalTo(40)
            make.leadingMargin.equalTo(view.snp.leadingMargin)
            make.trailingMargin.equalTo(view.snp.trailingMargin)
        }

        taskTitleBackgroundView.addSubview(taskTitleLabel)
        taskTitleLabel.text = task.name
        taskTitleLabel.font = .systemFont(ofSize: 25, weight: .medium)
        taskTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(taskTitleBackgroundView.snp_centerYWithinMargins)
            make.centerX.equalToSuperview()
        }

        view.addSubview(taskTimeLineBackgroundView)
        taskTimeLineBackgroundView.backgroundColor = #colorLiteral(red: 0.9318734407, green: 0.9466862082, blue: 0.9566014409, alpha: 1)
        taskTimeLineBackgroundView.layer.cornerRadius = 10
        taskTimeLineBackgroundView.snp.makeConstraints { make in
            make.topMargin.equalTo(taskTitleBackgroundView.snp_bottomMargin).offset(20)
            make.height.equalTo(135)
            make.leadingMargin.equalTo(view.snp.leadingMargin)
            make.trailingMargin.equalTo(view.snp.trailingMargin)
        }
        
        taskTimeLineBackgroundView.addSubview(taskTimeLineView)
        taskTimeLineView.backgroundColor = #colorLiteral(red: 1, green: 0.8799344897, blue: 0.8916209936, alpha: 1)
        taskTimeLineView.snp.makeConstraints { make in
            make.width.equalTo(5)
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(taskTimeLineBackgroundView.snp_topMargin).offset(15)
            make.bottom.equalTo(taskTitleBackgroundView.snp_bottomMargin).offset(135)
        }
        
        taskTimeLineBackgroundView.addSubview(taskStartTimeLabel)
        taskTimeLineBackgroundView.addSubview(taskFinishTimeLabel)
        
        guard let startDate = task.startDate, let finishDate = task.finishDate else { return }
        taskStartTimeLabel.text = presenter?.getTimeFromDate(date: startDate)
        taskStartTimeLabel.font = .systemFont(ofSize: 35, weight: .medium)
        taskStartTimeLabel.snp.makeConstraints { make in
            make.topMargin.equalTo(taskTimeLineView.snp_topMargin)
            make.trailingMargin.equalTo(taskTimeLineView.snp_trailingMargin).offset(-10)
        }
        
        taskFinishTimeLabel.text = presenter?.getTimeFromDate(date: finishDate)
        taskFinishTimeLabel.font = .systemFont(ofSize: 35, weight: .black)
        taskFinishTimeLabel.snp.makeConstraints { make in
            make.bottomMargin.equalTo(taskTimeLineView.snp_bottomMargin)
            make.leadingMargin.equalTo(taskTimeLineView.snp_leadingMargin).offset(10)
        }
        
        view.addSubview(taskDescriptionBackgroundView)
        taskDescriptionBackgroundView.backgroundColor = #colorLiteral(red: 0.9318734407, green: 0.9466862082, blue: 0.9566014409, alpha: 1)
        taskDescriptionBackgroundView.layer.cornerRadius = 10
        taskDescriptionBackgroundView.snp.makeConstraints { make in
            make.topMargin.equalTo(taskTimeLineBackgroundView.snp_bottomMargin).offset(20)
            make.height.equalTo(275)
            make.leadingMargin.equalTo(view.snp.leadingMargin)
            make.trailingMargin.equalTo(view.snp.trailingMargin)
        }
        
        taskDescriptionBackgroundView.addSubview(taskDescriptionLabel)
        taskDescriptionLabel.text = task.taskDescription
        taskDescriptionLabel.numberOfLines = 0
        taskDescriptionLabel.snp.makeConstraints { make in
            make.leadingMargin.equalTo(taskDescriptionBackgroundView.snp.leadingMargin).offset(10)
            make.trailingMargin.equalTo(taskDescriptionBackgroundView.snp.trailingMargin).offset(-10)
            make.topMargin.equalTo(taskDescriptionBackgroundView.snp_topMargin).offset(5)
            make.bottomMargin.equalTo(taskDescriptionBackgroundView.snp_bottomMargin).offset(-5)
        }

    }
    
}

extension TaskDetailViewController: TaskDetailViewControllerProtocol {
    
}
