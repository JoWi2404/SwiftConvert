//
//  LengthConvert.swift
//  Custom_TabBar
//
//  Created by Joey Wiryawan on 16/05/23.
//

import SwiftUI

struct LengthConvert: View {
    @State private var isClicked = false
//    @State private var
    @State private var inputValue = ""
    @State private var inputUnit = 0
    @State private var outputUnit = 1
    @State private var result:Double = 0
    
    //Selection
    let units = ["Meters", "Feet", "Inches"]
    
    var convertedValue: Double {
        let inputMeasurement = Measurement(value: Double(inputValue) ?? 0, unit: inputUnit == 0 ? UnitLength.meters : inputUnit == 1 ? UnitLength.feet : UnitLength.inches)
        return inputMeasurement.converted(to: outputUnit == 0 ? UnitLength.meters : outputUnit == 1 ? UnitLength.feet : UnitLength.inches).value
    }
    var body: some View {
        NavigationStack{
            Form {
                //Input Amount
                Section(header: Text("Input")) {
                    TextField("Value", text: $inputValue)
                        .keyboardType(.decimalPad)
                        .listRowSeparator(.hidden)
                    Picker(selection: $inputUnit, label: Text("Unit")) {
                        ForEach(0..<units.count) {
                            Text(self.units[$0]).tag($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Output Unit")){
                    Picker(selection: $outputUnit, label: Text("Unit")) {
                        ForEach(0..<units.count) {
                            Text(self.units[$0]).tag($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Button{
                    result =  convertedValue
//                    isClicked = true
                    hideKeyboard()
                } label: {
                    Text("Convert!")
                        .frame(maxWidth: .infinity)
                        .font(.title2)
                }.disabled(inputValue.isEmpty)
                //Output Amount
                Section(header: Text("Result")) {
                    Text("\(result)")
//                    if isClicked == true {
//                        Text("\(convertedValue, specifier: "%.2f") \(units[outputUnit])")
//                    } else {
//                        Text("Please input Output Unit").foregroundColor(Color.secondary)
//                    }
                }
            }
            .navigationTitle("Length Converter")
        }
        .navigationBarTitleDisplayMode(.inline)
//        .preferredColorScheme(.dark)
    }
}
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
struct LengthConvert_Previews: PreviewProvider {
    static var previews: some View {
        LengthConvert()
    }
}
