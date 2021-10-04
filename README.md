# MaterialSwitch
MaterialSwitch to implement custom switch for swift. Tested in iOS15


let size: MaterialSwitchSize = (0, 0, 44)

let aSwitch = MaterialSwitch(size: size)

aSwitch.setup(delegate: self)

aSwitch.center = self.view.center

self.view.addSubview(aSwitch)
