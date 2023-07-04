//
//  TaskListViewController.swift
//  simbirsoft
//
//  Created by Рустем on 01.07.2023.
//

import UIKit
import SnapKit

protocol TaskListViewControllerProtocol: AnyObject {
    
}

class TaskListViewController: UIViewController {
    var presenter: TaskListPresenterProtocol?
    
    let tasksTableView = UITableView()
    
    let dateButton = UIButton(type: .roundedRect)
    
    let datePicker = UIDatePicker()
    let toolbar = UIToolbar()
    let datePickerBackgroundView = UIView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateTitle = presenter?.getDateString(date: Date.init())
        navigationItem.titleView?.isUserInteractionEnabled = true
        
        dateButton.setTitle(dateTitle, for: .normal)
        dateButton.addTarget(self, action: #selector(openCalendarMenu), for: .touchUpInside)
        navigationItem.titleView = dateButton
        //let calendarButton = UIBarButtonItem(image: UIImage(named: "calendar"), style: .plain, target: self, action: #selector(openCalendarMenu))
        tableViewSetup()


    }
  
    func tableViewSetup() {
        tasksTableView.estimatedRowHeight = 80
        tasksTableView.rowHeight = UITableView.automaticDimension
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
        _ = presenter?.getTasksForSelectedDay(selectedDate: .init())
        view.addSubview(tasksTableView)
        tasksTableView.register(TaskTableViewCell.self, forCellReuseIdentifier: "TaskTableViewCell")
        tasksTableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: "EmptyTableViewCell")
        tasksTableView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
    }
    
    @objc
    func openCalendarMenu() {
        view.addSubview(datePickerBackgroundView)
        view.addSubview(datePicker)
        view.addSubview(toolbar)
        
        datePicker.datePickerMode = .date
        let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(updateTableView))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexibleSpace, doneButton]
        toolbar.sizeToFit()
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.snp.makeConstraints { make in
            make.leadingMargin.equalTo(view.snp.leading)
            make.trailingMargin.equalTo(view.snp.trailing)
            make.bottomMargin.equalTo(view.snp_bottomMargin).inset(15)
            
        }
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.snp.makeConstraints { make in
            make.leadingMargin.equalTo(view.snp.leading)
            make.trailingMargin.equalTo(view.snp.trailing)
            make.bottomMargin.equalTo(datePicker.snp.top).inset(-15)
        }
        
        datePickerBackgroundView.backgroundColor = .white
        datePickerBackgroundView.snp.makeConstraints { make in
            make.leadingMargin.equalTo(view.snp.leading)
            make.trailingMargin.equalTo(view.snp.trailing)
            make.bottomMargin.equalTo(view.snp.bottom)
            make.topMargin.equalTo(toolbar.snp.bottom)
        }
    }
    
    
    @objc
    func updateTableView() {
        datePicker.removeFromSuperview()
        toolbar.removeFromSuperview()
        _ = presenter?.getTasksForSelectedDay(selectedDate: datePicker.date)
        let dateTitle = presenter?.getDateString(date: datePicker.date)
        dateButton.setTitle(dateTitle, for: .normal)
        tasksTableView.reloadData()
    }
    
        
    
}

extension TaskListViewController: TaskListViewControllerProtocol {
    
}

extension TaskListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let task = presenter?.getTaskByHour(indexpath: indexPath) {
            let cell = tasksTableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as? TaskTableViewCell
            guard let cell = cell else { return .init() }
            cell.taskTitle.text = task.name
            cell.timeStartLabel.text = presenter?.formatRowToTime(row: indexPath.row.description)
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = #colorLiteral(red: 1, green: 0.9145376682, blue: 0.9278103709, alpha: 1)
                cell.selectedBackgroundView?.backgroundColor = #colorLiteral(red: 1, green: 0.8799344897, blue: 0.8916209936, alpha: 1)
            } else {
                cell.backgroundColor = #colorLiteral(red: 1, green: 0.8799344897, blue: 0.8916209936, alpha: 1)
                cell.selectedBackgroundView?.backgroundColor = #colorLiteral(red: 1, green: 0.9145376682, blue: 0.9278103709, alpha: 1)
            }
            tableView.reloadRows(at: [indexPath], with: .automatic)
            return cell
        }
        
        let cell = tasksTableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as? EmptyTableViewCell
        guard let cell = cell else { return .init() }
        cell.selectionStyle = .none
        cell.timeLabel.text = presenter?.formatRowToTime(row: indexPath.row.description)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let task = presenter?.getTaskByHour(indexpath: indexPath) {
            presenter?.presentDetailView(task: task)
        }
    }
        
    
}
