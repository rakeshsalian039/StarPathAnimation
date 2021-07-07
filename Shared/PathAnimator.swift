//
//  PathAnimator.swift
//  StarPathAnimation
//
//  Created by Rakesh salian on 07/07/21.
//

//
//  Accelarate.swift
//  RSAnimaion
//
//  Created by Rakesh salian on 6/26/21.
//

import SwiftUI

//Global Variable
let width : CGFloat = 300
let cX : CGFloat = width/2

struct PathAnimator: View {
    
    let delay : Int
    @State var show: Bool = false
    @ObservedObject var cylod = MovingModel(from: .init(x: cX, y: 0), to: .init(x: cX, y: width), control1: .init(x: cX/2, y: 100), control2: .init(x: cX/2, y: 100))
    
    
    @State var strokeEnd: CGFloat = 0
    var body: some View {
        
        ZStack {
            
            cylod.path
                .trim(from: 0, to: strokeEnd)
                .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .miter, miterLimit: 4))
            cylod.clyodModel
            
        }.frame(width: 300, height: 300, alignment: .center)
        .onAppear {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1) ) {
                show = true
                fly()
            }
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                self.strokeEnd = 0
                withAnimation(Animation.easeOut(duration: 2)) {
                    self.strokeEnd = 1
                }
            }
        }
    }
    
    func fly() {
        cylod.fly()
    }
}


struct PathAnimator_Previews: PreviewProvider {
    static var previews: some View {
        PathAnimator(delay: 2)
    }
}

