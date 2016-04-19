//
//  MoneyTests.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

import SimpleDomainModel

//////////////////
// MoneyTests
//
class MoneyTests: XCTestCase {
  
  let tenUSD = Money(amount: 10, currency: "USD")
  let twelveUSD = Money(amount: 12, currency: "USD")
  let fiveGBP = Money(amount: 5, currency: "GBP")
  let fifteenEUR = Money(amount: 15, currency: "EUR")
  let fifteenCAN = Money(amount: 15, currency: "CAN")
  
  func testCanICreateMoney() {
    let oneUSD = Money(amount: 1, currency: "USD")
    XCTAssert(oneUSD.amount == 1)
    XCTAssert(oneUSD.currency == "USD")
    //Description Test
    XCTAssert(oneUSD.description == "USD1")
    
    let tenGBP = Money(amount: 10, currency: "GBP")
    XCTAssert(tenGBP.amount == 10)
    XCTAssert(tenGBP.currency == "GBP")
    //Description Test
    XCTAssert(tenGBP.description == "GBP10")
    
  }
  
  func testUSDtoGBP() {
    let gbp = tenUSD.convert("GBP")
    XCTAssert(gbp.currency == "GBP")
    XCTAssert(gbp.amount == 5)
    //Description Test
    XCTAssert(gbp.description == "GBP5")
  }
  func testUSDtoEUR() {
    let eur = tenUSD.convert("EUR")
    XCTAssert(eur.currency == "EUR")
    XCTAssert(eur.amount == 15)
    //Description Test
    XCTAssert(eur.description == "EUR15")
  }
  func testUSDtoCAN() {
    let can = twelveUSD.convert("CAN")
    XCTAssert(can.currency == "CAN")
    XCTAssert(can.amount == 15)
    //Description Test
    XCTAssert(can.description == "CAN15")
  }
  func testGBPtoUSD() {
    let usd = fiveGBP.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 10)
    //Description Test
    XCTAssert(usd.description == "USD10")
  }
  func testEURtoUSD() {
    let usd = fifteenEUR.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 10)
    //Description Test
    XCTAssert(usd.description == "USD10")
  }
  func testCANtoUSD() {
    let usd = fifteenCAN.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 12)
    //Description Test
    XCTAssert(usd.description == "USD12")
  }
  
  func testUSDtoEURtoUSD() {
    let eur = tenUSD.convert("EUR")
    let usd = eur.convert("USD")
    XCTAssert(tenUSD.amount == usd.amount)
    XCTAssert(tenUSD.currency == usd.currency)
    //Description Test
    XCTAssert(tenUSD.description == "\(usd.currency)\(usd.amount)")
  }
  func testUSDtoGBPtoUSD() {
    let gbp = tenUSD.convert("GBP")
    let usd = gbp.convert("USD")
    XCTAssert(tenUSD.amount == usd.amount)
    XCTAssert(tenUSD.currency == usd.currency)
    //Description Test
    XCTAssert(tenUSD.description == "\(usd.currency)\(usd.amount)")

  }
  func testUSDtoCANtoUSD() {
    let can = twelveUSD.convert("CAN")
    let usd = can.convert("USD")
    XCTAssert(twelveUSD.amount == usd.amount)
    XCTAssert(twelveUSD.currency == usd.currency)
    //Description Test
    XCTAssert(twelveUSD.description == "\(usd.currency)\(usd.amount)")

  }
  
  func testAddUSDtoUSD() {
    let total = tenUSD.add(tenUSD)
    XCTAssert(total.amount == 20)
    XCTAssert(total.currency == "USD")
    //Description Test
    XCTAssert(total.description == "USD20")

  }
  
  func testAddUSDtoGBP() {
    let total = tenUSD.add(fiveGBP)
    XCTAssert(total.amount == 10)
    XCTAssert(total.currency == "GBP")
    //Description Test
    XCTAssert(total.description == "GBP10")
  }

    // Extensions Test
    func extTests() {
        let tenUSD = Money(amount:10, currency:"USD")
        XCTAssert(tenUSD.usd.description == "USD10")
        XCTAssert(tenUSD.eur.description == "EUR15")
        XCTAssert(tenUSD.can.description == "CAN12")
        XCTAssert(tenUSD.gbp.description == "GBP5")
    }

    // Operations Test
    func opTest() {
        let tenUSD = Money(amount:10, currency:"USD")
        let fiveUSD = Money(amount:10, currency:"USD")
        let fifteenUSD = tenUSD+fiveUSD
        XCTAssert(fifteenUSD.description == "USD15")
        let twentyUSD = tenUSD+tenUSD
        XCTAssert(twentyUSD.description == "USD20")
        let _fifteenUSD = twentyUSD-fiveUSD
        XCTAssert(_fifteenUSD.description == "USD15")
    }

}

