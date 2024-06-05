//
//  Lotto.swift
//  NetworkBasic
//
//  Created by 장예지 on 6/5/24.
//

import Foundation

struct Lotto: Decodable {
    let drwNoDate: String
    let totSellamnt: Int
    let firstWinamnt: Int
    let firstPrzwnerCo: Int
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
    let drwNo: Int
    
    var numberList: [Int] {
        return [drwtNo1, drwtNo2, drwtNo3, drwtNo4, drwtNo5, drwtNo6, bnusNo]
    }
}
