import Orion
import UIKit
import DankTimeC

class _UIStatusBarStringView_Hook: ClassHook<_UIStatusBarStringView> {

    func initWithFrame(_ frame: CGRect) -> Target {
        NotificationCenter.default.addObserver(target, selector: #selector(RUT_update_text), name: Notification.Name("RUT_UpdateText"), object: nil)
        return orig.initWithFrame(frame)
    }
    
    func applyStyleAttributes(_ arg1: AnyObject) {
        orig.applyStyleAttributes(arg1)
                
        guard RUT_Label_Is_Suitable() else {
            return
        }
    }
    
    func setText(_ text: String) {
	let txt = text.replacingOccurrences(of: "04:20", with: "4:20", options: .literal, range: nil).replacingOccurrences(of: "16:20", with: "4:20", options: .literal, range: nil)
	if RUT_Label_Is_Suitable() {
            orig.setText(txt)
        } else {
            orig.setText(txt)
        }
    }

    //orion: new
    func RUT_update_text() {
        setText(target.text!)
    }
    
    //orion: new
    func RUT_Label_Is_Suitable() -> Bool {
        return target.fontStyle == 1
    }
    
    //orion: new
    func RUT_is_FaceID_iPhone() -> Bool {
        return (!UIDevice.currentIsIPad() && UIDevice.tf_deviceHasFaceID())
    }
}

//MARK: - Fix updating text when status bar style changes, or when front-most app changes.
class SpringBoard_Hook: ClassHook<SpringBoard> {
    func frontDisplayDidChange(_ arg1: AnyObject) {
        orig.frontDisplayDidChange(arg1)
        NotificationCenter.default.post(name: NSNotification.Name("RUT_UpdateText"), object: nil)
    }
}

class SBIconController_Hook: ClassHook<SBIconController> {
    func _controlCenterWillDismiss(_ arg1: AnyObject) {
        orig._controlCenterWillDismiss(arg1)
        NotificationCenter.default.post(name: NSNotification.Name("RUT_UpdateText"), object: nil)
    }
}
