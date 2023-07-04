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
    var tasksTableView = UITableView()
    var datePicker = UIDatePicker()
    var toolbar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let selectedDateTitle = Date.init().description(with: Locale(identifier: "ru_RU")).components(separatedBy: "2").first
        navigationItem.title = selectedDateTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        let calendarButton = UIBarButtonItem(image: UIImage(named: "calendar"), style: .plain, target: self, action: #selector(openCalendarMenu))
        navigationItem.rightBarButtonItem = calendarButton
        tasksTableView.estimatedRowHeight = 80
        tasksTableView.rowHeight = UITableView.automaticDimension
        tasksTableView.dataSource = self
        _ = presenter?.getTasksForSelectedDay(selectedDate: .init())
        view.addSubview(tasksTableView)
        tasksTableView.register(TaskTableViewCell.self, forCellReuseIdentifier: "TaskTableViewCell")
        tasksTableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: "EmptyTableViewCell")
        tasksTableView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
        
        datePicker.datePickerMode = .date
    }
    
    @objc
    func openCalendarMenu() {
        
    }
    
    
        
    
}

extension TaskListViewController: TaskListViewControllerProtocol {
    
}

extension TaskListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let task = presenter?.getTaskByHour(indexpath: indexPath) {
            let cell = tasksTableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as? TaskTableViewCell
            guard let cell = cell else { return .init() }
            cell.taskTitle.text = task.name
            cell.timeStartLabel.text = presenter?.formatToTimeInterval(row: indexPath.row.description)
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = #colorLiteral(red: 1, green: 0.9145376682, blue: 0.9278103709, alpha: 1)
            } else {
                cell.backgroundColor = #colorLiteral(red: 1, green: 0.8799344897, blue: 0.8916209936, alpha: 1)
            }
            tableView.reloadRows(at: [indexPath], with: .automatic)
            return cell
        }
        
        let cell = tasksTableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as? EmptyTableViewCell
        guard let cell = cell else { return .init() }
        cell.timeLabel.text = presenter?.formatToTimeInterval(row: indexPath.row.description)
        return cell
    }
    
    
}
