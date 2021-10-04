import UIKit

public protocol MaterialSwitchDelegate {
    func switchDidChangeState(aSwitch: MaterialSwitch, currentState: MaterialSwitchState)
}

public enum MaterialSwitchState: Int {
    case Off
    case On
}

// Typealiases
public typealias MaterialSwitchSize = (x: CGFloat, y: CGFloat, radius: CGFloat)

// Class
public class MaterialSwitch: UIView {

    // Public Variables and Constants
    var state: MaterialSwitchState!
    var thumbOnColor: UIColor = .blue
    var thumbOffColor: UIColor = .darkGray
    var trackOnColor: UIColor = .cyan
    var trackOffColor: UIColor = .lightGray
    
    // Private Variables and Constants
    private let size: MaterialSwitchSize!
    private var delegate: MaterialSwitchDelegate?
    private var track: UIView?
    private var thumb: UIView?
    private var flashingThumb: UIView?
    
    // MARK: Initializers
    init(size: MaterialSwitchSize) {
        self.size = size
        super.init(frame: CGRect(x: size.x, y: size.y, width: 1.6*size.radius, height: size.radius))
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    func setup(delegate: MaterialSwitchDelegate) {
        self.delegate = delegate
        state = .Off
        track = setupTrack()
        thumb = setupThumb()
        setupGesture()
        flashingThumb = setupThumb()
    }
    
    func setupTrack() -> UIView {
        
        let track = UIView(frame: CGRect(
            x: size.x + 0.1*size.radius,
            y: size.y + 0.1*size.radius,
            width: 1.6*size.radius,
            height: 0.8*size.radius))
        track.backgroundColor = trackOffColor
        track.layer.cornerRadius = track.frame.height/2.0
        self.addSubview(track)
        
        return track
    }
    
    func setupThumb() -> UIView  {
    
        let thumb = UIView(frame: CGRect(
            x: size.x,
            y: size.y,
            width: size.radius,
            height: size.radius))
        thumb.backgroundColor = thumbOffColor
        thumb.layer.cornerRadius = thumb.frame.height/2.0
        self.addSubview(thumb)
        
        return thumb
    }
    
    func setupGesture() {
        if thumb != nil {
            self.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.animate(_:)))
            tap.numberOfTapsRequired = 1
            self.addGestureRecognizer(tap)
        }
    }
    
    // MARK: Animations!
    @objc func animate(_ sender: UITapGestureRecognizer?) {
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: { () -> Void in
            
            let xOffsetForAnimation: CGFloat = (self.state == .Off) ? (self.size.x + 0.8*self.size.radius) : self.size.x
            self.thumb!.backgroundColor = (self.state == .Off) ? self.thumbOnColor : self.thumbOffColor
            self.track!.backgroundColor = (self.state == .Off) ? self.trackOnColor : self.trackOffColor
            self.thumb!.frame = CGRect(x: xOffsetForAnimation, y: self.size.y, width: self.size.radius, height: self.size.radius)
            
            if (self.state == .Off) {
                self.flashingThumb!.backgroundColor = self.thumb!.backgroundColor
                self.flashingThumb!.frame = self.thumb!.frame
            }
            
            }) { (finished) -> Void in
            
                if (finished) {
                    self.state = (self.state == .Off) ? .On : .Off
                    self.delegate?.switchDidChangeState(aSwitch: self, currentState: self.state)
                }
        }

        UIView.animate(withDuration: 0.35, delay: 0.25, options: .curveEaseOut, animations: { () -> Void in
            
            self.flashingThumb!.alpha = 0.0
            self.flashingThumb!.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            
            }) { (finished) -> Void in
                if (finished) {
                    self.flashingThumb!.removeFromSuperview()
                }
        }
    }
}

