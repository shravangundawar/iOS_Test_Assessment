//
//  LoaderView.swift
//  iOSTestAssessment
//
//  Created by Shravan Gundawar on 01/05/24.
//

import Foundation
import UIKit

class LoaderView: UIView {
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .gray
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        backgroundColor = UIColor(white: 0, alpha: 0.3)
        addSubview(activityIndicatorView)
        
        // Center the activity indicator view
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func show() {
        DispatchQueue.main.async { [weak self] in
            self?.isHidden = false
            self?.activityIndicatorView.startAnimating()
        }
    }
    
    func hide() {
        DispatchQueue.main.async { [weak self] in
            self?.isHidden = true
            self?.activityIndicatorView.stopAnimating()
        }
    }
}
