//
//  DraggableModalViewController.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import UIKit

final class DraggableModalViewController: UIViewController {

    // MARK: - View components
    private lazy var containerView = UIView(frame: .zero).then {
        view.addSubview($0)
    }
    private lazy var headerView: UIView = {
        let headerView = headerComponent.base
        containerView.addSubview(headerView)
        return headerView
    }()
    private lazy var topView = UIView(frame: .zero).then {
        view.addSubview($0)
    }
    private lazy var bottomView: UIView? = {
        guard let bottomComponent else { return nil }
        let bottomView = bottomComponent.base
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomView)
        return bottomView
    }()
    private lazy var collectionView: UICollectionView? = {
        if contentViewController != nil {
            return nil
        }
        let collectionView = makeCollection()
        containerView.addSubview(collectionView)
        return collectionView
    }()
    private lazy var closeView = UIView(frame: .zero).then {
        view.insertSubview($0,
                           at: 0)
    }
    private var contentView: UIView {
        if let view = contentViewController?.view {
            return view
        } else if let collectionView {
            return collectionView
        } else {
            return UIView()
        }
    }
    private lazy var backImage: UIImageView? = {
        guard let backgroundImage else { return nil }
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.backgroundColor = .clear
        containerView.addSubview(backgroundImage)
        return backgroundImage
    }()

    private weak var topContainerConstraint: NSLayoutConstraint?

    // MARK: - private properties
    private var contentViewController: UIViewController?
    private var collectionViewInContentVC: UICollectionView?
    private var headerComponent: ModalHeaderComponent
    private var bottomComponent: BottomViewComponent?
    private var backgroundImage: UIImageView?
    private let dataSource: ModalDataSourceImplementation?
    private let higherProportion: CGFloat
    private let leastProportion: CGFloat
    private let percentThreshold: CGFloat
    private let refreshLayoutAfterUpdate: Bool
    private let generateFeedback: Bool
    private let hiddenTopIndicator: Bool
    private var isExpandable: Bool
    private var minConstant: CGFloat = 0
    private var shouldFinish: Bool = false
    private var shouldStopScroll: Bool = false
    private var canBeDismissed: Bool = true
    private var firstConstant: CGFloat = 0.0
    private var keyboardHeight: CGFloat = 0.0
    private var state: ModalState = .normal {
        didSet {
            guard isExpandable else { return }
            changeHeaderState()
        }
    }

    private var topSafeArea: CGFloat = {
        keyWindow?.safeAreaInsets.top ?? 0.0
    }()

    private lazy var viewHeight: CGFloat = {
        view.bounds.height - topSafeArea
    }()

    private lazy var lastConstant: CGFloat = {
        topContainerConstraint?.constant ?? 0
    }()

    private lazy var modalSafeTop: CGFloat = {
        topSafeArea + .spacing(8)
    }()

    // MARK: - Modal State
    private enum ModalState {
        case normal, expanded
    }

    // MARK: - External properties
    var didLoad: Observable<Void> { didLoadMutableObservable }
    var willAppear: Observable<Void> { willAppearMutableObservable }
    var didAppear: Observable<Void> { didAppearMutableObservable }
    var didDissmisDrag: Observable<Void> { didDissmisDragMutableObservable }
    var deallocated: Observable<Void> { deallocatedMutableObservable }
    
    private let didLoadMutableObservable: MutableObservable<Void> = MutableObservable<Void>()
    private let willAppearMutableObservable: MutableObservable<Void> = MutableObservable<Void>()
    private let didAppearMutableObservable: MutableObservable<Void> = MutableObservable<Void>()
    private let didDissmisDragMutableObservable: MutableObservable<Void> = MutableObservable<Void>()
    private let deallocatedMutableObservable: MutableObservable<Void> = MutableObservable<Void>()

    // MARK: - Life Cycle
    init(config: DraggableModalConfig) {
        let higherProportion = max(config.higherProportion, config.leastProportion)
        let leastProportion = min(config.leastProportion, config.higherProportion)
        self.dataSource = config.dataSource
        self.headerComponent = config.header
        self.bottomComponent = config.bottom
        self.higherProportion = max(min(higherProportion, 0.98), 0.4)
        self.leastProportion = max(min(leastProportion, 0.98), 0.3)
        self.percentThreshold = max(min(config.percentThreshold, 0.8), 0.5)
        self.refreshLayoutAfterUpdate = config.refreshLayoutAfterUpdate
        self.isExpandable = config.isExpandable
        self.generateFeedback = config.generateFeedback
        self.backgroundImage = config.backgroundImage
        self.hiddenTopIndicator = config.hiddenTopIndicator
        super.init(nibName: nil,
                   bundle: nil)
    }

    init(controller: UIViewController,
         canBeDismissed: Bool) {
        let insets = UIEdgeInsets(top: .spacing(2),
                                  left: .zero,
                                  bottom: .spacing(2),
                                  right: .zero)
        self.headerComponent = BaseModalHeaderComponent(config: BaseModalHeaderConfig(contentInsets: insets, showDecorator: false))
        self.contentViewController = controller
        self.dataSource = nil
        self.higherProportion = 0.95
        self.leastProportion = 0.95
        self.percentThreshold = 0.8
        self.refreshLayoutAfterUpdate = false
        self.generateFeedback = false
        self.isExpandable = true
        self.canBeDismissed = canBeDismissed
        self.hiddenTopIndicator = false
        self.backgroundImage?.isHidden = true
        self.bottomComponent = canBeDismissed ? ModalCloseBottomComponent() : nil
        super.init(nibName: nil,
                   bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        makeView()
        setupConstraint()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupDataSource()
        subscribeToScroll()
        setupGestures()
        animateModal(willAppear: true)
        didLoadMutableObservable.postValue(())
        setupViewBinds()
        registerNotifications()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        unRegisterNotifications()
        StatusBar.config.setUp(style: .light)
        willAppearMutableObservable.postValue(())
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if contentViewController != nil && collectionViewInContentVC == nil {
            collectionViewInContentVC = findScrollViewInContentController()
            subscribeToScroll()
        }

        didAppearMutableObservable.postValue(())
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        backImage?.image = nil
        StatusBar.config.setupOldStyle()
    }

    func dismissComponent(completion: CompletionHandler?) {
        animateModal(willAppear: false, completion: completion)
    }
}

