//
//  SSClockPicker.swift
//  DateTimePicker
//
//  Created by Rizwana Desai on 04/12/23.
//

import SwiftUI

struct SSClockPicker: View, TimePickerConfigurationDirectAccess {
    
    //MARK: - Property
    
    @ObservedObject var timePickerManager: SSTimePickerManager
    private var threeSixtyDegree: CGFloat = 360
    private var oneEightyDegree: CGFloat = 180
    var configuration: SSTimePickerConfiguration {
        timePickerManager.configuration
    }
    
    //MARK: - init
    
    init(timePickerManager: SSTimePickerManager) {
        self.timePickerManager = timePickerManager
    }
    
    //MARK: - Body
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                let widthGeo  = reader.frame(in: .global).width/2
                selectionCircle(widthGeo)
                clockFace(widthGeo)
                clockHand(widthGeo)
                clockFace(widthGeo)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(height: SSPickerConstants.clockHeight)
    }
    
    //MARK: - Sub views
    
    func selectionCircle(_ widthGeo: CGFloat) -> some View {
        Circle()
            .fill(clockHandColor)
            .frame(width: SSPickerConstants.circleSize, height: SSPickerConstants.circleSize)
            .offset(x: widthGeo - SSPickerConstants.clockPadding)
            .rotationEffect(.init(degrees: timePickerManager.angle))
            .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnd(value:)))
            .rotationEffect(.init(degrees: -90))
    }
    
    func clockFace(_ widthGeo: CGFloat) -> some View {
        ForEach(1...12, id: \.self) { index in
            VStack {
                Text("\(timePickerManager.isMinuteClock ? index*5 : index)")
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                    .foregroundColor(clockNumberTextColor)
                    .rotationEffect(.init(degrees: Double(-index)*SSPickerConstants.clockNumberRotationDegree))
            }
            .offset(y: -widthGeo+SSPickerConstants.clockPadding)
            .rotationEffect(.init(degrees: Double(index)*SSPickerConstants.clockNumberRotationDegree)) // rotating view : 12*30 = 360
        }
    }
    
    func clockHand(_ widthGeo: CGFloat) -> some View {
        Circle()
            .fill(clockHandColor)
            .frame(width: SSPickerConstants.paddingTen, height: SSPickerConstants.paddingTen)
            .overlay (
                Rectangle()
                    .fill(clockHandColor)
                    .frame(width: 2, height: clockHandHeight(widthGeo))
                , alignment: .bottom
            )
            .rotationEffect(.init(degrees: timePickerManager.angle))
    }
    
    func clockHandHeight(_ width: CGFloat) -> CGFloat {
        width-SSPickerConstants.clockPadding
    }
    
}

//MARK: - Drag gesture methods

extension SSClockPicker {
    
    func onChanged(value: DragGesture.Value) {
        // getting angle
        let vector = CGVector(dx: value.location.x
                              , dy: value.location.y)
        let radians = atan2(vector.dy, vector.dx)
        var angle = radians * oneEightyDegree / .pi
        if angle < 0 {
            angle = threeSixtyDegree + angle
        }
        timePickerManager.angle = angle
        if !timePickerManager.isMinuteClock {
            // updating angle for hour if the angle is in between hours
            let roundValue = Int(SSPickerConstants.clockNumberRotationDegree) * Int(round(angle/SSPickerConstants.clockNumberRotationDegree))
            timePickerManager.angle = Double(roundValue)
        } else {
            // updating minutes
            let progress = angle / threeSixtyDegree
            timePickerManager.minutes = "\(progress*60)"
        }
    }
    
    func onEnd(value: DragGesture.Value) {
        if !timePickerManager.isMinuteClock {
            // updating hour value
            timePickerManager.hour = "\(Int(timePickerManager.angle / SSPickerConstants.clockNumberRotationDegree))"
            // updating picker to minutes
            withAnimation {
                timePickerManager.angle = Double((Int(timePickerManager.minutes) ?? 1) * Int(SSPickerConstants.minuteRotationDegree))
                timePickerManager.isMinuteClock = true
            }
        }
    }
    
}


struct SSClockPicker_Previews: PreviewProvider {
    static var previews: some View {
        SSClockPicker(timePickerManager: SSTimePickerManager(configuration: SSTimePickerConfiguration()))
    }
}
