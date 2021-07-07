//
//  MovingModel.swift
//  StarPathAnimation
//
//  Created by Rakesh salian on 07/07/21.
//

import SwiftUI
import Accelerate
import Combine

class MovingModel: ObservableObject {
    let track: ParametricCurve
    let path: Path
    var clyodModel: some View {
        let t = track.curveParameter(arcLength: alongTrackDistance)
        let p = track.point(t: t)
        let dp = track.derivate(t: t)
        let h = Angle(radians: atan2(Double(dp.dy), Double(dp.dx)))
        return Circle().font(.largeTitle).frame(width: 10, height: 10, alignment: .topLeading).rotationEffect(h).position(p).foregroundColor(.red)
    }
    @Published var alongTrackDistance = CGFloat.zero
    init(from: CGPoint, to: CGPoint, control1: CGPoint, control2: CGPoint) {
        track = Bezier3(from: from, to: to, control1: control1, control2: control2)
        path = Path({ (path) in
            path.move(to: from)
            path.addCurve(to: to, control1: control1, control2: control2)
            //path.addQuadCurve(to: to, control: control1)
        })
        //path = Arc(from:from, to: to,startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true).path(in: CGRect(x: 0, y: 0, width: 300, height: 300))
        
    }
    
    @Published var flying = false
    @Published var reverseFlying = false
    
    var timer: Cancellable? = nil
    
    func fly() {
        
        flying = true
        timer = Timer
            .publish(every: TimeInterval(0.01), on: RunLoop.main, in: RunLoop.Mode.default)
            .autoconnect()
            .sink(receiveValue: { (_) in
                
                if self.reverseFlying {
                    self.alongTrackDistance -= self.track.totalArcLength / 200.0
                } else {
                    self.alongTrackDistance += self.track.totalArcLength / 200.0
                }
                if self.alongTrackDistance > self.track.totalArcLength {
                    self.reverseFlying = true
                } else {
                    if self.alongTrackDistance <= 0 {
                        self.reverseFlying = false
                    }
                }
                
                print(self.alongTrackDistance)
            })
    }
    
    
}

struct Arc: Shape {
    var from : CGPoint
    var to : CGPoint
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        // path.move(to: from)
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        
        return path
    }
}
