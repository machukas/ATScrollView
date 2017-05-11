//
//  ATScrollView.swift
//  ATScrollView
//
//  Created by Nicolas Landa on 10/5/17.
//  Copyright © 2017 Nicolas Landa. All rights reserved.
//

import UIKit

/**

	Una vez instanciada:

	1. Establecer la vista cabecera con la función `setHeaderView`
	2. Establecer la vista contenido del scrollView con la función `setContentView`
	3. Si se desea escuchar los eventos del `scrollView`, establecer delegado mediante la función `setScrollViewDelegate`

	Se pueden configurar:

	* Altura máxima de la cabecera --> `maxHeaderHeight`
	* Altura mínima de la cabecera --> `minHeaderHeight`

*/
open class ATScrollView: UIView {
	
	/// Delegado asignado por el usuario
	fileprivate var userDelegate: UIScrollViewDelegate?
	
	fileprivate var previousScrollOffset: CGFloat = 0.0
	
	// MARK:- Configuration
	
	/// Máxima altura de la cabecera
	var maxHeaderHeight: CGFloat = 200
	
	/// Mínima altura de la cabecera
	var minHeaderHeight: CGFloat = 50
	
	// MARK:- IBOutlets
	
	/// Vista que contiene la cabecera
	fileprivate var headerView: UIView!
	
	/// ScrollView
	fileprivate var scrollView: UIScrollView!
	
	/// Contenido del ScrollView
	fileprivate var scrollViewContentView: UIView!
	
	// MARK:- IBConstraints
	
	/// Restricción altura de la cabecera
	fileprivate var headerHeightConstraint: NSLayoutConstraint!
	
	// MARK:- Initialization
	
	required override public init(frame: CGRect) {
		super.init(frame: frame)
		
		self.initSubviews()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		self.initSubviews()
	}
	
	private func initSubviews() {
		
		self.initHeaderView()
		self.initScrollView()
		self.initScrollViewContentView()
		
		self.scrollView.delegate = self
		
	}
	
	private func initHeaderView() {
		
		self.headerView = UIView()
		self.headerView.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(self.headerView)
		
		let topConstraint = NSLayoutConstraint(item: headerView, attribute: .top, relatedBy: .equal,
		                                       toItem: self, attribute: .top,
		                                       multiplier: 1.0, constant: 0.0)
		
		let leftConstraint = NSLayoutConstraint(item: headerView, attribute: .leading, relatedBy: .equal,
		                                        toItem: self, attribute: .leading,
		                                        multiplier: 1.0, constant: 0.0)
		
		let rightConstraint = NSLayoutConstraint(item: headerView, attribute: .trailing, relatedBy: .equal,
		                                         toItem: self, attribute: .trailing,
		                                         multiplier: 1.0, constant: 0.0)
		
		topConstraint.isActive = true
		leftConstraint.isActive = true
		rightConstraint.isActive = true
		
		self.headerHeightConstraint = NSLayoutConstraint(item: headerView, attribute: .height, relatedBy: .equal,
		                                                 toItem: nil, attribute: .height,
		                                                 multiplier: 1.0, constant: self.maxHeaderHeight)
		self.headerHeightConstraint.isActive = true
		
	}
	
	private func initScrollView() {
		self.scrollView = UIScrollView()
		self.scrollView.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(self.scrollView)
		
		let topConstraint = NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal,
		                                       toItem: headerView, attribute: .bottom,
		                                       multiplier: 1.0, constant: 0.0)
		
		let leftConstraint = NSLayoutConstraint(item: scrollView, attribute: .leading, relatedBy: .equal,
		                                        toItem: self, attribute: .leading,
		                                        multiplier: 1.0, constant: 0.0)
		
		let rightConstraint = NSLayoutConstraint(item: scrollView, attribute: .trailing, relatedBy: .equal,
		                                         toItem: self, attribute: .trailing,
		                                         multiplier: 1.0, constant: 0.0)
		
