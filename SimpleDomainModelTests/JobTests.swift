//
//  JobTests.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

import SimpleDomainModel

class JobTests: XCTestCase {
  
  func testCreateSalaryJob() {
    let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
    XCTAssert(job.calculateIncome(50) == 1000)
    //Description Test
    XCTAssert(job.description == "Guest Lecturer:Salary(1000)")
  }

  func testCreateHourlyJob() {
    let job = Job(title: "Janitor", type: Job.JobType.Hourly(15.0))
    XCTAssert(job.calculateIncome(10) == 150)
    //Description Test
    XCTAssert(job.description == "Janitor:Hourly(15.0)")
  }
  
  func testSalariedRaise() {
    let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
    XCTAssert(job.calculateIncome(50) == 1000)
    //Description Test
    XCTAssert(job.description == "Guest Lecturer:Salary(1000)")
    
    job.raise(1000)
    XCTAssert(job.calculateIncome(50) == 2000)
    //Description Test
    XCTAssert(job.description == "Guest Lecturer:Salary(2000)")
  }
  
  func testHourlyRaise() {
    let job = Job(title: "Janitor", type: Job.JobType.Hourly(15.0))
    XCTAssert(job.calculateIncome(10) == 150)
    //Description Test
    XCTAssert(job.description == "Janitor:Hourly(15.0)")
    
    job.raise(1.0)
    XCTAssert(job.calculateIncome(10) == 160)
    //Description Test
    XCTAssert(job.description == "Janitor:Hourly(16.0)")
  }
  
}
