import UIKit
import Firebase

class LobbyViewController: UIViewController {
    
    let circleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.layer.borderColor = UIColor.inactiveColor.cgColor
        view.layer.borderWidth = 1.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let buttonSize = CGRect(x: 50, y: 50, width: 50, height: 50)
    
    var currentEvent: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupViewController()
    }
}

extension LobbyViewController {
    
    @objc func goToEventList(sender: UIButton) {
        unlockButton(sender: sender) {
            let eventListVC = EventListViewController(nibName: StoryboardName.eventList.rawValue, bundle: nil)
            self.navigationController?.pushViewController(eventListVC, animated: true)
        }
    }
    
    @objc func goToCurrentEvent(sender: UIButton) {
        unlockButton(sender: sender) {
            if let event = self.currentEvent {
                
            } else {
                AlertHelper.fireInfoActionSheet(viewController: self, message: "This will be a shortcut for you to access the event you are currently at. To enable this, please go to Search and find the event you are attending.")
            }
        }
    }
    
    @objc func goToHostEvent(sender: UIButton) {
        unlockButton(sender: sender) {
            let hostEventForm = HostEventFormViewController(nibName: StoryboardName.hostEventForm.rawValue, bundle: nil)
            self.navigationController?.pushViewController(hostEventForm, animated: true)
        }
    }
    
    @objc func goToSettings(sender: UIButton) {
        unlockButton(sender: sender) {
            let settingsVC = SettingsViewController(nibName: StoryboardName.settings.rawValue, bundle: nil)
            self.navigationController?.pushViewController(settingsVC, animated: true)
        }
    }
    
    private func unlockButton(sender: UIButton, completion: (() -> Void)?) {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            sender.transform = CGAffineTransform(rotationAngle: .pi)
        }, completion: { _ in
            UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
                sender.transform = CGAffineTransform(rotationAngle: -2 * .pi)
            }, completion: { _ in
                completion?()
            })
        })
    }
}

extension LobbyViewController {
    
    private func setupView() {
        navigationItem.hidesBackButton = true
        title = "Lobby"
        
        let circleScale: CGFloat = 0.75
        let buttonScale: CGFloat = 0.28
        
        let settingsTitle = "SETTINGS"
        let searchTitle = "SEARCH"
        let hostTitle = "HOST"
        let currentEventTitle = "CURRENT"
        
        view.addSubview(circleView)
        circleView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: circleScale).isActive = true
        circleView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: circleScale).isActive = true
        circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        circleView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        circleView.layer.cornerRadius = view.frame.width * circleScale / 2
        circleView.alpha = 0.0
        fadeCircleIn(circleView)
        
        let settingsButton = CircleButton(color: UIColor.inactiveColor, title: settingsTitle)
        view.addSubview(settingsButton)
        settingsButton.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
        settingsButton.centerYAnchor.constraint(equalTo: circleView.bottomAnchor).isActive = true
        settingsButton.widthAnchor.constraint(equalTo: circleView.widthAnchor, multiplier: buttonScale).isActive = true
        settingsButton.heightAnchor.constraint(equalTo: circleView.heightAnchor, multiplier: buttonScale).isActive = true
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.addTarget(self, action: #selector(goToSettings(sender:)), for: .touchUpInside)
        settingsButton.alpha = 0.0
        fadeButtonIn(settingsButton)
        
        let searchButton = CircleButton(color: UIColor.affirmativeColor, title: searchTitle)
        view.addSubview(searchButton)
        searchButton.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
        searchButton.centerYAnchor.constraint(equalTo: circleView.topAnchor).isActive = true
        searchButton.widthAnchor.constraint(equalTo: circleView.widthAnchor, multiplier: buttonScale).isActive = true
        searchButton.heightAnchor.constraint(equalTo: circleView.heightAnchor, multiplier: buttonScale).isActive = true
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.addTarget(self, action: #selector(goToEventList(sender:)), for: .touchUpInside)
        searchButton.alpha = 0.0
        fadeButtonIn(searchButton)
        
        let hostButton = CircleButton(color: UIColor.linkColor, title: hostTitle)
        view.addSubview(hostButton)
        hostButton.centerXAnchor.constraint(equalTo: circleView.leadingAnchor).isActive = true
        hostButton.centerYAnchor.constraint(equalTo: circleView.centerYAnchor).isActive = true
        hostButton.widthAnchor.constraint(equalTo: circleView.widthAnchor, multiplier: buttonScale).isActive = true
        hostButton.heightAnchor.constraint(equalTo: circleView.heightAnchor, multiplier: buttonScale).isActive = true
        hostButton.translatesAutoresizingMaskIntoConstraints = false
        hostButton.addTarget(self, action: #selector(goToHostEvent(sender:)), for: .touchUpInside)
        hostButton.alpha = 0.0
        fadeButtonIn(hostButton)
        
        let currentEventButton = CircleButton(color: UIColor.destructiveColor, title: currentEventTitle)
        view.addSubview(currentEventButton)
        currentEventButton.centerXAnchor.constraint(equalTo: circleView.trailingAnchor).isActive = true
        currentEventButton.centerYAnchor.constraint(equalTo: circleView.centerYAnchor).isActive = true
        currentEventButton.widthAnchor.constraint(equalTo: circleView.widthAnchor, multiplier: buttonScale).isActive = true
        currentEventButton.heightAnchor.constraint(equalTo: circleView.heightAnchor, multiplier: buttonScale).isActive = true
        currentEventButton.translatesAutoresizingMaskIntoConstraints = false
        currentEventButton.addTarget(self, action: #selector(goToCurrentEvent(sender:)), for: .touchUpInside)
        currentEventButton.alpha = 0.0
        fadeButtonIn(currentEventButton)
    }
    
    private func fadeButtonIn(_ button: UIButton) {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
            button.alpha = 1.0
        })
    }
    
    private func fadeCircleIn(_ view: UIView) {
        UIView.animate(withDuration: 0.5, delay: 1.0, options: .curveEaseInOut, animations: {
            view.alpha = 1.0
        })
    }
}

