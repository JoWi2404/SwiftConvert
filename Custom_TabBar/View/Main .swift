//
//  Main .swift
//  Custom_TabBar
//
//  Created by Joey Wiryawan on 15/05/23.
//

import SwiftUI

struct Main_: View {
    
    @State private var activeTab: Tab = .tab_length
    @Namespace private var animation
   
    var screenHeight = UIScreen.main.bounds.height
    var body: some View {
        VStack{
            ZStack(){
                TabView(selection: $activeTab) {
                    LengthConvert()
                        .tag(Tab.tab_length)
                        .toolbar(.hidden, for: .tabBar)
                    TemperatureConverter()
                        .tag(Tab.tab_temp)
                        .toolbar(.hidden, for: .tabBar)
                    APIConvert()
                        .tag(Tab.tab_currency)
                        .toolbar(.hidden, for: .tabBar)
                }
                
                CustomTabBar()
//                                .frame(maxWidth: .infinity)
                                .position(x:193,y:screenHeight/4*3.5)
                //                .frame(height: screenHeight/8)
//                    .position(x: 190, y: 730)
                //            VStack{
                //
                //            }.frame(width: 800, height: 200)
                //                .background(.primary).position(x: 100, y: 750)
            }.padding(.bottom, -10)
        }
    }
    
    @ViewBuilder
    func CustomTabBar(_ tint: Color = Color("blue"), _ inactiveTint: Color = .blue) -> some View {
        HStack(alignment: .bottom, spacing : 0){
            ForEach(Tab.allCases, id: \.rawValue) {
                TabItem(
                    tint: tint,
                    inactiveTint: inactiveTint,
                    tab: $0,
                    animation : animation,
                    activeTab: $activeTab
                )
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: activeTab)
    }
}

struct TabItem: View {
    var tint : Color
    var inactiveTint: Color
    var tab: Tab
    var animation: Namespace.ID
    @Binding var activeTab : Tab
    
    
    @State private var tabPosition: CGFloat = .zero
    var body: some View {
        VStack(spacing: 5){
            Image(systemName: tab.systemImage)
                .font(.title2)
                .foregroundColor(activeTab == tab ? .white : inactiveTint)
                .frame(width: activeTab == tab ? 58 : 35, height: activeTab == tab ? 58 : 35)
                .background{
                    if activeTab == tab{
                        Circle()
                            .fill(tint.gradient)
                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                    }
                }
            Text(tab.rawValue)
                .font(.caption)
                .foregroundColor(activeTab == tab ? tint : .gray)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())

        .onTapGesture {
            activeTab = tab
        }
    }
}

struct Main__Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
