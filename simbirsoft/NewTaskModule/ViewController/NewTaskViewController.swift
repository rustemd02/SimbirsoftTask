//
//  TaskCreateViewController.swift
//  simbirsoft
//
//  Created by Рустем on 06.07.2023.
//

import UIKit
import SnapKit

protocol NewTaskViewControllerProtocol: AnyObject {
    
}

class NewTaskViewController: UIViewController {
    var presenter: NewTaskPresenterProtocol?
    
    let taskCreationLabel = UILabel()
    
    let newTaskTitleBackgroundView = UIView()
    let newTaskTitleTextfield = UITextField()
    
    let toolbar = UIToolbar()
    let datePickerBackgroundView = UIView()
    
    let newTaskTimeStartBackgroundView = UIView()
    let newTaskTimeStartButton = UIButton(type: .roundedRect)
    let newTaskTimeStartDatepicker = UIDatePicker()
    
    var taskTimeLineView = UIView()
    
    let newTaskTimeFinishBackgroundView = UIView()
    let newTaskTimeFinishButton = UIButton(type: .roundedRect)
    let newTaskTimeFinishDatepicker = UIDatePicker()
    
    let newTaskDescriptionBackgroundView = UIView()
    let newTaskDescriptionTextfield = UITextField()
    
    let taskCreateButton = UIButton(type: .roundedRect)
    
    var date: Date?
    var datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        guard let date = date else { return }
        
        guard let dateFormatted = presenter?.formatDateToCompact(date: date) else { return }
        