		let bottomConstraint = NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal,
		                                          toItem: self, attribute: .bottom,
		                                          multiplier: 1.0, constant: 0.0)
		
		topConstraint.isActive = true
		bottomConstraint.isActive = true
		leftConstraint.isActive = true
		rightConstraint.isActive = true
	}
	
	private func initScrollViewContentView() {
		
		self.scrollViewContentView = UIView()
		self.scrollViewContentView.translatesAutoresizingMaskIntoConstraints = false
		self.scrollView.addSubview(self.scrollViewContentView)
		
		let topConstraint = NSLayoutConstraint(item: scrollViewContentView, attribute: .top, relatedBy: .equal,
		                                       toItem: scrollView, attribute: .top,
		                                       multiplier: 1.0, constant: 0.0)
		
		let leftConstraint = NSLayoutConstraint(item: scrollViewContentView, attribute: .leading, relatedBy: .equal,
		                                        toItem: scrollView, attribute: .leading,
		                                        multiplier: 1.0, constant: 0.0)
		
		let rightConstraint = NSLayoutConstraint(item: scrollViewContentView, attribute: .trailing, relatedBy: .equal,
		                                         toItem: scrollView, attribute: .trailing,
		                                         multiplier: 1.0, constant: 0.0)
		
		let bottomConstraint = NSLayoutConstraint(item: scrollViewContentView, attribute: .bottom, relatedBy: .equal,
		                                          toItem: scrollView, attribute: .bottom,
		                                          multiplier: 1.0, constant: 0.0)
		
		let widthConstraint = NSLayoutConstraint(item: scrollViewContentView, attribute: .width, relatedBy: .equal,
		                                         toItem: scrollView, attribute: .width,
		                                         multiplier: 1.0, constant: 0.0)
		
		topConstraint.isActive = true
		bottomConstraint.isActive = true
		leftConstraint.isActive = true
		rightConstraint.isActive = true
		widthConstraint.isActive = true
		
	}
	
	// MARK:- Overriding

	open override func responds(to aSelector: Selector!) -> Bool {
		if super.responds(to: aSelector) {
			return true
		} else if let delegate = self.userDelegate, delegate.responds(to: aSelector) {
			return true
		}
		return false
	}
	
	override open func forwardingTarget(for aSelector: Selector!) -> Any? {
		if let delegate = self.userDelegate, delegate.responds(to: aSelector) {
			return delegate
		}
		return nil
	}
	
	// MARK:- API
	
	public func setContentView(_ view: UIView) {
		self.scrollViewContentView.addSubview(view)
		view.translatesAutoresizingMaskIntoConstraints = false
		
		let topConstraint = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal,
		                                       toItem: scrollViewContentView, attribute: .top,
		                                       multiplier: 1.0, constant: 0.0)
		
		let leftConstraint = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal,
		                                        toItem: scrollViewContentView, attribute: .leading,
		                                        multiplier: 1.0, constant: 0.0)
		
		let rightConstraint = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal,
		                                         toItem: scrollViewContentView, attribute: .trailing,
		                                         multiplier: 1.0, constant: 0.0)
		
		let bottomConstraint = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal,
		                                          toItem: scrollViewContentView, attribute: .bottom,
		                                          multiplier: 1.0, constant: 0.0)
		
		topConstraint.isActive = true
		bottomConstraint.isActive = true
		leftConstraint.isActive = true
		rightConstraint.isActive = true
	
		
	}
	
	public func setHeaderView(_ view: UIView) {
		self.headerView.addSubview(view)
		view.translatesAutoresizingMaskIntoConstraints = false
		
		let topConstraint = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal,
		                                       toItem: headerView, attribute: .top,
		                                       multiplier: 1.0, constant: 0.0)
		
		let leftConstraint = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal,
		                                        toItem: headerView, attribute: .leading,
		                                        multiplier: 1.0, constant: 0.0)
		
		let rightConstraint = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal,
		                                         toItem: headerView, attribute: .trailing,
		                                         multiplier: 1.0, constant: 0.0)
		
		let bottomConstraint = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal,
		                                          toItem: headerView, attribute: .bottom,
		                                          multiplier: 1.0, constant: 0.0)
		
		topConstraint.isActive = true
		bottomConstraint.isActive = true
		leftConstraint.isActive = true
		rightConstraint.isActive = true
	}
	
	public func setScrollViewDelegate(_ delegate: UIScrollViewDelegate) {
		self.userDelegate = delegate
	}
}

// MARK:- UIScrollViewDelegate

extension ATScrollView: UIScrollViewDelegate {
	
	public enum ScrollingDirection {
		case up(height: CGFloat)
		case down(height: CGFloat)
		case none
		
		///
		///
		/// - Parameters:
		///   - previousOffset: offset previo
		///   - currentOffset: offset actual
		///   - top: tope superior
		///   - bottom: tope inferior
		init(previousOffset: CGFloat, currentOffset: CGFloat) {
			let scrollDiff = currentOffset - previousOffset
			if scrollDiff > 0 && currentOffset > 0 {
				self = .down(height: abs(scrollDiff))
			} else if scrollDiff < 0 && currentOffset <= 0 {
				self = .up(height: abs(scrollDiff))
			} else {
				self = .none
			}
		}
	}
	
	public func scrollViewDidScroll(_ scrollView: UIScrollView) {
		
		let scrollingDirection = ScrollingDirection(previousOffset: self.previousScrollOffset, currentOffset: scrollView.contentOffset.y)
		
		var newHeight = self.headerHeightConstraint.constant
		
		switch scrollingDirection  {
		case .down(let height):
			newHeight = max(self.minHeaderHeight, self.headerHeightConstraint.constant - height)
		case .up(let height):
			newHeight = min(self.maxHeaderHeight, self.headerHeightConstraint.constant + height)
		case .none:
			break
		}
		
		if newHeight != self.headerHeightConstraint.constant {
			// Se actuliza  la altura de la cabecera
			self.headerHeightConstraint.constant = newHeight
			self.setScrollPosition(to: self.previousScrollOffset)
		} else if newHeight <= self.minHeaderHeight {
			// Altura mínima alcanzada
		} else if newHeight >= self.maxHeaderHeight {
			// Altura máxima alcanzada
		}
		
		self.previousScrollOffset = scrollView.contentOffset.y
		
		if let delegate = self.userDelegate, delegate.responds(to: #selector(scrollViewDidScroll(_:))) {
			delegate.scrollViewDidScroll!(scrollView)
		}
	}
	
	private func setScrollPosition(to position: CGFloat) {
		self.scrollView.contentOffset = CGPoint(x: self.scrollView.contentOffset.x, y: position)
	}
}
