import UIKit
import Firebase

class LobbyViewController: UIViewController {
    
    let spacingSquareView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.layer.borderColor = UIColor.inactiveColor.cgColor
        view.layer.borderWidth = 1.0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    let lineHorizontal: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lobbyThemeColor
        view.layer.cornerRadius = 1.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lineVertical: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lobbyThemeColor
        view.layer.cornerRadius = 1.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let circleScale: CGFloat = 0.45
    let buttonScale: CGFloat = 0.95
    
    var currentEvent: Event?
    
    let settingsTitle = "SETTINGS"
    let searchTitle = "SEARCH"
    let hostTitle = "HOST"
    let currentEventTitle = "CURRENT"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        title = "Lobby"
        
        setupCircle {
            self.setupView()
        }
        setupViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupViewController()
    }
}

extension LobbyViewController {
    
    @objc func goToEventList(sender: UIButton) {
        let eventListVC = EventListViewController(nibName: StoryboardName.eventList.rawValue, bundle: nil)
        self.navigationController?.pushViewController(eventListVC, animated: true)
    }
    
    @objc func goToCurrentEvent(sender: UIButton) {
        if let event = self.currentEvent {
            
        } else {
            AlertHelper.fireInfoActionSheet(viewController: self, message: "This will be a shortcut for you to access the event you are currently at. To enable this, please go to Search and find the event you are attending.")
        }
    }
    
    @objc func goToHostEvent(sender: UIButton) {
        let hostEventForm = HostEventFormViewController(nibName: StoryboardName.hostEventForm.rawValue, bundle: nil)
        self.navigationController?.pushViewController(hostEventForm, animated: true)
    }
    
    @objc func goToSettings(sender: UIButton) {
        spinGear(sender: sender) {
            let settingsVC = SettingsViewController(nibName: StoryboardName.settings.rawValue, bundle: nil)
            self.navigationController?.pushViewController(settingsVC, animated: true)
        }
    }
}
// radius of circle / sqrRt2 is a leg

