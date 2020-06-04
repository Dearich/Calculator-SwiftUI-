//
//  ContentView.swift
//  Calculator
//
//  Created by Азизбек on 03.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import SwiftUI



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
            print("YES 1")
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
        
        if firstNumber == 7 && operand == "×" && secondNumber == 6 {
            print("YES 2")
            let storyboard = UIStoryboard(name: "SomeStoryboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "someStoryboard")
            
            if let window = UIApplication.shared.windows.first {
                window.rootViewController  = vc
            }
            
        }
        
        
        if operand == "+" {
            result = firstNumber + secondNumber
        } else if operand == "-" {
            result = firstNumber - secondNumber
        }else if operand == "×" {
            result = firstNumber * secondNumber
        }else if operand == "÷" {
            guard secondNumber != 0 else { return }
            doubleResult = Double(firstNumber) / Double(secondNumber)
        }else if operand == "%" {
            result = Double(firstNumber) / 100.0
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
                
                ForEach(buttonArray, id: \.self) {  (row) in
                    HStack{
                        ForEach(row, id: \.self) { (button) in
                            
                            Button(action: {
                                
                                switch button {
                                case .plus,.minus,.divide, .multiply:
                                    self.operandTapped(button.title)
                                case.persent:
                                    self.operandTapped(button.title)
                                    self.calculate()
                                case .plusMinus:
                                    if self.calculatorText != "0"{
                                        self.calculatorText.insert("-", at: self.calculatorText.startIndex )
                                    }
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
                                    .rotationEffect(Angle(degrees: -45.0))
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
