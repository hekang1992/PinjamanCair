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
    var visual: [visualModel]?
    var heroic: String?
    var safe: String?
}

class postponeModel: Codable {
    var observers: String?
    var fortunate: String?
    var questions: String?
    var denying: String?
}

class visualModel: Codable {
    var cut: String?
    var intervening: [interveningModel]?
}

class interveningModel: Codable {
    var grove: String?
    var pine: String?
    var pitch: String?
    var months: String?
    var enigma: String?
    var mount: String?
    var choice: String?
    var picket: String?
    var between: String?
    var ifo: String?
    
    enum CodingKeys: String, CodingKey {
        case grove
        case pine
        case pitch
        case months
        case enigma
        case mount
        case choice
        case picket
        case between
        case ifo = "if"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let intValue = try? container.decode(Int.self, forKey: .grove) {
            self.grove = String(intValue)
        } else {
            self.grove = try? container.decode(String.self, forKey: .grove)
        }
        
        self.pine = try? container.decode(String.self, forKey: .pine)
        self.pitch = try? container.decode(String.self, forKey: .pitch)
        self.months = try? container.decode(String.self, forKey: .months)
        self.enigma = try? container.decode(String.self, forKey: .enigma)
        self.mount = try? container.decode(String.self, forKey: .mount)
        self.choice = try? container.decode(String.self, forKey: .choice)
        self.picket = try? container.decode(String.self, forKey: .picket)
        self.between = try? container.decode(String.self, forKey: .between)
        
        self.ifo = try? container.decode(String.self, forKey: .ifo)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(grove, forKey: .grove)
        try container.encode(pine, forKey: .pine)
        try container.encode(pitch, forKey: .pitch)
        try container.encode(months, forKey: .months)
        try container.encode(enigma, forKey: .enigma)
        try container.encode(mount, forKey: .mount)
        try container.encode(choice, forKey: .choice)
        try container.encode(picket, forKey: .picket)
        try container.encode(between, forKey: .between)
        try container.encode(ifo, forKey: .ifo)
    }
}