extension LobbyViewController {
    private func setupCircle(completion: (() -> Void)?) {
        view.addSubview(spacingSquareView)
        spacingSquareView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: circleScale).isActive = true
        spacingSquareView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: circleScale).isActive = true
        spacingSquareView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spacingSquareView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        completion?()
    }
    
    private func setupView() {
        fadeInHorizontalLine()
        fadeInVerticalLine()
        
        let lineScale: CGFloat = 2 * circleScale
        let lineWidth: CGFloat = 1.0
        
        let searchImage = UIImage(named: "search")!
        let settingsImage = UIImage(named: "settings")!
        let hostImage = UIImage(named: "event")!
        let currentImage = UIImage(named: "star")!
        
        view.addSubview(lineHorizontal)
        lineHorizontal.centerXAnchor.constraint(equalTo: spacingSquareView.centerXAnchor).isActive = true
        lineHorizontal.centerYAnchor.constraint(equalTo: spacingSquareView.centerYAnchor).isActive = true
        lineHorizontal.heightAnchor.constraint(equalToConstant: lineWidth).isActive = true
        lineHorizontal.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: lineScale).isActive = true
        
        view.addSubview(lineVertical)
        lineVertical.centerXAnchor.constraint(equalTo: spacingSquareView.centerXAnchor).isActive = true
        lineVertical.centerYAnchor.constraint(equalTo: spacingSquareView.centerYAnchor).isActive = true
        lineVertical.widthAnchor.constraint(equalToConstant: lineWidth).isActive = true
        lineVertical.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: lineScale).isActive = true
        
        let searchButton = LobbyButton(title: searchTitle, image: searchImage)
        view.addSubview(searchButton)
        searchButton.centerXAnchor.constraint(equalTo: spacingSquareView.leadingAnchor).isActive = true
        searchButton.centerYAnchor.constraint(equalTo: spacingSquareView.topAnchor).isActive = true
        searchButton.widthAnchor.constraint(equalTo: spacingSquareView.widthAnchor, multiplier: buttonScale).isActive = true
        searchButton.heightAnchor.constraint(equalTo: spacingSquareView.heightAnchor, multiplier: buttonScale).isActive = true
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.addTarget(self, action: #selector(goToEventList(sender:)), for: .touchUpInside)
        searchButton.alpha = 0.0
        fadeButtonIn(searchButton, delay: 1.0)
        
        let currentEventButton = LobbyButton(title: currentEventTitle, image: currentImage)
        view.addSubview(currentEventButton)
        currentEventButton.centerXAnchor.constraint(equalTo: spacingSquareView.trailingAnchor).isActive = true
        currentEventButton.centerYAnchor.constraint(equalTo: spacingSquareView.topAnchor).isActive = true
        currentEventButton.widthAnchor.constraint(equalTo: spacingSquareView.widthAnchor, multiplier: buttonScale).isActive = true
        currentEventButton.heightAnchor.constraint(equalTo: spacingSquareView.heightAnchor, multiplier: buttonScale).isActive = true
        currentEventButton.translatesAutoresizingMaskIntoConstraints = false
        currentEventButton.addTarget(self, action: #selector(goToCurrentEvent(sender:)), for: .touchUpInside)
        currentEventButton.alpha = 0.0
        fadeButtonIn(currentEventButton, delay: 1.0)
        
        let hostButton = LobbyButton(title: hostTitle, image: hostImage)
        view.addSubview(hostButton)
        hostButton.centerXAnchor.constraint(equalTo: spacingSquareView.leadingAnchor).isActive = true
        hostButton.centerYAnchor.constraint(equalTo: spacingSquareView.bottomAnchor).isActive = true
        hostButton.widthAnchor.constraint(equalTo: spacingSquareView.widthAnchor, multiplier: buttonScale).isActive = true
        hostButton.heightAnchor.constraint(equalTo: spacingSquareView.heightAnchor, multiplier: buttonScale).isActive = true
        hostButton.translatesAutoresizingMaskIntoConstraints = false
        hostButton.addTarget(self, action: #selector(goToHostEvent(sender:)), for: .touchUpInside)
        hostButton.alpha = 0.0
        fadeButtonIn(hostButton, delay: 1.0)
        
        let settingsButton = LobbyButton(title: settingsTitle, image: settingsImage)
        view.addSubview(settingsButton)
        settingsButton.centerXAnchor.constraint(equalTo: spacingSquareView.trailingAnchor).isActive = true
        settingsButton.centerYAnchor.constraint(equalTo: spacingSquareView.bottomAnchor).isActive = true
        settingsButton.widthAnchor.constraint(equalTo: spacingSquareView.widthAnchor, multiplier: buttonScale).isActive = true
        settingsButton.heightAnchor.constraint(equalTo: spacingSquareView.heightAnchor, multiplier: buttonScale).isActive = true
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.addTarget(self, action: #selector(goToSettings(sender:)), for: .touchUpInside)
        settingsButton.alpha = 0.0
        fadeButtonIn(settingsButton, delay: 1.0)
    }
}

extension LobbyViewController {
    private func fadeButtonIn(_ button: UIButton, delay: TimeInterval) {
        UIView.animate(withDuration: 0.5, delay: delay, options: .curveEaseInOut, animations: {
            button.alpha = 1.0
        })
    }
    
    private func fadeInHorizontalLine() {
        lineHorizontal.transform = CGAffineTransform(scaleX: 0.0, y: 1.0)
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
            self.lineHorizontal.transform = .identity
        }, completion: nil)
    }
    
    private func fadeInVerticalLine() {
        lineVertical.transform = CGAffineTransform(scaleX: 1.0, y: 0.0)
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
            self.lineVertical.transform = .identity
        }, completion: nil)
    }
    
    private func spinGear(sender: UIButton, completion: (() -> Void)?) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            sender.transform = CGAffineTransform(rotationAngle: .pi)
        }, completion: { _ in
            sender.transform = .identity
            completion?()
        })
    }
}

