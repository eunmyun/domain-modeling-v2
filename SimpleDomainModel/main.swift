//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

public class TestMe {
  public func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// protocols
//
protocol CustomStringConvertible {
    var description : String { get set }
}

protocol Mathematics {
    func +(left: Money, right: Money) -> Money
    func -(left: Money, right: Money) -> Money
}

public func + (left: Money, right: Money) -> Money{
    let _amount = left.amount + right.amount
    return Money(amount: _amount, currency: left.currency)
}

public func - (left: Money, right: Money) -> Money{
    let _amount = left.amount - right.amount
    return Money(amount: _amount, currency: left.currency)
}

/////////////////////////////////////
//  Extension
//
extension Money {
    var usd: Money {return self}
    var gbp: Money {return Money(amount: Int(Double(self.amount) * 0.5), currency:"GBP")}
    var eur: Money {return Money(amount: Int(Double(self.amount) * 1.5), currency:"EUR")}
    var can: Money {return Money(amount: Int(Double(self.amount) * 1.25), currency:"CAN")}
}

////////////////////////////////////
// Money
//
public struct Money : CustomStringConvertible {
  public var amount : Int
  public var currency : String
    
    public var description : String {
        get {
            return "\(currency)\(amount)"
        } set {
            description = "\(currency)\(amount)"
        }
        
    }
    
  public func convert(to: String) -> Money {
    let rates = [
        "USD": 1,
        "GBP": 0.5,
        "EUR": 1.5,
        "CAN": 1.25,
    ]
    let rate = rates[to]! / rates[currency]!
    let _amount = Int(Double(amount) * rate)
    let _currency = to
    return Money(amount:_amount, currency:_currency)
  }
  
  public func add(to: Money) -> Money {
    var _amount : Int = amount
    if (currency != to.currency) {
        let converted: Money = convert(to.currency)
        _amount = converted.amount
    }
    let _currency = to.currency
    _amount += Int(to.amount)
    return Money(amount: _amount, currency: _currency)
  }
    
  public func subtract(from: Money) -> Money {
    var _amount : Int = amount
    if (currency != from.currency) {
        let converted: Money = convert(from.currency)
        _amount = converted.amount
    }
    let _currency = from.currency
    _amount = Int(from.amount - _amount)
    return Money(amount: _amount, currency: _currency)
  }
    
}

////////////////////////////////////
// Job
//
public class Job : CustomStringConvertible {
  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }
    
  public var title : String
  public var type : JobType
  public var description: String
  
  public init(title : String, type : JobType) {
    self.title = title
    self.type = type
    self.description = "\(title):\(type)"
  }
  
  public func calculateIncome(hours: Int) -> Int {
    switch type {
        case .Hourly(let value):
            return Int(value * Double(hours))
        case .Salary(let value):
            return value
    }
  }
  
  public func raise(amt : Double) {
    switch type {
        case .Hourly(let value):
            type = .Hourly(Double(value + amt))
        case .Salary(let value):
            type = .Salary(value + Int(amt))
    }
    description = "\(title):\(type)"
  }
}

////////////////////////////////////
// Person
//
public class Person : CustomStringConvertible {
  public var firstName : String = ""
  public var lastName : String = ""
  private var age : Int = 0
  public var description: String

  private var _job : Job? = nil
  public var job : Job? {
    get {
        return _job
    }
    set(value) {
        if age >= 16 {
            _job = value
        }
    }
  }
  
  private var _spouse : Person? = nil
  public var spouse : Person? {
    get {
        return _spouse
    }
    set(value) {
        if (age >= 18) {
            _spouse = value
        }
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
    description = "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(_job) spouse:\(_spouse)]"
  }
  
  public func toString() -> String {
    return description
  }
}

////////////////////////////////////
// Family
//
public class Family : CustomStringConvertible {
  private var members : [Person] = []
  public var description: String
  
  public init(spouse1: Person, spouse2: Person) {
    if spouse1.spouse == nil && spouse2.spouse == nil {
        spouse1.spouse = spouse2
        spouse2.spouse = spouse1
        members += [spouse1, spouse2]
        description = "spounse1:\(spouse1.firstName) spouse2:\(spouse2.firstName)"
    } else {
        description = "no spouses"
    }
  }
  
  public func haveChild(child: Person) -> Bool {
    for index in 0...members.count {
        if members[index].age > 21 {
            members.append(child)
            description += " child:\(child.firstName)"
            return true
        }
    }
    return false
    }
  
  public func householdIncome() -> Int {
    var total: Int = 0
    for person in members {
        if person.job?.type != nil {
            total += person.job!.calculateIncome(2000)
        }
    }
    return total
  }
}





