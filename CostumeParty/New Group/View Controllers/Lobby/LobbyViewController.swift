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
    
    var currentParty: Party?
    
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
    
    @objc func goToPartyList(sender: UIButton) {
        unlockButton(sender: sender) {
            let partyListVC = PartyListViewController(nibName: StoryboardName.partyList.rawValue, bundle: nil)
            self.navigationController?.pushViewController(partyListVC, animated: true)
        }
    }
    
    @objc func goToCurrentParty(sender: UIButton) {
        unlockButton(sender: sender) {
            if let party = self.currentParty {
                
            } else {
                AlertHelper.fireErrorActionSheet(viewController: self, message: "This will be a shortcut for you to access the event you are currently at. To enable this, please go to Search and find the event you are attending.")
            }
        }
    }
    
    @objc func goToHostParty(sender: UIButton) {
        unlockButton(sender: sender) {
            let hostPartyForm = HostPartyFormViewController(nibName: StoryboardName.hostPartyForm.rawValue, bundle: nil)
            self.navigationController?.pushViewController(hostPartyForm, animated: true)
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
        let currentPartyTitle = "CURRENT"
        
        view.addSubview(circleView)
        circleView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: circleScale).isActive = true
        circleView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: circleScale).isActive = true
        circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        circleView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        circleView.layer.cornerRadius = view.frame.width * circleScale / 2
        circleView.alpha = 0.0
        fadeCircleIn(circleView)
        
        let settingsButton = CircleButton(color: UIColor.black, title: settingsTitle)
        view.addSubview(settingsButton)
        settingsButton.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
        settingsButton.centerYAnchor.constraint(equalTo: circleView.bottomAnchor).isActive = true
        settingsButton.widthAnchor.constraint(equalTo: circleView.widthAnchor, multiplier: buttonScale).isActive = true
        settingsButton.heightAnchor.constraint(equalTo: circleView.heightAnchor, multiplier: buttonScale).isActive = true
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.addTarget(self, action: #selector(goToSettings(sender:)), for: .touchUpInside)
        settingsButton.alpha = 0.0
        fadeButtonIn(settingsButton)
        
        let searchButton = CircleButton(color: UIColor.green, title: searchTitle)
        view.addSubview(searchButton)
        searchButton.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
        searchButton.centerYAnchor.constraint(equalTo: circleView.topAnchor).isActive = true
        searchButton.widthAnchor.constraint(equalTo: circleView.widthAnchor, multiplier: buttonScale).isActive = true
        searchButton.heightAnchor.constraint(equalTo: circleView.heightAnchor, multiplier: buttonScale).isActive = true
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.addTarget(self, action: #selector(goToPartyList(sender:)), for: .touchUpInside)
        searchButton.alpha = 0.0
        fadeButtonIn(searchButton)
        
        let hostButton = CircleButton(color: UIColor.blue, title: hostTitle)
        view.addSubview(hostButton)
        hostButton.centerXAnchor.constraint(equalTo: circleView.leadingAnchor).isActive = true
        hostButton.centerYAnchor.constraint(equalTo: circleView.centerYAnchor).isActive = true
        hostButton.widthAnchor.constraint(equalTo: circleView.widthAnchor, multiplier: buttonScale).isActive = true
        hostButton.heightAnchor.constraint(equalTo: circleView.heightAnchor, multiplier: buttonScale).isActive = true
        hostButton.translatesAutoresizingMaskIntoConstraints = false
        hostButton.addTarget(self, action: #selector(goToHostParty(sender:)), for: .touchUpInside)
        hostButton.alpha = 0.0
        fadeButtonIn(hostButton)
        
        let currentPartyButton = CircleButton(color: UIColor.red, title: currentPartyTitle)
        view.addSubview(currentPartyButton)
        currentPartyButton.centerXAnchor.constraint(equalTo: circleView.trailingAnchor).isActive = true
        currentPartyButton.centerYAnchor.constraint(equalTo: circleView.centerYAnchor).isActive = true
        currentPartyButton.widthAnchor.constraint(equalTo: circleView.widthAnchor, multiplier: buttonScale).isActive = true
        currentPartyButton.heightAnchor.constraint(equalTo: circleView.heightAnchor, multiplier: buttonScale).isActive = true
        currentPartyButton.translatesAutoresizingMaskIntoConstraints = false
        currentPartyButton.addTarget(self, action: #selector(goToCurrentParty(sender:)), for: .touchUpInside)
        currentPartyButton.alpha = 0.0
        fadeButtonIn(currentPartyButton)
    }
    
    private func fadeButtonIn(_ button: UIButton) {
        UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseInOut, animations: {
            button.alpha = 1.0
        })
    }
    
    private func fadeCircleIn(_ view: UIView) {
        UIView.animate(withDuration: 1.0, delay: 1.0, options: .curveEaseInOut, animations: {
            view.alpha = 1.0
        })
    }
}
