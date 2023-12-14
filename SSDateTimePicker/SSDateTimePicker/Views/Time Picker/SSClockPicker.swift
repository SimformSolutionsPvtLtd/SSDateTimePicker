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
    
    //MARK: - Initializer
    
    init(timePickerManager: SSTimePickerManager) {
        self.timePickerManager = timePickerManager
    }
    
    //MARK: - Body
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                let widthGeo  = reader.frame(in: .global).width/2
                selectionCircle(widthGeo)
                clockHand(widthGeo)
                clockFace(widthGeo)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(height: SSPickerConstants.clockHeight)
    }
    
    //MARK: - Sub views
    
    private func selectionCircle(_ widthGeo: CGFloat) -> some View {
        Circle()
            .fill(clockHandColor)
            .frame(width: SSPickerConstants.circleSize, height: SSPickerConstants.circleSize)
            .offset(x: widthGeo - SSPickerConstants.clockPadding)
            .rotationEffect(.init(degrees: timePickerManager.angle))
            .simultaneousGesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnd(value:)))
            .rotationEffect(.init(degrees: -90))
    }
    
    private func clockFace(_ widthGeo: CGFloat) -> some View {
        ForEach(1...12, id: \.self) { index in
            VStack {
                let time = timePickerManager.isMinuteClock ? index*5 : index
                Text("\(time)")
                    .font(clockNumberFont)
                    .fontWeight(.semibold)
                    .foregroundColor(clockNumberTextColor)
                    .rotationEffect(.init(degrees: Double(-index)*SSPickerConstants.clockNumberRotationDegree))
                    .highPriorityGesture(TapGesture().onEnded {
                        actionClockNumberSelection(number: index)
                    }).allowsHitTesting(isClockNumberTapable("\(time)"))
            }
            .offset(y: -widthGeo+SSPickerConstants.clockPadding)
            .rotationEffect(.init(degrees: Double(index)*SSPickerConstants.clockNumberRotationDegree)) // rotating view : 12*30 = 360
        }
    }
    
    private func clockHand(_ widthGeo: CGFloat) -> some View {
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
    
    //MARK: - Methods
    
    private func clockHandHeight(_ width: CGFloat) -> CGFloat {
        width-SSPickerConstants.clockPadding
    }
    
    // To disable clock number tap gesture when it is already selected to priotize grag gesture
    private func isClockNumberTapable(_ time: String) -> Bool {
        if timePickerManager.isMinuteClock {
            let minute = time == "60" ? "00" : time
            return timePickerManager.minutesSelected != minute
        } else {
            return timePickerManager.hourSelected != time
        }
    }
    
    // To update selected hour/miute when user tap on any of the number on clock
    private func actionClockNumberSelection(number: Int) {
        if timePickerManager.isMinuteClock {
            let minute = number * 5
            timePickerManager.minutesSelected = (minute == 60 ? 0 : minute).formattedTime
            timePickerManager.updateCurrentMinuteAngle()
        } else {
            timePickerManager.hourSelected = number.formattedTime
            timePickerManager.updateCurrentHourAngle()
        }
    }
    
}

//MARK: - Drag gesture methods

extension SSClockPicker {
    
    private func onChanged(value: DragGesture.Value) {
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
            timePickerManager.minutesSelected = Int(progress*60).formattedTime
        }
    }
    
    private func onEnd(value: DragGesture.Value) {
        if !timePickerManager.isMinuteClock {
            // updating hour value
            let hour = Int(timePickerManager.angle / SSPickerConstants.clockNumberRotationDegree)
            timePickerManager.hourSelected = (hour == 0 ? 12 : hour).formattedTime
            // updating picker to minutes
            withAnimation {
                timePickerManager.angle = Double((Int(timePickerManager.minutesSelected) ?? 1) * Int(SSPickerConstants.minuteRotationDegree))
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