        view.addSubview(taskCreationLabel)
        taskCreationLabel.text = "Добавить дело на " + dateFormatted
        taskCreationLabel.font = .systemFont(ofSize: 25, weight: .medium)
        taskCreationLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(25)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(newTaskTitleBackgroundView)
        newTaskTitleBackgroundView.backgroundColor = #colorLiteral(red: 0.9318734407, green: 0.9466862082, blue: 0.9566014409, alpha: 1)
        newTaskTitleBackgroundView.layer.cornerRadius = 10
        newTaskTitleBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(taskCreationLabel.snp.bottomMargin).offset(25)
            make.height.equalTo(60)
            make.leadingMargin.equalTo(view.snp.leadingMargin)
            make.trailingMargin.equalTo(view.snp.trailingMargin)
        }
        
        newTaskTitleBackgroundView.addSubview(newTaskTitleTextfield)
        newTaskTitleTextfield.placeholder = " введите название дела"
        newTaskTitleTextfield.layer.cornerRadius = 10
        newTaskTitleTextfield.backgroundColor = .white
        newTaskTitleTextfield.snp.makeConstraints { make in
            make.centerY.equalTo(newTaskTitleBackgroundView.snp_centerYWithinMargins)
            make.height.equalTo(40)
            make.leadingMargin.equalTo(newTaskTitleBackgroundView.snp.leadingMargin).offset(15)
            make.trailingMargin.equalTo(newTaskTitleBackgroundView.snp.trailingMargin).inset(15)
        }
        
        view.addSubview(taskTimeLineView)
        taskTimeLineView.backgroundColor = #colorLiteral(red: 1, green: 0.8799344897, blue: 0.8916209936, alpha: 1)
        taskTimeLineView.snp.makeConstraints { make in
            make.width.equalTo(5)
            make.centerX.equalToSuperview()
            make.topMargin.equalTo(newTaskTitleBackgroundView.snp_bottomMargin).offset(30)
            make.bottom.equalTo(newTaskTitleBackgroundView.snp_bottomMargin).offset(135)
        }
        
        view.addSubview(newTaskTimeStartBackgroundView)
        newTaskTimeStartBackgroundView.backgroundColor = #colorLiteral(red: 0.9318734407, green: 0.9466862082, blue: 0.9566014409, alpha: 1)
        newTaskTimeStartBackgroundView.layer.cornerRadius = 10
        newTaskTimeStartBackgroundView.snp.makeConstraints { make in
            make.topMargin.equalTo(newTaskTitleBackgroundView.snp_bottomMargin).offset(30)
            make.bottomMargin.equalTo(taskTimeLineView.snp_bottomMargin)
            make.leadingMargin.equalTo(view.snp.leadingMargin)
            make.trailingMargin.equalTo(taskTimeLineView.snp_leadingMargin).offset(-30)
        }
        
        view.addSubview(newTaskTimeFinishBackgroundView)
        newTaskTimeFinishBackgroundView.backgroundColor = #colorLiteral(red: 0.9318734407, green: 0.9466862082, blue: 0.9566014409, alpha: 1)
        newTaskTimeFinishBackgroundView.layer.cornerRadius = 10
        newTaskTimeFinishBackgroundView.snp.makeConstraints { make in
            make.topMargin.equalTo(newTaskTitleBackgroundView.snp_bottomMargin).offset(30)
            make.bottomMargin.equalTo(taskTimeLineView.snp_bottomMargin)
            make.leadingMargin.equalTo(taskTimeLineView.snp_trailingMargin).offset(30)
            make.trailingMargin.equalTo(view.snp.trailingMargin)
        }
        
        newTaskTimeStartBackgroundView.addSubview(newTaskTimeStartButton)
        newTaskTimeStartButton.setTitle("начало", for: .normal)
        newTaskTimeStartButton.addTarget(self, action: #selector(setTimeStart), for: .touchUpInside)
        newTaskTimeStartButton.snp.makeConstraints { make in
            make.centerX.equalTo(newTaskTimeStartBackgroundView.snp.centerX)
            make.centerY.equalTo(newTaskTimeStartBackgroundView.snp.centerY)
            make.width.equalTo(200)
            make.height.equalTo(100)
            
        }
        
        newTaskTimeFinishBackgroundView.addSubview(newTaskTimeFinishButton)
        newTaskTimeFinishButton.setTitle("конец", for: .normal)
        newTaskTimeFinishButton.addTarget(self, action: #selector(setTimeFinish), for: .touchUpInside)
        newTaskTimeFinishButton.sizeToFit()
        newTaskTimeFinishButton.snp.makeConstraints { make in
            make.centerX.equalTo(newTaskTimeFinishBackgroundView.snp.centerX)
            make.centerY.equalTo(newTaskTimeFinishBackgroundView.snp.centerY)
            make.width.equalTo(200)
            make.height.equalTo(100)
        }
        
        view.addSubview(newTaskDescriptionBackgroundView)
        newTaskDescriptionBackgroundView.backgroundColor = #colorLiteral(red: 0.9318734407, green: 0.9466862082, blue: 0.9566014409, alpha: 1)
        newTaskDescriptionBackgroundView.layer.cornerRadius = 10
        newTaskDescriptionBackgroundView.snp.makeConstraints { make in
            make.topMargin.equalTo(taskTimeLineView.snp_bottomMargin).offset(30)
            make.height.equalTo(135)
            make.leadingMargin.equalTo(view.snp_leadingMargin)
            make.trailingMargin.equalTo(view.snp_trailingMargin)
        }
        
        //TODO: чтобы текст заполнял всё поле описания
        newTaskDescriptionBackgroundView.addSubview(newTaskDescriptionTextfield)
        newTaskDescriptionTextfield.placeholder = " введите описание дела"
        newTaskDescriptionTextfield.layer.cornerRadius = 10
        newTaskDescriptionTextfield.backgroundColor = .white
        newTaskDescriptionTextfield.snp.makeConstraints { make in
            make.centerY.equalTo(newTaskDescriptionBackgroundView.snp_centerYWithinMargins)
            make.height.equalTo(115)
            make.leadingMargin.equalTo(newTaskDescriptionBackgroundView.snp.leadingMargin).offset(15)
            make.trailingMargin.equalTo(newTaskDescriptionBackgroundView.snp.trailingMargin).inset(15)
        }
        
        //TODO: текст жирным сделать
        view.addSubview(taskCreateButton)
        taskCreateButton.setTitle("Добавить", for: .normal)
        taskCreateButton.layer.cornerRadius = 10
        taskCreateButton.setTitleColor(.black, for: .normal)
        taskCreateButton.backgroundColor = #colorLiteral(red: 1, green: 0.8799344897, blue: 0.8916209936, alpha: 1)
        taskCreateButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        taskCreateButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
            make.height.equalTo(60)
            make.leadingMargin.equalTo(view.snp.leadingMargin)
            make.trailingMargin.equalTo(view.snp.trailingMargin)
        }
        
        
    }
    
    @objc
    func setTimeStart() {
        setTime(timeStart: true)
    }
    
    @objc
    func setTimeFinish() {
        setTime(timeStart: false)
    }
    
    
    @objc
    func setTime(timeStart: Bool) {
        datePicker = self.newTaskTimeStartDatepicker
        if !timeStart {
            datePicker = self.newTaskTimeFinishDatepicker
        }
        
        view.addSubview(datePickerBackgroundView)
        view.addSubview(datePicker)
        view.addSubview(toolbar)
        
        datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: "ru_RU")
        let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(dismissDatepickers))
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
    func dismissDatepickers() {
        if datePicker == newTaskTimeStartDatepicker {
            newTaskTimeStartButton.setTitle(presenter?.formatTimeToCompact(date: datePicker.date), for: .normal)
        } else {
            newTaskTimeFinishButton.setTitle(presenter?.formatTimeToCompact(date: datePicker.date), for: .normal)
        }
        datePicker.removeFromSuperview()
        toolbar.removeFromSuperview()
    }
    
    @objc
    func save() {
        guard let date = date else { return }
        
        if (!newTaskTitleTextfield.hasText || (newTaskTimeStartButton.title(for: .normal)?.elementsEqual("начало"))! || (newTaskTimeFinishButton.title(for: .normal)?.elementsEqual("конец"))!) {
            showAlert(error: "Заполните все поля")
            return
        }
        if ((presenter?.ifNewTaskHasCollisions(startTime: newTaskTimeStartDatepicker.date, finishTime: newTaskTimeFinishDatepicker.date, date: date)) == true) {
            showAlert(error: "В указанное время у вас уже записано дело")
            return
        }
        
        //TODO: сохранение
        
    }
    
    func showAlert(error title: String) {
        let alertController = UIAlertController(title: "Ошибка", message: title, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "ОК", style: .default) { _ in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }

}

extension NewTaskViewController: NewTaskViewControllerProtocol {
    
}
