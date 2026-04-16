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
    
    enum CodingKeys: String, CodingKey {
        case remains
        case judgment
        case meantime
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let intValue = try? container.decode(Int.self, forKey: .remains) {
            self.remains = String(intValue)
        } else {
            self.remains = try? container.decode(String.self, forKey: .remains)
        }
        
        self.judgment = try? container.decode(String.self, forKey: .judgment)
        self.meantime = try? container.decode(meantimeModel.self, forKey: .meantime)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(remains, forKey: .remains)
        try container.encode(judgment, forKey: .judgment)
        try container.encode(meantime, forKey: .meantime)
    }
}

class meantimeModel: Codable {
    var future: String?
    var postpone: postponeModel?
}

class postponeModel: Codable {
    var observers: String?
    var fortunate: String?
    var questions: String?
    var denying: String?
}
