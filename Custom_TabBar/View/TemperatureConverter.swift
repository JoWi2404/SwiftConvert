//
//  TemperatureConverter.swift
//  Custom_TabBar
//
//  Created by Joey Wiryawan on 16/05/23.
//

import SwiftUI

struct TemperatureConverter: View {
    
    @State private var inputTemperature = ""
    @State private var inputUnit = 0
    @State private var outputUnit = 1
    @State private var result:Double = 0
    var converting: Measurement<UnitTemperature> {
        return Measurement(value: 0, unit: UnitTemperature.celsius)
    }
    //Array
    let units = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var convertedTemperature: Double {
        let input = Double(inputTemperature) ?? 0
        
        switch (inputUnit, outputUnit) {
            //0 = Celsius , 1 = Fahrenheit
        case (0, 1):
            return input * 9/5 + 32
            //0 = Celsius , 2 = Kelvin
        case (0, 2):
            return input + 273.15
            //1 = Fahrenheit , 0 = Celsius
        case (1, 0):
            return (input - 32) * 5/9
            //1 = Fahrenheit , 2 = Kelvin
        case (1, 2):
            return (input - 32) * 5/9 + 273.15
            //2 = Kelvin , 0 = Celsius
        case (2, 0):
            return input - 273.15
            //2 = Kelvin , 1 = Fahrenheit
        case (2, 1):
            return (input - 273.15) * 9/5 + 32
            //if the selected unit is the same
        default:
            return input
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                //Input Section
                Section(header: Text("Input")) {
                    TextField("Temperature", text: $inputTemperature)
                        .keyboardType(.decimalPad)
                    Picker("Unit", selection: $inputUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                //Output Section
                Section(header: Text("Output")) {
                    Picker("Unit", selection: $outputUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                    Button{
                        result =  convertedTemperature
                        //                    isClicked = true
                        hideKeyboard()
                    } label: {
                        Text("Convert!")
                            .frame(maxWidth: .infinity)
                            .font(.title2)
                    }.disabled(inputTemperature.isEmpty)
                    //Output Amount
                    Section(header: Text("Result")) {
                        Text("\(result)")
                    }
                }
                .navigationTitle("Temperature Converter")
            }
            .navigationBarTitleDisplayMode(.inline)
            //        .preferredColorScheme(.dark)
        }
    }


struct TemperatureConverter_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureConverter()
    }
}
