//
//  ContentView.swift
//  Example
//
//  Created by Rizwana Desai on 22/11/23.
//

import SwiftUI
import DateTimePicker

struct ContentView: View {
    
    //MARK: - Property
    @State var showCalender: Bool = false
    @State var showThmeCalender: Bool = false

    //MARK: - Body
    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                btnSelectDate
                btnThemePicker
            }
          
            CalenderView(showCalender: $showCalender)
            ThemeCalederView(showCalender: $showThmeCalender)
        }
       
    }
    
    //MARK: - Sub views
    
    var btnSelectDate: some View {
        Button {
            showCalender.toggle()
        } label: {
            Text("Select Date")
        }

    }
    
    var btnThemePicker: some View {
        Button {
            showThmeCalender.toggle()
        } label: {
            Text("Open theme picker")
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
