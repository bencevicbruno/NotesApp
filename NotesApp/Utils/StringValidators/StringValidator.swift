//
//  StringValidator.swift
//  NotesApp
//
//  Created by Bruno Bencevic on 14.03.2023..
//

import Foundation

protocol StringValidator {
    func isValid(_ string: String) -> Bool
}

struct LengthValidator: StringValidator {
    let minLength: Int
    let maxLength: Int
    
    init(min minLength: Int = 0, max maxLength: Int = .max) {
        self.minLength = minLength
        self.maxLength = maxLength
    }
    
    func isValid(_ string: String) -> Bool {
        return string.count >= minLength && string.count <= maxLength
    }
}

struct CaseValidator: StringValidator {
    enum CaseType {
        case lowercase
        case uppercase
        case mixed
    }
    
    let caseType: CaseType
    
    init(_ caseType: CaseType = .mixed) {
        self.caseType = caseType
    }
    
    func isValid(_ string: String) -> Bool {
        switch caseType {
        case .lowercase:
            return string.lowercased() == string
        case .uppercase:
            return string.uppercased() == string
        case .mixed:
            return true
        }
    }
}

struct TypeValidator: StringValidator {
    enum TypeType {
        case string
        case number
        case integer
    }
    
    let typeType: TypeType
    
    init(_ typeType: TypeType) {
        self.typeType = typeType
    }
    
    func isValid(_ string: String) -> Bool {
        switch typeType {
        case .string:
            return true
        case .number:
            return Int(string) != nil || (Float(string) != nil && Double(string) != nil)
        case .integer:
            return Int(string) != nil
        }
    }
}