// MARK: - Private Implementation
private extension DraggableModalViewController {
    func standardTopConstant() -> CGFloat {
        max(firstConstant - keyboardHeight, 0)
    }

    func makeView() {
        let rootView = UIView()
        rootView.frame = UIScreen.main.bounds
        view = rootView

        if let collectionView {
            disableResizing(of: closeView,
                            topView,
                            topView,
                            collectionView,
                            headerComponent.base,
                            containerView)
        } else if let contentViewController {
            displayContentController()
            disableResizing(of: closeView,
                            topView,
                            topView,
                            contentViewController.view,
                            headerComponent.base,
                            containerView)
        }
    }

    func displayContentController() {
        guard let contentViewController else { return }

        addChild(contentViewController)
        containerView.addSubview(contentViewController.view)
        contentViewController.didMove(toParent: self)
    }

    func removeContentViewController() {
        guard let contentViewController else { return }

        contentViewController.willMove(toParent: nil)
        contentViewController.view.removeFromSuperview()
        contentViewController.removeFromParent()
    }

    func makeCollection() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = true
        return .init(frame: .zero,
                     collectionViewLayout: layout)
    }

    func setupDataSource() {
        guard let dataSource else { return }

        if refreshLayoutAfterUpdate {
            dataSource.contentSize.observe { [weak self] size in
                self?.recalculateSizeIfNeeded(with: size)
            }
        }
        dataSource.viewController = self
        dataSource.viewController = self
        dataSource.collectionView = collectionView
    }

    func subscribeToScroll() {
        if let dataSource {
            dataSource.didScroll.observe { [weak self] in
                self?.scrollViewDidScroll()
            }
            dataSource.didEndDragging.observe { [weak self] in
                self?.scrollViewDidEndDragging()
            }
            dataSource.willBeginDecelerating.observe { [weak self] in
                self?.scrollViewWillBeginDecelerating()
            }
        } else if let contentViewController = contentViewController as? DraggableModalWithCollectionViewController {
            contentViewController.didScroll.observe { [weak self] in
                self?.scrollViewDidScroll()
            }
            contentViewController.didEndDragging.observe { [weak self] in
                self?.scrollViewDidEndDragging()
            }
            contentViewController.willBeginDecelerating.observe { [weak self] in
                self?.scrollViewWillBeginDecelerating()
            }
        }
    }

    func disableResizing(of views: UIView...) {
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }

    func recalculateSizeIfNeeded(with update: CGSize) {
        let proposedHeight = update.height + headerComponent.height
        let minHeight = viewHeight * leastProportion
        let maxHeight = viewHeight * higherProportion

        if proposedHeight > minHeight && proposedHeight != containerView.bounds.height {
            let newConstant = viewHeight - min(proposedHeight, maxHeight)
            topContainerConstraint?.constant = newConstant
            firstConstant = newConstant
            lastConstant = newConstant
            minConstant = isExpandable ? 0 : newConstant

            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.view.layoutIfNeeded()
            })
        }
    }

    func setupConstraint() {
        firstConstant = viewHeight - (leastProportion * viewHeight)
        minConstant = isExpandable ? 0 : standardTopConstant()
        let topContainerConstraint = containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: standardTopConstant())

        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topContainerConstraint,
            headerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: containerView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: headerComponent.height),
            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            contentView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            closeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            closeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            closeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            closeView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.widthAnchor.constraint(equalToConstant: .spacing(8)),
            topView.heightAnchor.constraint(equalToConstant: .spacing(1)),
            topView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            topView.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -.spacing(2))
        ])

        if let backImage {
            NSLayoutConstraint.activate([
                backImage.topAnchor.constraint(equalTo: containerView.topAnchor),
                backImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                backImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                backImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
        }

        if let bottomView,
           let bottomComponent {
            NSLayoutConstraint.activate([
                bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                bottomView.heightAnchor.constraint(equalToConstant: bottomComponent.height)
            ])
        }

        if headerComponent.isFloating {
            collectionView?.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        } else {
            collectionView?.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        }

        self.topContainerConstraint = topContainerConstraint
    }

    func setupAppearance() {
        if let backImage {
            containerView.sendSubviewToBack(backImage)
        }
        closeView.backgroundColor = .overlayB
        closeView.alpha = .zero
        topView.backgroundColor = .overlayA
        topView.setupRoundedCorners(radius: .spacing(1))
        topView.transform = CGAffineTransform(translationX: .zero,
                                              y: view.bounds.height)

        if let collectionView {
            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.contentInsetAdjustmentBehavior = .never
            collectionView.backgroundColor = .white
            collectionView.contentInset = .init(top: .zero,
                                                left: .zero,
                                                bottom: .spacing(30),
                                                right: .zero)
        }

        containerView.setupRoundedCorners(radius: 30.0,
                                          corners: [.topLeft, .topRight])
        containerView.transform = CGAffineTransform(translationX: .zero,
                                                    y: view.bounds.height)
        containerView.backgroundColor = .white
        bottomComponent?.viewDidLoad()
        view.backgroundColor = .clear
    }

    func setupViewBinds() {
        bottomComponent?.onClose.observe() { [weak self] in
            self?.onClose()
        }
    }

    func setupGestures() {
        let scrollGesture = UIPanGestureRecognizer(target: self,
                                                   action: #selector(handleGesture))
        scrollGesture.delaysTouchesBegan = false
        scrollGesture.delegate = self

        containerView.addGestureRecognizer(scrollGesture)

        if canBeDismissed {
            let tapGesture = UITapGestureRecognizer(target: self,
                                                    action: #selector(onClose))
            closeView.addGestureRecognizer(tapGesture)
        }
    }

    @objc
    func onClose() {
        self.didDissmisDragMutableObservable.postValue(())
        animateModal(willAppear: false)
    }

    func animateModal(willAppear: Bool,
                      completion: CompletionHandler? = nil) {
        DispatchQueue.main.asyncAfter(deadline: .now() + (willAppear ? 0.2 : 0.0), execute: { [weak self] in
            if !willAppear {
                self?.bottomComponent?.animateAppear(willAppear)
            }

            UIView.animate(withDuration: willAppear ? 0.25 : 0.4,
                           animations: { [weak self] in
                guard let self else { return }
                let transform = CGAffineTransform(translationX: 0,
                                                  y: self.view.bounds.height)
                self.containerView.transform = willAppear ? .identity : transform
                self.topView.transform = willAppear ? .identity : transform
                self.closeView.alpha = willAppear ? 1.0 : 0.0
            }, completion: { [weak self] _ in
                guard let self else { return }

                if willAppear && self.generateFeedback {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                } else if !willAppear {
                    self.removeContentViewController()
                    self.dismiss(animated: false, completion: completion)
                }
            })
        })
    }

    func changeHeaderState() {
        let isExpanded = state == .expanded
        headerComponent.isHeaderOnTop = isExpanded
        topView.isHidden = isExpanded
        StatusBar.config.setTextColor(color: isExpanded ? .black : .white)
        bottomView?.layer.removeAllAnimations()
        closeView.backgroundColor = isExpanded ? .white : .overlayB
        bottomComponent?.animateAppear(isExpanded)

        let cornerRadius: CGFloat = isExpanded ? 0 : 30
        containerView.setupRoundedCorners(radius: cornerRadius,
                                          corners: [.topLeft, .topRight])
    }

    func changeContainerState(velocity: CGFloat) {
        let isExpanding = velocity <= 0 && (topContainerConstraint?.constant ?? 0.0) < standardTopConstant() && isExpandable
        let dampingFactor = -velocity / 1000
        let shouldDamping = dampingFactor > 0.8
        topContainerConstraint?.constant = isExpanding ? 0 : standardTopConstant()
        lastConstant = isExpanding ? 0 : standardTopConstant()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.state = isExpanding ? .expanded : .normal
        })

        if isExpanding && shouldDamping {
            UIView.animate(withDuration: 0.4,
                           delay: 0.0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 1.0,
                           options: .curveEaseInOut, animations: { [weak self] in
                self?.closeView.alpha = 1.0
                self?.view.layoutIfNeeded()
            })
        } else {
            UIView.animate(withDuration: isExpanding ? 0.25 : 0.15, animations: { [weak self] in
                self?.closeView.alpha = 1.0
                self?.view.layoutIfNeeded()
            })
        }
    }

    func scrollViewDidScroll() {
        let scrollView: UIScrollView? = collectionView != nil ? collectionView : collectionViewInContentVC

        if containerView.frame.minY > topSafeArea && isExpandable {
            scrollView?.contentOffset.y = 0
        } else if !isExpandable && (topContainerConstraint?.constant ?? 0.0 ) > standardTopConstant() {
            scrollView?.contentOffset.y = 0
        }

        headerComponent.collectionOffset = collectionView?.contentOffset ?? .zero
    }

    func scrollViewDidEndDragging() {
        let scrollView: UIScrollView? = collectionView != nil ? collectionView : collectionViewInContentVC

        guard let scrollView else { return }

        guard (topContainerConstraint?.constant ?? 0.0) > minConstant && !shouldFinish else {
            return
        }

        shouldStopScroll = true
        changeContainerState(velocity: scrollView.panGestureRecognizer.velocity(in: scrollView).y)
    }

    func scrollViewWillBeginDecelerating() {
        let scrollView: UIScrollView? = collectionView != nil ? collectionView : collectionViewInContentVC

        guard let scrollView else { return }

        guard shouldStopScroll else { return }
        shouldStopScroll = false
        scrollView.setContentOffset(scrollView.contentOffset, animated: false)
    }

}

