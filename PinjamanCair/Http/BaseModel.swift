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
    var userInfo: userInfoModel?
    var mere: String?
    var proceeding: [proceedingModel]?
    var ordered: proceedingModel?
    var seven: sevenModel?
    var intervening: inteModel?
    var ventured: Int?
    var warbler: [warblerModel]?
    var scattered: [scatteredModel]?
    var intruding: [intrudingModel]?
    
    enum CodingKeys: String, CodingKey {
        case future, postpone, visual, heroic, safe, userInfo, mere, proceeding
        case ordered, seven, intervening, ventured, warbler, scattered, intruding
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        future = try? container.decode(String.self, forKey: .future)
        postpone = try? container.decode(postponeModel.self, forKey: .postpone)
        visual = try? container.decode([visualModel].self, forKey: .visual)
        heroic = try? container.decode(String.self, forKey: .heroic)
        safe = try? container.decode(String.self, forKey: .safe)
        userInfo = try? container.decode(userInfoModel.self, forKey: .userInfo)
        mere = try? container.decode(String.self, forKey: .mere)
        proceeding = try? container.decode([proceedingModel].self, forKey: .proceeding)
        seven = try? container.decode(sevenModel.self, forKey: .seven)
        intervening = try? container.decode(inteModel.self, forKey: .intervening)
        ventured = try? container.decode(Int.self, forKey: .ventured)
        warbler = try? container.decode([warblerModel].self, forKey: .warbler)
        scattered = try? container.decode([scatteredModel].self, forKey: .scattered)
        intruding = try? container.decode([intrudingModel].self, forKey: .intruding)
        
        if let singleObject = try? container.decode(proceedingModel.self, forKey: .ordered) {
            ordered = singleObject
        } else if let arrayValue = try? container.decode([proceedingModel].self, forKey: .ordered) {
            ordered = arrayValue.first
        } else {
            ordered = nil
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try? container.encode(future, forKey: .future)
        try? container.encode(postpone, forKey: .postpone)
        try? container.encode(visual, forKey: .visual)
        try? container.encode(heroic, forKey: .heroic)
        try? container.encode(safe, forKey: .safe)
        try? container.encode(userInfo, forKey: .userInfo)
        try? container.encode(mere, forKey: .mere)
        try? container.encode(proceeding, forKey: .proceeding)
        try? container.encode(seven, forKey: .seven)
        try? container.encode(intervening, forKey: .intervening)
        try? container.encode(ventured, forKey: .ventured)
        try? container.encode(warbler, forKey: .warbler)
        try? container.encode(scattered, forKey: .scattered)
        try? container.encode(intruding, forKey: .intruding)
        
        try? container.encode(ordered, forKey: .ordered)
    }
}

class postponeModel: Codable {
    var observers: String?
    var fortunate: String?
    var questions: String?
    var denying: String?
}

class visualModel: Codable {
    var cut: String?
    var likely: String?
    var mere: String?
    var mind: String?
    var intervening: [interveningModel]?
    var pine: String?
    var pitch: String?
    var stayed: String?
    var months: String?
    var wood: String?
    var keep: String?
    var edge: String?
    var sentinel: String?
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

class userInfoModel: Codable {
    var phone: String?
    enum CodingKeys: String, CodingKey {
        case phone = "self"
    }
}

class proceedingModel: Codable {
    var likely: String?
    var birch: String?
    var widowed: Int?
    var sapling: String?
    var leafy: String?
}

class sevenModel: Codable {
    var accustomed: String?
    var sit: String?
    var pine: String?
    var pitch: String?
    var months: String?
    var motionless: String?
}

class inteModel: Codable {
    var kingbirds: String?
    var driving: String?
    var user_info: userModel?
}

class userModel: Codable {
    var somewhere: String?
    var left: String?
    var quarter: String?
}

class warblerModel: Codable {
    var whence: String?
    var provokingly: String?
    var remains: String?
}

class scatteredModel: Codable {
    var likely: String?
    var birch: String?
    var remains: String?
    var pausing: String?
    var speed: [speedModel]?
    var trunk: String?
    var cut: String?
    var real: Int?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        likely = try container.decodeIfPresent(String.self, forKey: .likely)
        birch = try container.decodeIfPresent(String.self, forKey: .birch)
        remains = try container.decodeIfPresent(String.self, forKey: .remains)
        pausing = try container.decodeIfPresent(String.self, forKey: .pausing)
        speed = try container.decodeIfPresent([speedModel].self, forKey: .speed)
        trunk = try container.decodeIfPresent(String.self, forKey: .trunk)
        real = try container.decodeIfPresent(Int.self, forKey: .real)
        
        if let stringValue = try? container.decodeIfPresent(String.self, forKey: .cut) {
            cut = stringValue
        } else if let intValue = try? container.decodeIfPresent(Int.self, forKey: .cut) {
            cut = String(intValue)
        } else {
            cut = nil
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(likely, forKey: .likely)
        try container.encodeIfPresent(birch, forKey: .birch)
        try container.encodeIfPresent(remains, forKey: .remains)
        try container.encodeIfPresent(pausing, forKey: .pausing)
        try container.encodeIfPresent(speed, forKey: .speed)
        try container.encodeIfPresent(trunk, forKey: .trunk)
        try container.encodeIfPresent(cut, forKey: .cut)
        try container.encodeIfPresent(real, forKey: .real)
    }
    
    enum CodingKeys: String, CodingKey {
        case likely, birch, remains, pausing, speed, trunk, cut, real
    }
}

class speedModel: Codable {
    var alive: String?
    var cut: String?
    enum CodingKeys: String, CodingKey {
        case alive
        case cut
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.alive = try? container.decode(String.self, forKey: .alive)
        if let intValue = try? container.decode(Int.self, forKey: .cut) {
            self.cut = String(intValue)
        } else {
            self.cut = try? container.decode(String.self, forKey: .cut)
        }
    }
}

class intrudingModel: Codable {
    var drove: String?
    var alive: String?
    var seeming: String?
    var likely: String?
    var action: String?
    var flew: String?
    var arrival: String?
    var wait: String?
    var speed: [speedModel]?
}
