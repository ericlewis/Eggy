//
//  UIKit+Slider.swift
//  Eggy
//
//  Created by Eric Lewis on 7/9/19.
//  Copyright © 2019 Eric Lewis, Inc. All rights reserved.
//

import SwiftUI

struct SliderControl: UIViewRepresentable {
    var color: UIColor = .systemYellow
    var minValue: Float
    var maxValue: Float
    
    @Binding var value: Double
    
    init(value: Binding<Double>,
         from minValue: Double,
         through maxValue: Double,
         onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        $value = value
        self.minValue = Float(minValue)
        self.maxValue = Float(maxValue)
    }
    
    init(value: Binding<Double>,
         from minValue: Double,
         through maxValue: Double,
         color: UIColor,
         onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        $value = value
        self.minValue = Float(minValue)
        self.maxValue = Float(maxValue)
        self.color = color
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UISlider {
        let control = UISlider()
        control.addTarget(context.coordinator,
                          action: #selector(Coordinator.updateSliderMoved(sender:)), for: .valueChanged)
        control.isContinuous = true
        control.minimumValue = minValue
        control.maximumValue = maxValue
        control.tintColor = self.color
        
        return control
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.setValue(Float(value), animated: true)
    }
    
    class Coordinator: NSObject {
        var control: SliderControl
        
        init(_ control: SliderControl) {
            self.control = control
        }
        
        @objc func updateSliderMoved(sender: UISlider) {
            control.value = Double(sender.value)
        }
    }
}

#if DEBUG
struct UIKit_Slider_Previews : PreviewProvider {
    static var previews: some View {
        SliderControl(value: .constant(1), from: 0.0, through: 1.0, color: .systemYellow, onEditingChanged: { _ in })
    }
}
#endif
