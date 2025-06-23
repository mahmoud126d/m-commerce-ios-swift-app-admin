//
//  Toast.swift
//  Shoplet-Admin
//
//  Created by Macos on 23/06/2025.
//

import SwiftUI


struct ToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    var message: String
    var duration: TimeInterval = 2.0

    func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                VStack {
                    Spacer()
                    Text(message)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black.opacity(0.9))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                                withAnimation {
                                    isPresented = false
                                }
                            }
                        }
                }
                .animation(.easeInOut, value: isPresented)
            }
        }
    }
}


extension View {
    func toast(isPresented: Binding<Bool>, message: String, duration: TimeInterval = 2.0) -> some View {
        self.modifier(ToastModifier(isPresented: isPresented, message: message, duration: duration))
    }
}
