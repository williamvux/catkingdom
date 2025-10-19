//
//  UIView+Anchors.swift
//  CatKingdom
//
//  Created by William on 19/10/25.
//


import UIKit

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                leading: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeading: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingTrailing: CGFloat = 0) {
        
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: paddingLeading).isActive = true
        }
        
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -paddingTrailing).isActive = true
        }
    }
    
    func center(of view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func centerX(_ view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop).isActive = true
        }
    }
    
    func centerY(_ view: UIView, leadingAnchor: NSLayoutXAxisAnchor? = nil,
                 paddingLeading: CGFloat = 0, constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        
        if let leading = leadingAnchor {
            anchor(leading: leading, paddingLeading: paddingLeading)
        }
    }
    
    func setSize(_ size: CGSize) {
        self.setSize(height: size.height, width: size.width)
    }
    
    func setSize(height: CGFloat, width: CGFloat) {
        setHeight(height)
        setWidth(width)
    }
    
    func setSize(side: CGFloat) {
        setSize(height: side, width: side)
    }
    
    func setHeight(_ height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height == 0 ? 0 : height).isActive = true
    }
    
    func setWidth(_ width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width == 0 ? 0 : width).isActive = true
    }
    
    func fillSuperview(safeArea: Bool) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let view = superview else { return }
        if safeArea {
            self.anchor(
                top: view.safeAreaLayoutGuide.topAnchor,
                leading: view.safeAreaLayoutGuide.leadingAnchor,
                bottom: view.safeAreaLayoutGuide.bottomAnchor,
                trailing: view.safeAreaLayoutGuide.trailingAnchor
            )
        } else {
            self.anchor(
                top: view.topAnchor,
                leading: view.leadingAnchor,
                bottom: view.bottomAnchor,
                trailing: view.trailingAnchor
            )
        }
    }
    
    func fillSuperview(padding: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let view = superview else { return }
        self.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            paddingTop: padding,
            paddingLeading: padding,
            paddingBottom: padding,
            paddingTrailing: padding
        )
    }
    
    func fillSuperview(vertical: CGFloat = 0, horizontal: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let view = superview else { return }
        self.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            paddingTop: vertical,
            paddingLeading: horizontal,
            paddingBottom: vertical,
            paddingTrailing: horizontal
        )
    }
    
    func fillSuperview(top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let view = superview else { return }
        self.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            paddingTop: top,
            paddingLeading: leading,
            paddingBottom: bottom,
            paddingTrailing: trailing
        )
    }
    
    func addSubviews(_ views: UIView...) {
        
        views.forEach {
            
            self.addSubview($0)
        }
        
    }
    
}

