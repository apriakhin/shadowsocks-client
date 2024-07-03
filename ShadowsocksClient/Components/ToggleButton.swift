//
//  ToggleButton.swift
//  ShadowsocksClient
//
//  Created by Anton Priakhin on 13.06.2024.
//

import SwiftUI

struct ToggleButton: View {
  var isAnimating: Bool
  var action: () -> Void
  
  var body: some View {
    ZStack {
      PulsationView(isAnimating: isAnimating)
      
      Button(action: action) {
        ZStack {
          Circle()
            .fill(Constants.color)
            .frame(width: Constants.backgroundSize, height: Constants.backgroundSize)
          
          Image(systemName: "power")
            .resizable()
            .frame(width: Constants.imageSize, height: Constants.imageSize)
            .foregroundStyle(.background)
        }
      }
      .buttonStyle(.plain)
    }
  }
}

#Preview {
  ToggleButton(isAnimating: false, action: {})
}

// MARK: - Private

private enum Constants {
  static var duration: Double { 6.0 }
  static var color: Color { .accent }
#if os(iOS)
  static var backgroundSize: CGFloat { 140 }
  static var imageSize: CGFloat { 32 }
#else
  static var backgroundSize: CGFloat { 108 }
  static var imageSize: CGFloat { 24 }
#endif
}

private struct PulsationView: View {
  @State private var animationProcess1 = false
  @State private var animationProcess2 = false
  @State private var animationProcess3 = false
  @State private var timer1: Timer?
  @State private var timer2: Timer?
  
  var isAnimating: Bool
  
  var body: some View {
    ZStack {
      Circle()
        .fill(Constants.color)
        .frame(width: Constants.backgroundSize, height: Constants.backgroundSize)
        .pulsation(isAnimating: animationProcess1, duration: Constants.duration)
      
      Circle()
        .fill(Constants.color)
        .frame(width: Constants.backgroundSize, height: Constants.backgroundSize)
        .pulsation(isAnimating: animationProcess2, duration: Constants.duration)
      
      Circle()
        .fill(Constants.color)
        .frame(width: Constants.backgroundSize, height: Constants.backgroundSize)
        .pulsation(isAnimating: animationProcess3, duration: Constants.duration)
    }
    .onChange(of: isAnimating, initial: false) {
      if isAnimating {
        startRepeating()
      } else {
        stopRepeating()
      }
    }
  }
  
  private func startRepeating() {
    animationProcess1 = true
    
    timer1 = Timer.scheduledTimer(withTimeInterval: Constants.duration / 3, repeats: false) { _ in
      animationProcess2 = true
    }
    
    timer2 = Timer.scheduledTimer(withTimeInterval: Constants.duration * 2/3, repeats: false) { _ in
      animationProcess3 = true
    }
  }
  
  private func stopRepeating() {
    animationProcess1 = false
    animationProcess2 = false
    animationProcess3 = false
    
    timer1?.invalidate()
    timer2?.invalidate()
  }
}

private struct PulsationValue {
  var scale = 1.0
  var opacity = 1.0
}

private struct PulsationModifier: ViewModifier {
  var isAnimating: Bool
  var duration: Double
  
  func body(content: Content) -> some View {
    if isAnimating {
      content
        .keyframeAnimator(initialValue: PulsationValue(), repeating: true) { view, value in
          view
            .scaleEffect(x: value.scale, y: value.scale)
            .opacity(value.opacity)
          
        } keyframes: { _ in
          KeyframeTrack(\.scale) {
            LinearKeyframe(1.5, duration: duration, timingCurve: .circularEaseOut)
          }
          
          KeyframeTrack(\.opacity) {
            LinearKeyframe(0, duration: duration, timingCurve: .circularEaseOut)
          }
        }
    } else {
      content
    }
  }
}

fileprivate extension View {
  func pulsation(isAnimating: Bool, duration: Double) -> some View {
    self.modifier(PulsationModifier(isAnimating: isAnimating, duration: duration))
  }
}
