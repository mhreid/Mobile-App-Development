//: Playground - noun: a place where people can play

import UIKit


func isLeap(year:Int) ->  Bool{
    return (year % 400 == 0) || (year % 4 == 0 && year % 100 != 0)
}




let daysSoFar = [0, 31, 59, 90 , 120, 151 , 181, 212, 243 , 273 , 304, 334, 365]


func julianDate(year: Int, month: Int, day: Int) -> Int{
    let leapYearsPassed : Int = (year - 1900)/4 - (year - 1900) / 100 + (year - 1900 + 300) / 400
    return daysSoFar[month - 1] + day + leapYearsPassed + (365 * (year - 1900))
}

julianDate(1960, month:  9, day: 28)
julianDate(1900, month:  1, day: 1)
julianDate(1900, month: 12, day: 31)
julianDate(1901, month: 1, day: 1)

isLeap(1960)
isLeap(1900)
isLeap(2000)