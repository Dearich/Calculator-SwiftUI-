//
//  ButtonType.swift
//  Calculator
//
//  Created by Азизбек on 04.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import SwiftUI

enum ButtonsType: String {
    case zero, one , two, three, four, five
    case six, seven, eight, nine, plus
    case minus, multiply, divide, ac
    case plusMinus, persent, equals, dot
    
    var title: String {
        switch self {
        case .zero:         return "0"
        case .one:          return "1"
        case .two:          return "2"
        case .three:        return "3"
        case .four:         return "4"
        case .five:         return "5"
        case .six:          return "6"
        case .seven:        return "7"
        case .eight:        return "8"
        case .nine:         return "9"
            
        case .plus:         return "+"
        case .minus:        return "-"
        case .multiply:     return "×"
        case .divide:       return "÷"
        case .ac:            return "AC"
        case .plusMinus:    return "±"
        case .persent:      return "%"
        case .equals:       return "="
        case .dot:          return ","
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .equals:
            return Color(UIColor(red: 255/255, green: 150/255, blue: 0/255, alpha: 1))
        case .divide:
            return Color(UIColor(red: 255/255, green: 150/255, blue: 0/255, alpha: 1))
        case .plus:
            return Color(UIColor(red: 255/255, green: 150/255, blue: 0/255, alpha: 1))
        case .minus:
            return Color(UIColor(red: 255/255, green: 150/255, blue: 0/255, alpha: 1))
        case .multiply:
            return Color(UIColor(red: 255/255, green: 150/255, blue: 0/255, alpha: 1))
            
        case .ac:
            return Color(UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1))
        case .plusMinus:
            return Color(UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1))
        case .persent:
            return Color(UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1))
        default:
            return Color(UIColor(red: 31/255, green: 31/255, blue: 31/255, alpha: 1))
        }
    }
    
    var textColor: Color {
        switch self {
        case .ac, .plusMinus, .persent:
            return Color(.black)
        default:
            return Color(.white)
        }
    }
}
