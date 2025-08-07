//
//  ContentView.swift
//  MojoSnake
//
//  Created by Naveen Rana on 20/07/25.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        NavigationStack  {
            GameView()
        }
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .previewDevice("iPhone 13")
        }
    }
