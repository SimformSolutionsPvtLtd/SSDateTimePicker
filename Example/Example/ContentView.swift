//
//  ContentView.swift
//  Example
//
//  Created by Rizwana Desai on 22/11/23.
//

import SwiftUI
import DateTimePicker

struct ContentView: View {
    var body: some View {
        VStack {
           Text("Example")
            CalenderView()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
