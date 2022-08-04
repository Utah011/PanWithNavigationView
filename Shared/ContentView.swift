//
//  ContentView.swift
//  Shared
//
//  Created by ha$min on 04.08.2022.
//

import SwiftUI

class PanManager: ObservableObject {
    @Published var show: Bool = false
}

struct ContentView: View {
    
    @EnvironmentObject var pm: PanManager
    
    var body: some View {
        ZStack {
            Color.purple
            Text("content view")
                .onTapGesture {
                    withAnimation {
                        pm.show = true
                    }
                }
        }
        .ignoresSafeArea()
            .overlay {
                NewPan {
                    Text("go to next page")
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct NewPan<Content: View>: View {

    @EnvironmentObject var pm: PanManager
    @State var offset: CGFloat = 0
    let content: Content
    let height: CGFloat = 590

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {

        let drag = DragGesture()
            .onChanged { value in
                print("value change \(value.translation.height)")
                if value.translation.height >= 0 {
                    withAnimation(.interactiveSpring()) {
                        offset = value.translation.height

                    }
                }
            }
            .onEnded { value in
                print("value ended \(value.translation.height)")
                if value.translation.height > 120 {
                    withAnimation {
                        offset = 0
                        pm.show = false
                    }
                } else {
                    withAnimation {
                        offset = 0
                    }
                }
            }

        if pm.show {
            VStack {
                Spacer()
                VStack {
                    NavigationView {
                        ZStack {
                            Color.yellow
                            NavigationLink {
                                Text("hello")
                            } label: {
                                content
                            }
                        }
                        .ignoresSafeArea()
                    }
                }
                .frame(height: height)
                .cornerRadius(16)
                .offset(y: offset)
                .gesture(drag)
            }
            .ignoresSafeArea()
//            .transition(.move(edge: .bottom)) //Могу убрать transition(...), тогда тач по пану заработает
        }
    }
}
