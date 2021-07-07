//
//  StarPathView.swift
//  StarPathAnimation
//
//  Created by Rakesh salian on 07/07/21.
//

import SwiftUI

struct StarPathView: View {
    @State private var rotating = false
    @State private var scale = false
    static let rotationCount = 10
        
        var lineSymbols: some View {
            ForEach(0..<StarPathView.rotationCount) { i in
                let ratio = Double(i)  / Double(StarPathView.rotationCount)
                //let angle : Double = Double(i) * 22.5
                RotatedLines(
                    angle: .degrees(ratio * 360.0),
                    delay:  1//Int(ratio * 50)
                )
            }
            .opacity(1)
        }
    
    var body: some View {
        ZStack {
                    GeometryReader { geometry in
                        lineSymbols
                    }
                }
        .onAppear {
            self.rotating = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2 ) {
                scale = true
            }
        }
        .frame(width: 300, height: 300, alignment: .center)
        //.scaledToFit()
    }
}

struct StarPathView_Previews: PreviewProvider {
    static var previews: some View {
        StarPathView()
    }
}
