//
//  TabShape .swift
//  Custom_TabBar
//
//  Created by Joey Wiryawan on 15/05/23.
//

import SwiftUI

struct TabShape_: Shape {
    var midpoint: CGFloat
    func path(in rect: CGRect) -> Path {
        return Path {
            path in
            path.addPath(Rectangle().path(in: rect))
            path.move(to: .init(x: midpoint - 60, y: 0 ))
            
            let to = CGPoint(x: midpoint, y: -25)
            let control1 = CGPoint(x: midpoint - 25, y: 0)
            let control2 = CGPoint(x: midpoint - 25, y: -25)
            
            path.addCurve(to: to, control1: control1, control2:
            control2)
            
            let to1 = CGPoint(x: midpoint + 60, y: 0)
            let control3 = CGPoint(x: midpoint + 25, y: -25)
            let control4 = CGPoint(x: midpoint + 25, y: 0)
            
            path.addCurve(to: to1, control1: control3, control2:
            control4)
        }
    }
}


