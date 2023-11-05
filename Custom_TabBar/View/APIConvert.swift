//
//  APIConvert.swift
//  Custom_TabBar
//
//  Created by Joey Wiryawan on 16/05/23.
//

import SwiftUI

struct APIConvert: View {
    
    @State var base = ""
    @State var input = ""
    @State var currencyList = [String]()
    @State var isFilled = false
    @FocusState private var inputIsFocused: Bool
    
    func makeRequest(showAll: Bool, currency: [String] = ["IDR", "USD" , "EUR"]){
        apiRequest(url: "https://api.exchangerate.host/latest?base=\(base)&amount=\(input)"){apicurrency in
            
            print("api = \(apicurrency)")
            var tempList = [String]()
            
            for apicurrency in apicurrency.rates{
                if showAll {
                    tempList.append("\(apicurrency.key) = \(String(format: "%.2f", apicurrency.value))")
                }else if currency.contains(apicurrency.key){
                    tempList.append("\(apicurrency.key)\(String(format: "%.2f", apicurrency.value))")
                }
                tempList.sort()
            }
            currencyList.self = tempList
            print(tempList)
        }
    }
    
    
    var body: some View {
        VStack{
            HStack{
                Text("Currency Convert")
                    .font(.title)
                    .bold()
                Image(systemName: "dollarsign.arrow.circlepath")
                    .font(.system(size : 30))
                    .foregroundColor(.blue)
            }
            //List to all the Currency
            List{
                ForEach(currencyList, id: \.self) { apircurrency in
                    Text(apircurrency)
                        .padding()
                }
            }
            
            
            VStack {
                Rectangle()
                    .frame(height : 8.0)
                    .foregroundColor(.blue)
                    .opacity(0.90)
                
                Section{
                    VStack{
                        HStack{
                            Text("Enter Amount")
                                .foregroundColor(Color.gray)
                                .padding(.leading, 30.0)
                                .padding(.bottom, -10)
                        Spacer()
                        }
                        
                        //Amount Text Field
                        TextField("Please Enter Amount", text:$input)
                            .textCase(.uppercase)
                            .padding()
                            .background(Color.gray.opacity(0.10))
                            .cornerRadius(20)
                            .padding()
                            .keyboardType(.decimalPad)
                            .focused($inputIsFocused)
                        HStack{
                            Text("Enter Currency")
                                .foregroundColor(Color.gray)
                                .padding(.leading, 30.0)
                                .padding(.bottom, -10)
//
                        Spacer()
                        }
                        //Currency Text Field
                        TextField("Please Enter Currency", text: $base)
                            .padding()
                            .background(Color.gray.opacity(0.10))
                            .cornerRadius(20)
                            .padding()
                            .focused($inputIsFocused)
                        
                        //Button Convert
                        Button("Let's Convert") {
                            makeRequest(showAll: true)
                            hideKeyboard()
                        }
                        .disabled(base.isEmpty || input.isEmpty)
                        .padding()
                        .background(base.isEmpty || input.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(20)
                        
                        
                        
                        
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            makeRequest(showAll: true)
        }
    }
}

struct APIConvert_Previews: PreviewProvider {
    static var previews: some View {
        APIConvert()
    }
}
