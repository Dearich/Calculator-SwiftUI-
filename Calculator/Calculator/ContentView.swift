//
//  ContentView.swift
//  Calculator
//
//  Created by Азизбек on 03.06.2020.
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
        case .ac:           return "AC"
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

class DisplayTextGlobal: ObservableObject {//создаем класс для отслеживания глобального изменения переменной
    
    @Published var displayText = "0"
    
    
}


struct ContentView: View {
    
    @EnvironmentObject var envText: DisplayTextGlobal
    // создаем экземпляр наблюдаемого объека
    
    @State private var firstNumber = 0.0
    @State private var secondNumber = 0.0
    @State private var operand = ""
    @State private var calculatorText = "0"
    @State private var isTypingNumber = false
    
    let buttonArray: [[ButtonsType]] = [
        [.ac, .plusMinus, .persent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .dot, .equals]
    ]
    
    private func digitTapped(_ number: String) -> Void {
        if isTypingNumber {
            calculatorText += number
        } else {
            
            calculatorText = number
            isTypingNumber = true
        }
    }

    
    private func operandTapped(_ operand: String) {
        isTypingNumber = false
        guard let firstNumber1 = Double(calculatorText) else { return }
        firstNumber = firstNumber1
        self.operand = operand

    }

    
    private func calculate() {
        isTypingNumber = false
        var result  = 0.0
        var doubleResult = 0.0
       
        guard let secondNumber1 = Double(calculatorText) else { return }
        secondNumber = secondNumber1


        if operand == "+" {
            result = firstNumber + secondNumber
        } else if operand == "-" {
            result = firstNumber - secondNumber
        }else if operand == "×" {
            result = firstNumber * secondNumber
        }else if operand == "÷" {
            guard secondNumber != 0 else { return }
            doubleResult = Double(firstNumber) / Double(secondNumber)
        }
        if operand == "÷"{
            calculatorText = "\(doubleResult)"
        } else {
            calculatorText = "\(result)"
        }
        
    }
    
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack(spacing: 12) {

                HStack{
                    Spacer()
                    Text(envText.displayText).foregroundColor(.white)
                        .font(.system(size: 64))
                }.padding()

                ForEach(buttonArray, id: \.self) { (row) in
                    HStack{
                        ForEach(row, id: \.self) {  (button) in

                            Button(action: {
                                
                                switch button {
                                case .plus,.minus,.divide, .multiply:
                                    self.operandTapped(button.title)
                                case .equals:
                                    if self.calculatorText != "0"{
                                        self.calculate()
                                    }else {
                                        self.calculatorText = self.envText.displayText
                                    }
                                    
                                case .ac:
                                    self.calculatorText = "0"
                                    self.isTypingNumber = false
                                    self.envText.displayText = self.calculatorText
                                    self.firstNumber = 0
                                    self.secondNumber = 0
                                case .dot:
                                    if self.calculatorText == "0"{
                                        self.calculatorText.append(".")
                                    }
                                    else{
                                        var indicator = false
                                        for index in self.calculatorText {
                                            if index == "."{ indicator = false; return }
                                            else { indicator = true }
                                        }
                                        if indicator{
                                            self.calculatorText.append(".")
                                        }
                                           
                                        }
                                    
                                default:
                                    self.digitTapped(button.title)
                                }
                                self.envText.displayText = self.calculatorText

                            }) {
                                Text(button.title)
                                    .font(.system(size: 32))
                                    .frame(width: self.buttonSize(button: button), height: (UIScreen.main.bounds.width - 5 * 12 ) / 4)
//                                    .rotationEffect(Angle(degrees: -45.0))
                                    .foregroundColor(button.textColor)
                                    .background(button.backgroundColor)
                                    .cornerRadius(self.buttonSize(button: button))

                            }

                        }
                    }
                }

            }.padding(.bottom)
        }
    }
//    размер кнопок всегда пропорционален экрану
    func buttonSize(button: ButtonsType) -> CGFloat {
        if button == .zero {
            return ((UIScreen.main.bounds.width - 4 * 12 ) / 4) * 2
        }
        
        return (UIScreen.main.bounds.width - 5 * 12 ) / 4
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(DisplayTextGlobal())
    }
}
