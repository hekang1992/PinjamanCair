//
//  BaseModel.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/15.
//

class BaseModel: Codable {
    var remains: String?
    var judgment: String?
    var meantime: meantimeModel?
}

class meantimeModel: Codable {
    var future: Int?
}
