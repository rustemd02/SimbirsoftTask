//
//  simbirsoftTests.swift
//  simbirsoftTests
//
//  Created by Рустем on 01.07.2023.
//

import XCTest
@testable import simbirsoft

final class simbirsoftInteractorTests: XCTestCase {
    var interactor: TaskListInteractorProtocol?
    let networkService = MockNetworkService()
    let databaseService = MockDatabaseService()
    var tasks: [Task] = []

    override func setUpWithError() throws {
        interactor = TaskListInteractor(networkService: networkService, databaseService: databaseService)
        let task = Task()
        task.id = 1
        task.name = "Название"
        task.dateStart = TimeInterval(integerLiteral: 1688814252)
        task.dateFinish = TimeInterval(integerLiteral: 1688815252)
        task.taskDescription = "Описание"
        tasks.append(task)
        
    }

    override func tearDownWithError() throws {
        interactor = nil
    }

    func testGetDateString() throws {
        let date = Date.init(timeIntervalSince1970: 1688813435)
        guard let dateString = interactor?.getDateString(date: date) else { return }
        XCTAssertEqual(dateString, "суббота, 8 июля")
    }
    
//    func testTasksForTheDay() throws {
//        let date = Date.init(timeIntervalSince1970: 1688813435)
//        guard let tasks = interactor?.getTasksForSelectedDay(selectedDate: date) else { return }
//        XCTAssertTrue(tasks.first == self.tasks.first)
//    }

    

}
