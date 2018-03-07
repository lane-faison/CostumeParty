import UIKit
import Firebase

class LobbyViewController: UIViewController {
    
//    @IBOutlet weak var findPartyButtonView: LargeButtonView!
//    @IBOutlet weak var hostPartyButtonView: LargeButtonView!
//    @IBOutlet weak var settingsButtonView: LargeButtonView!
    
    let circleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let buttonSize = CGRect(x: 50, y: 50, width: 50, height: 50)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let user = FirebaseService.firebaseUser() else { return }
        
        setupView(user: user)
        setupViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupViewController()
    }
}

extension LobbyViewController {
    
    @objc func goToPartyList(sender: UIButton) {
        animateButtonToCenter(sender: sender) {
            let partyListVC = PartyListViewController(nibName: StoryboardName.partyList.rawValue, bundle: nil)
            self.navigationController?.pushViewController(partyListVC, animated: true)
        }
    }
    
    @objc func goToHostParty(sender: UIButton) {
        animateButtonToCenter(sender: sender) {
            let hostPartyForm = HostPartyFormViewController(nibName: StoryboardName.hostPartyForm.rawValue, bundle: nil)
            self.navigationController?.pushViewController(hostPartyForm, animated: true)
        }
    }
    
    @objc func goToSettings(sender: UIButton) {
        animateButtonToCenter(sender: sender) {
            let settingsVC = SettingsViewController(nibName: StoryboardName.settings.rawValue, bundle: nil)
            self.navigationController?.pushViewController(settingsVC, animated: true)
        }
    }
    
    private func animateButtonToCenter(sender: UIButton, completion: (() -> Void)?) {
        
        UIView.animate(withDuration: 0.8, delay: 0.0, options: .curveEaseOut, animations: {
            sender.center = self.view.center
        }) { _ in
            sender.imageView?.alpha = 0.0
            UIView.animate(withDuration: 0.8, delay: 0.0, options: .curveEaseInOut, animations: {
                sender.transform = CGAffineTransform(scaleX: 15.0, y: 15.0)
            }, completion: { _ in
                completion?()
            })
        }
    }
}

extension LobbyViewController {
    
    private func setupView(user: User) {
        navigationItem.hidesBackButton = true
        title = "Lobby"
        let circleScale: CGFloat = 0.75
        let buttonScale: CGFloat = 0.25
        
        let settingsImage = UIImage(named: "gear")
        let searchImage = UIImage(named: "search")
        let hostImage = UIImage(named: "search")
        let otherImage = UIImage(named: "search")
        
        view.addSubview(circleView)
        circleView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: circleScale).isActive = true
        circleView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: circleScale).isActive = true
        circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        circleView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        circleView.layer.cornerRadius = view.frame.width * circleScale / 2
        
        let settingsButton = CircleButton(color: UIColor.primaryColor, image: settingsImage)
        view.addSubview(settingsButton)
        settingsButton.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
        settingsButton.centerYAnchor.constraint(equalTo: circleView.bottomAnchor).isActive = true
        settingsButton.widthAnchor.constraint(equalTo: circleView.widthAnchor, multiplier: buttonScale).isActive = true
        settingsButton.heightAnchor.constraint(equalTo: circleView.heightAnchor, multiplier: buttonScale).isActive = true
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.addTarget(self, action: #selector(goToSettings(sender:)), for: .touchUpInside)

        let searchButton = CircleButton(color: UIColor.primaryColor, image: searchImage)
        view.addSubview(searchButton)
        searchButton.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
        searchButton.centerYAnchor.constraint(equalTo: circleView.topAnchor).isActive = true
        searchButton.widthAnchor.constraint(equalTo: circleView.widthAnchor, multiplier: buttonScale).isActive = true
        searchButton.heightAnchor.constraint(equalTo: circleView.heightAnchor, multiplier: buttonScale).isActive = true
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.addTarget(self, action: #selector(goToPartyList(sender:)), for: .touchUpInside)

        let hostButton = CircleButton(color: UIColor.primaryColor, image: hostImage)
        view.addSubview(hostButton)
        hostButton.centerXAnchor.constraint(equalTo: circleView.leadingAnchor).isActive = true
        hostButton.centerYAnchor.constraint(equalTo: circleView.centerYAnchor).isActive = true
        hostButton.widthAnchor.constraint(equalTo: circleView.widthAnchor, multiplier: buttonScale).isActive = true
        hostButton.heightAnchor.constraint(equalTo: circleView.heightAnchor, multiplier: buttonScale).isActive = true
        hostButton.translatesAutoresizingMaskIntoConstraints = false
        hostButton.addTarget(self, action: #selector(goToHostParty(sender:)), for: .touchUpInside)

        let otherButton = CircleButton(color: UIColor.primaryColor, image: otherImage)
        view.addSubview(otherButton)
        otherButton.centerXAnchor.constraint(equalTo: circleView.trailingAnchor).isActive = true
        otherButton.centerYAnchor.constraint(equalTo: circleView.centerYAnchor).isActive = true
        otherButton.widthAnchor.constraint(equalTo: circleView.widthAnchor, multiplier: buttonScale).isActive = true
        otherButton.heightAnchor.constraint(equalTo: circleView.heightAnchor, multiplier: buttonScale).isActive = true
        otherButton.translatesAutoresizingMaskIntoConstraints = false
    }
}