extension DraggableModalViewController {

    func registerNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShowNotification),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHideNotification),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    private func unRegisterNotifications() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)

        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }

    @objc
    func keyboardWillShowNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let frame = userInfo["UIKeyboardFrameEndUserInfoKey"] as? CGRect else {
                return
        }

        self.keyboardWillShow(true,
                              keyboardHeight: frame.height)
    }

    @objc
    func keyboardWillHideNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let frame = userInfo["UIKeyboardFrameEndUserInfoKey"] as? CGRect else {
                return
        }

        self.keyboardWillShow(false,
                              keyboardHeight: frame.height)
    }

    private func keyboardWillShow(_ show: Bool, keyboardHeight: CGFloat) {
        self.keyboardHeight = show ? keyboardHeight : 0
        topContainerConstraint?.constant = standardTopConstant()
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }

}


// MARK: - UIGestureRecognizerDelegate Implementation
extension DraggableModalViewController: UIGestureRecognizerDelegate {
    @objc
    func handleGesture(_ recognizer: UIPanGestureRecognizer) {
        let deltaY = recognizer.translation(in: view).y
        let velocity = recognizer.velocity(in: collectionView).y
        var isWithOutScrollArea = true

        if let collectionView {
            isWithOutScrollArea = collectionView.contentOffset.y <= 0
        } else if let collectionViewInContentVC {
            isWithOutScrollArea = collectionViewInContentVC.contentOffset.y <= 0
        }

        switch recognizer.state {
        case .changed where isWithOutScrollArea:
            calculateGesture(with: velocity, to: deltaY)
        case .ended, .cancelled, .failed:
            calculateEndGesture(with: velocity)
        default:
            break
        }
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    private func calculateGesture(with velocity: CGFloat, to deltaY: CGFloat) {
        let minConstant = isExpandable ? 0 : standardTopConstant()
        let maxY = max(minConstant,
                       lastConstant + deltaY)
        let minY = min(view.bounds.height,
                       maxY)
        let dismissPercentage = containerView.bounds.height / (viewHeight - standardTopConstant())
        topContainerConstraint?.constant = minY
        closeView.alpha = dismissPercentage
        shouldFinish = dismissPercentage <= percentThreshold && velocity > 0 && canBeDismissed

        if minY == minConstant && state == .normal {
            state = .expanded
        } else if minY > minConstant && state == .expanded {
            state = .normal
        }
    }

    private func calculateEndGesture(with velocity: CGFloat) {
        var isCollectionViewDragging = false
        var isCollectionViewDecelerating = false

        if let collectionView {
            isCollectionViewDragging = collectionView.isDragging
            isCollectionViewDecelerating = collectionView.isDecelerating
        } else if let collectionViewInContentVC {
            isCollectionViewDragging = collectionViewInContentVC.isDragging
            isCollectionViewDecelerating = collectionViewInContentVC.isDecelerating
        }

        if shouldFinish {
            self.didDissmisDragMutableObservable.postValue(())
            animateModal(willAppear: false)
        } else if (topContainerConstraint?.constant ?? 0.0) > minConstant && !isCollectionViewDragging && !isCollectionViewDecelerating {
            changeContainerState(velocity: velocity)
        } else {
            lastConstant = topContainerConstraint?.constant ?? 0.0
        }
    }

    private func findScrollViewInContentController() -> UICollectionView? {
        guard let contentViewController else { return nil }
        let collectionViews: [UICollectionView] = UIView.getAllSubviews(from: contentViewController.view)
        return collectionViews.first
    }
}
