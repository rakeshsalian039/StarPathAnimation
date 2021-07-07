//
//  RotatedLines.swift
//  StarPathAnimation
//
//  Created by Rakesh salian on 07/07/21.
//

import SwiftUI

struct RotatedLines: View {
    let angle: Angle
    let delay: Int
    @State var show: Bool = false
    
    var body: some View {
        PathAnimator(delay: delay)
            .rotationEffect(angle)
            .foregroundColor(.blue)
    }
}

struct RotatedLines_Previews: PreviewProvider {
    static var previews: some View {
        RotatedLines(angle: Angle(degrees: 100), delay: 2)
    }
}
