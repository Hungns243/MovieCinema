//
//  CustomSegmentedControl.swift
//  Cinema2
//
//  Created by BeeCon on 18/5/25.
//

import UIKit

protocol CustomSegmentedControlDelegate: AnyObject {
    func segmentChanged(to index: Int)
}

class CustomSegmentedControl: UIView {

    private let stackView = UIStackView()
    private var buttons: [UIButton] = []
    private let underlineView = UIView()
    private var selectedIndex: Int = 0

    weak var delegate: CustomSegmentedControlDelegate?

    var titles: [String] = [] {
        didSet {
            setupButtons()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
        setupUnderline()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
        setupUnderline()
    }

    private func setupStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupUnderline() {
        underlineView.backgroundColor = UIColor.systemBlue
        
        addSubview(underlineView)
    }

    private func setupButtons() {
        buttons.forEach { $0.removeFromSuperview() }
        buttons.removeAll()

        for (index, title) in titles.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(index == selectedIndex ? .white : .lightGray, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }

        layoutIfNeeded()
        updateUnderlinePosition(animated: false)
    }

    @objc private func buttonTapped(_ sender: UIButton) {
        let index = sender.tag
        selectSegment(at: index)
        delegate?.segmentChanged(to: index)
    }

    func selectSegment(at index: Int) {
        selectedIndex = index
        for (i, button) in buttons.enumerated() {
            button.setTitleColor(i == index ? .white : .lightGray, for: .normal)
        }
        updateUnderlinePosition(animated: true)
    }

    private func updateUnderlinePosition(animated: Bool) {
        guard selectedIndex < buttons.count else { return }
        let selectedButton = buttons[selectedIndex]
        let underlineHeight: CGFloat = 3

        let targetFrame = CGRect(
            x: selectedButton.frame.origin.x + 10,
            y: frame.height - underlineHeight,
            width: selectedButton.frame.width - 20,
            height: underlineHeight
        )

        if animated {
            UIView.animate(withDuration: 0.3) {
                self.underlineView.frame = targetFrame
            }
        } else {
            underlineView.frame = targetFrame
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateUnderlinePosition(animated: false)
    }
}
