import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 11.0, macOS 10.13, tvOS 11.0, *)
extension ColorResource {

}

// MARK: - Image Symbols -

@available(iOS 11.0, macOS 10.7, tvOS 11.0, *)
extension ImageResource {

    /// The "ac_edn_image" asset catalog image resource.
    static let acEdn = ImageResource(name: "ac_edn_image", bundle: resourceBundle)

    /// The "ac_en_image" asset catalog image resource.
    static let acEn = ImageResource(name: "ac_en_image", bundle: resourceBundle)

    /// The "ac_ri_list_image" asset catalog image resource.
    static let acRiList = ImageResource(name: "ac_ri_list_image", bundle: resourceBundle)

    /// The "ad_go_image" asset catalog image resource.
    static let adGo = ImageResource(name: "ad_go_image", bundle: resourceBundle)

    /// The "apply_btn_image" asset catalog image resource.
    static let applyBtn = ImageResource(name: "apply_btn_image", bundle: resourceBundle)

    /// The "au_01_image" asset catalog image resource.
    static let au01 = ImageResource(name: "au_01_image", bundle: resourceBundle)

    /// The "au_02_image" asset catalog image resource.
    static let au02 = ImageResource(name: "au_02_image", bundle: resourceBundle)

    /// The "au_03_image" asset catalog image resource.
    static let au03 = ImageResource(name: "au_03_image", bundle: resourceBundle)

    /// The "au_04_image" asset catalog image resource.
    static let au04 = ImageResource(name: "au_04_image", bundle: resourceBundle)

    /// The "aud_01_image" asset catalog image resource.
    static let aud01 = ImageResource(name: "aud_01_image", bundle: resourceBundle)

    /// The "aud_02_image" asset catalog image resource.
    static let aud02 = ImageResource(name: "aud_02_image", bundle: resourceBundle)

    /// The "aud_03_image" asset catalog image resource.
    static let aud03 = ImageResource(name: "aud_03_image", bundle: resourceBundle)

    /// The "aud_04_image" asset catalog image resource.
    static let aud04 = ImageResource(name: "aud_04_image", bundle: resourceBundle)

    /// The "aud_05_image" asset catalog image resource.
    static let aud05 = ImageResource(name: "aud_05_image", bundle: resourceBundle)

    /// The "back_ic_image" asset catalog image resource.
    static let backIc = ImageResource(name: "back_ic_image", bundle: resourceBundle)

    /// The "can_en_image" asset catalog image resource.
    static let canEn = ImageResource(name: "can_en_image", bundle: resourceBundle)

    /// The "cen_bg_image" asset catalog image resource.
    static let cenBg = ImageResource(name: "cen_bg_image", bundle: resourceBundle)

    /// The "cli_a_a_image" asset catalog image resource.
    static let cliAA = ImageResource(name: "cli_a_a_image", bundle: resourceBundle)

    /// The "com_ac_bg_image" asset catalog image resource.
    static let comAcBg = ImageResource(name: "com_ac_bg_image", bundle: resourceBundle)

    /// The "eid_mc_image" asset catalog image resource.
    static let eidMc = ImageResource(name: "eid_mc_image", bundle: resourceBundle)

    /// The "em_ic_image" asset catalog image resource.
    static let emIc = ImageResource(name: "em_ic_image", bundle: resourceBundle)

    /// The "em_icm_image" asset catalog image resource.
    static let emIcm = ImageResource(name: "em_icm_image", bundle: resourceBundle)

    /// The "en_mc_image" asset catalog image resource.
    static let enMc = ImageResource(name: "en_mc_image", bundle: resourceBundle)

    /// The "enc_ad_image" asset catalog image resource.
    static let encAd = ImageResource(name: "enc_ad_image", bundle: resourceBundle)

    /// The "fa_ca_bg_image" asset catalog image resource.
    static let faCaBg = ImageResource(name: "fa_ca_bg_image", bundle: resourceBundle)

    /// The "fad_ca_bg_image" asset catalog image resource.
    static let fadCaBg = ImageResource(name: "fad_ca_bg_image", bundle: resourceBundle)

    /// The "home_card_image" asset catalog image resource.
    static let homeCard = ImageResource(name: "home_card_image", bundle: resourceBundle)

    /// The "home_ct_image" asset catalog image resource.
    static let homeCt = ImageResource(name: "home_ct_image", bundle: resourceBundle)

    /// The "item_bg_image" asset catalog image resource.
    static let itemBg = ImageResource(name: "item_bg_image", bundle: resourceBundle)

    /// The "launch_image" asset catalog image resource.
    static let launch = ImageResource(name: "launch_image", bundle: resourceBundle)

    /// The "loan_nor_image" asset catalog image resource.
    static let loanNor = ImageResource(name: "loan_nor_image", bundle: resourceBundle)

    /// The "loan_sel_image" asset catalog image resource.
    static let loanSel = ImageResource(name: "loan_sel_image", bundle: resourceBundle)

    /// The "log_in_bg_image" asset catalog image resource.
    static let logInBg = ImageResource(name: "log_in_bg_image", bundle: resourceBundle)

    /// The "login_bg_image" asset catalog image resource.
    static let loginBg = ImageResource(name: "login_bg_image", bundle: resourceBundle)

    /// The "login_ex_image" asset catalog image resource.
    static let loginEx = ImageResource(name: "login_ex_image", bundle: resourceBundle)

    /// The "login_logo_image" asset catalog image resource.
    static let loginLogo = ImageResource(name: "login_logo_image", bundle: resourceBundle)

    /// The "mc_nor_image" asset catalog image resource.
    static let mcNor = ImageResource(name: "mc_nor_image", bundle: resourceBundle)

    /// The "mc_sel_image" asset catalog image resource.
    static let mcSel = ImageResource(name: "mc_sel_image", bundle: resourceBundle)

    /// The "mine_nor_image" asset catalog image resource.
    static let mineNor = ImageResource(name: "mine_nor_image", bundle: resourceBundle)

    /// The "mine_sel_image" asset catalog image resource.
    static let mineSel = ImageResource(name: "mine_sel_image", bundle: resourceBundle)

    /// The "oc_bg_image" asset catalog image resource.
    static let ocBg = ImageResource(name: "oc_bg_image", bundle: resourceBundle)

    /// The "order_nor_image" asset catalog image resource.
    static let orderNor = ImageResource(name: "order_nor_image", bundle: resourceBundle)

    /// The "order_sel_image" asset catalog image resource.
    static let orderSel = ImageResource(name: "order_sel_image", bundle: resourceBundle)

    /// The "pc_adt_image" asset catalog image resource.
    static let pcAdt = ImageResource(name: "pc_adt_image", bundle: resourceBundle)

    /// The "pc_as_image" asset catalog image resource.
    static let pcAs = ImageResource(name: "pc_as_image", bundle: resourceBundle)

    /// The "pc_asf_image" asset catalog image resource.
    static let pcAsf = ImageResource(name: "pc_asf_image", bundle: resourceBundle)

    /// The "pc_ast_image" asset catalog image resource.
    static let pcAst = ImageResource(name: "pc_ast_image", bundle: resourceBundle)

    /// The "pc_c_imgae" asset catalog image resource.
    static let pcCImgae = ImageResource(name: "pc_c_imgae", bundle: resourceBundle)

    /// The "pe_a_image" asset catalog image resource.
    static let peA = ImageResource(name: "pe_a_image", bundle: resourceBundle)

    /// The "pe_an_image" asset catalog image resource.
    static let peAn = ImageResource(name: "pe_an_image", bundle: resourceBundle)

    /// The "qn_en_image" asset catalog image resource.
    static let qnEn = ImageResource(name: "qn_en_image", bundle: resourceBundle)

    /// The "qnd_en_image" asset catalog image resource.
    static let qndEn = ImageResource(name: "qnd_en_image", bundle: resourceBundle)

    /// The "sac_edn_image" asset catalog image resource.
    static let sacEdn = ImageResource(name: "sac_edn_image", bundle: resourceBundle)

    /// The "saf_en_image" asset catalog image resource.
    static let safEn = ImageResource(name: "saf_en_image", bundle: resourceBundle)

    /// The "send_code_image" asset catalog image resource.
    static let sendCode = ImageResource(name: "send_code_image", bundle: resourceBundle)

    /// The "suc_bg_a_image" asset catalog image resource.
    static let sucBgA = ImageResource(name: "suc_bg_a_image", bundle: resourceBundle)

    /// The "suc_bg_ad_image" asset catalog image resource.
    static let sucBgAd = ImageResource(name: "suc_bg_ad_image", bundle: resourceBundle)

    /// The "tc_im_imager" asset catalog image resource.
    static let tcImImager = ImageResource(name: "tc_im_imager", bundle: resourceBundle)

    /// The "tim_c_image" asset catalog image resource.
    static let timC = ImageResource(name: "tim_c_image", bundle: resourceBundle)

    /// The "try_again_image" asset catalog image resource.
    static let tryAgain = ImageResource(name: "try_again_image", bundle: resourceBundle)

    /// The "wo_bg_image" asset catalog image resource.
    static let woBg = ImageResource(name: "wo_bg_image", bundle: resourceBundle)

}

// MARK: - Color Symbol Extensions -

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

}
#endif

// MARK: - Image Symbol Extensions -

#if canImport(AppKit)
@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    /// The "ac_edn_image" asset catalog image.
    static var acEdn: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .acEdn)
#else
        .init()
#endif
    }

    /// The "ac_en_image" asset catalog image.
    static var acEn: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .acEn)
#else
        .init()
#endif
    }

    /// The "ac_ri_list_image" asset catalog image.
    static var acRiList: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .acRiList)
#else
        .init()
#endif
    }

    /// The "ad_go_image" asset catalog image.
    static var adGo: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .adGo)
#else
        .init()
#endif
    }

    /// The "apply_btn_image" asset catalog image.
    static var applyBtn: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .applyBtn)
#else
        .init()
#endif
    }

    /// The "au_01_image" asset catalog image.
    static var au01: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .au01)
#else
        .init()
#endif
    }

    /// The "au_02_image" asset catalog image.
    static var au02: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .au02)
#else
        .init()
#endif
    }

    /// The "au_03_image" asset catalog image.
    static var au03: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .au03)
#else
        .init()
#endif
    }

    /// The "au_04_image" asset catalog image.
    static var au04: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .au04)
#else
        .init()
#endif
    }

    /// The "aud_01_image" asset catalog image.
    static var aud01: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .aud01)
#else
        .init()
#endif
    }

    /// The "aud_02_image" asset catalog image.
    static var aud02: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .aud02)
#else
        .init()
#endif
    }

    /// The "aud_03_image" asset catalog image.
    static var aud03: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .aud03)
#else
        .init()
#endif
    }

    /// The "aud_04_image" asset catalog image.
    static var aud04: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .aud04)
#else
        .init()
#endif
    }

    /// The "aud_05_image" asset catalog image.
    static var aud05: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .aud05)
#else
        .init()
#endif
    }

    /// The "back_ic_image" asset catalog image.
    static var backIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .backIc)
#else
        .init()
#endif
    }

    /// The "can_en_image" asset catalog image.
    static var canEn: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .canEn)
#else
        .init()
#endif
    }

    /// The "cen_bg_image" asset catalog image.
    static var cenBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .cenBg)
#else
        .init()
#endif
    }

    /// The "cli_a_a_image" asset catalog image.
    static var cliAA: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .cliAA)
#else
        .init()
#endif
    }

    /// The "com_ac_bg_image" asset catalog image.
    static var comAcBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .comAcBg)
#else
        .init()
#endif
    }

    /// The "eid_mc_image" asset catalog image.
    static var eidMc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .eidMc)
#else
        .init()
#endif
    }

    /// The "em_ic_image" asset catalog image.
    static var emIc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .emIc)
#else
        .init()
#endif
    }

    /// The "em_icm_image" asset catalog image.
    static var emIcm: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .emIcm)
#else
        .init()
#endif
    }

    /// The "en_mc_image" asset catalog image.
    static var enMc: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .enMc)
#else
        .init()
#endif
    }

    /// The "enc_ad_image" asset catalog image.
    static var encAd: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .encAd)
#else
        .init()
#endif
    }

    /// The "fa_ca_bg_image" asset catalog image.
    static var faCaBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .faCaBg)
#else
        .init()
#endif
    }

    /// The "fad_ca_bg_image" asset catalog image.
    static var fadCaBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .fadCaBg)
#else
        .init()
#endif
    }

    /// The "home_card_image" asset catalog image.
    static var homeCard: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .homeCard)
#else
        .init()
#endif
    }

    /// The "home_ct_image" asset catalog image.
    static var homeCt: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .homeCt)
#else
        .init()
#endif
    }

    /// The "item_bg_image" asset catalog image.
    static var itemBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .itemBg)
#else
        .init()
#endif
    }

    /// The "launch_image" asset catalog image.
    static var launch: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .launch)
#else
        .init()
#endif
    }

    /// The "loan_nor_image" asset catalog image.
    static var loanNor: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .loanNor)
#else
        .init()
#endif
    }

    /// The "loan_sel_image" asset catalog image.
    static var loanSel: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .loanSel)
#else
        .init()
#endif
    }

    /// The "log_in_bg_image" asset catalog image.
    static var logInBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .logInBg)
#else
        .init()
#endif
    }

    /// The "login_bg_image" asset catalog image.
    static var loginBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .loginBg)
#else
        .init()
#endif
    }

    /// The "login_ex_image" asset catalog image.
    static var loginEx: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .loginEx)
#else
        .init()
#endif
    }

    /// The "login_logo_image" asset catalog image.
    static var loginLogo: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .loginLogo)
#else
        .init()
#endif
    }

    /// The "mc_nor_image" asset catalog image.
    static var mcNor: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .mcNor)
#else
        .init()
#endif
    }

    /// The "mc_sel_image" asset catalog image.
    static var mcSel: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .mcSel)
#else
        .init()
#endif
    }

    /// The "mine_nor_image" asset catalog image.
    static var mineNor: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .mineNor)
#else
        .init()
#endif
    }

    /// The "mine_sel_image" asset catalog image.
    static var mineSel: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .mineSel)
#else
        .init()
#endif
    }

    /// The "oc_bg_image" asset catalog image.
    static var ocBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .ocBg)
#else
        .init()
#endif
    }

    /// The "order_nor_image" asset catalog image.
    static var orderNor: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .orderNor)
#else
        .init()
#endif
    }

    /// The "order_sel_image" asset catalog image.
    static var orderSel: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .orderSel)
#else
        .init()
#endif
    }

    /// The "pc_adt_image" asset catalog image.
    static var pcAdt: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .pcAdt)
#else
        .init()
#endif
    }

    /// The "pc_as_image" asset catalog image.
    static var pcAs: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .pcAs)
#else
        .init()
#endif
    }

    /// The "pc_asf_image" asset catalog image.
    static var pcAsf: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .pcAsf)
#else
        .init()
#endif
    }

    /// The "pc_ast_image" asset catalog image.
    static var pcAst: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .pcAst)
#else
        .init()
#endif
    }

    /// The "pc_c_imgae" asset catalog image.
    static var pcCImgae: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .pcCImgae)
#else
        .init()
#endif
    }

    /// The "pe_a_image" asset catalog image.
    static var peA: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .peA)
#else
        .init()
#endif
    }

    /// The "pe_an_image" asset catalog image.
    static var peAn: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .peAn)
#else
        .init()
#endif
    }

    /// The "qn_en_image" asset catalog image.
    static var qnEn: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .qnEn)
#else
        .init()
#endif
    }

    /// The "qnd_en_image" asset catalog image.
    static var qndEn: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .qndEn)
#else
        .init()
#endif
    }

    /// The "sac_edn_image" asset catalog image.
    static var sacEdn: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .sacEdn)
#else
        .init()
#endif
    }

    /// The "saf_en_image" asset catalog image.
    static var safEn: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .safEn)
#else
        .init()
#endif
    }

    /// The "send_code_image" asset catalog image.
    static var sendCode: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .sendCode)
#else
        .init()
#endif
    }

    /// The "suc_bg_a_image" asset catalog image.
    static var sucBgA: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .sucBgA)
#else
        .init()
#endif
    }

    /// The "suc_bg_ad_image" asset catalog image.
    static var sucBgAd: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .sucBgAd)
#else
        .init()
#endif
    }

    /// The "tc_im_imager" asset catalog image.
    static var tcImImager: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .tcImImager)
#else
        .init()
#endif
    }

    /// The "tim_c_image" asset catalog image.
    static var timC: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .timC)
#else
        .init()
#endif
    }

    /// The "try_again_image" asset catalog image.
    static var tryAgain: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .tryAgain)
#else
        .init()
#endif
    }

    /// The "wo_bg_image" asset catalog image.
    static var woBg: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .woBg)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// The "ac_edn_image" asset catalog image.
    static var acEdn: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .acEdn)
#else
        .init()
#endif
    }

    /// The "ac_en_image" asset catalog image.
    static var acEn: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .acEn)
#else
        .init()
#endif
    }

    /// The "ac_ri_list_image" asset catalog image.
    static var acRiList: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .acRiList)
#else
        .init()
#endif
    }

    /// The "ad_go_image" asset catalog image.
    static var adGo: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .adGo)
#else
        .init()
#endif
    }

    /// The "apply_btn_image" asset catalog image.
    static var applyBtn: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .applyBtn)
#else
        .init()
#endif
    }

    /// The "au_01_image" asset catalog image.
    static var au01: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .au01)
#else
        .init()
#endif
    }

    /// The "au_02_image" asset catalog image.
    static var au02: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .au02)
#else
        .init()
#endif
    }

    /// The "au_03_image" asset catalog image.
    static var au03: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .au03)
#else
        .init()
#endif
    }

    /// The "au_04_image" asset catalog image.
    static var au04: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .au04)
#else
        .init()
#endif
    }

    /// The "aud_01_image" asset catalog image.
    static var aud01: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .aud01)
#else
        .init()
#endif
    }

    /// The "aud_02_image" asset catalog image.
    static var aud02: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .aud02)
#else
        .init()
#endif
    }

    /// The "aud_03_image" asset catalog image.
    static var aud03: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .aud03)
#else
        .init()
#endif
    }

    /// The "aud_04_image" asset catalog image.
    static var aud04: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .aud04)
#else
        .init()
#endif
    }

    /// The "aud_05_image" asset catalog image.
    static var aud05: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .aud05)
#else
        .init()
#endif
    }

    /// The "back_ic_image" asset catalog image.
    static var backIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .backIc)
#else
        .init()
#endif
    }

    /// The "can_en_image" asset catalog image.
    static var canEn: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .canEn)
#else
        .init()
#endif
    }

    /// The "cen_bg_image" asset catalog image.
    static var cenBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .cenBg)
#else
        .init()
#endif
    }

    /// The "cli_a_a_image" asset catalog image.
    static var cliAA: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .cliAA)
#else
        .init()
#endif
    }

    /// The "com_ac_bg_image" asset catalog image.
    static var comAcBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .comAcBg)
#else
        .init()
#endif
    }

    /// The "eid_mc_image" asset catalog image.
    static var eidMc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .eidMc)
#else
        .init()
#endif
    }

    /// The "em_ic_image" asset catalog image.
    static var emIc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .emIc)
#else
        .init()
#endif
    }

    /// The "em_icm_image" asset catalog image.
    static var emIcm: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .emIcm)
#else
        .init()
#endif
    }

    /// The "en_mc_image" asset catalog image.
    static var enMc: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .enMc)
#else
        .init()
#endif
    }

    /// The "enc_ad_image" asset catalog image.
    static var encAd: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .encAd)
#else
        .init()
#endif
    }

    /// The "fa_ca_bg_image" asset catalog image.
    static var faCaBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .faCaBg)
#else
        .init()
#endif
    }

    /// The "fad_ca_bg_image" asset catalog image.
    static var fadCaBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .fadCaBg)
#else
        .init()
#endif
    }

    /// The "home_card_image" asset catalog image.
    static var homeCard: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .homeCard)
#else
        .init()
#endif
    }

    /// The "home_ct_image" asset catalog image.
    static var homeCt: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .homeCt)
#else
        .init()
#endif
    }

    /// The "item_bg_image" asset catalog image.
    static var itemBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .itemBg)
#else
        .init()
#endif
    }

    /// The "launch_image" asset catalog image.
    static var launch: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .launch)
#else
        .init()
#endif
    }

    /// The "loan_nor_image" asset catalog image.
    static var loanNor: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .loanNor)
#else
        .init()
#endif
    }

    /// The "loan_sel_image" asset catalog image.
    static var loanSel: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .loanSel)
#else
        .init()
#endif
    }

    /// The "log_in_bg_image" asset catalog image.
    static var logInBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .logInBg)
#else
        .init()
#endif
    }

    /// The "login_bg_image" asset catalog image.
    static var loginBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .loginBg)
#else
        .init()
#endif
    }

    /// The "login_ex_image" asset catalog image.
    static var loginEx: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .loginEx)
#else
        .init()
#endif
    }

    /// The "login_logo_image" asset catalog image.
    static var loginLogo: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .loginLogo)
#else
        .init()
#endif
    }

    /// The "mc_nor_image" asset catalog image.
    static var mcNor: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .mcNor)
#else
        .init()
#endif
    }

    /// The "mc_sel_image" asset catalog image.
    static var mcSel: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .mcSel)
#else
        .init()
#endif
    }

    /// The "mine_nor_image" asset catalog image.
    static var mineNor: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .mineNor)
#else
        .init()
#endif
    }

    /// The "mine_sel_image" asset catalog image.
    static var mineSel: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .mineSel)
#else
        .init()
#endif
    }

    /// The "oc_bg_image" asset catalog image.
    static var ocBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .ocBg)
#else
        .init()
#endif
    }

    /// The "order_nor_image" asset catalog image.
    static var orderNor: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .orderNor)
#else
        .init()
#endif
    }

    /// The "order_sel_image" asset catalog image.
    static var orderSel: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .orderSel)
#else
        .init()
#endif
    }

    /// The "pc_adt_image" asset catalog image.
    static var pcAdt: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .pcAdt)
#else
        .init()
#endif
    }

    /// The "pc_as_image" asset catalog image.
    static var pcAs: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .pcAs)
#else
        .init()
#endif
    }

    /// The "pc_asf_image" asset catalog image.
    static var pcAsf: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .pcAsf)
#else
        .init()
#endif
    }

    /// The "pc_ast_image" asset catalog image.
    static var pcAst: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .pcAst)
#else
        .init()
#endif
    }

    /// The "pc_c_imgae" asset catalog image.
    static var pcCImgae: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .pcCImgae)
#else
        .init()
#endif
    }

    /// The "pe_a_image" asset catalog image.
    static var peA: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .peA)
#else
        .init()
#endif
    }

    /// The "pe_an_image" asset catalog image.
    static var peAn: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .peAn)
#else
        .init()
#endif
    }

    /// The "qn_en_image" asset catalog image.
    static var qnEn: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .qnEn)
#else
        .init()
#endif
    }

    /// The "qnd_en_image" asset catalog image.
    static var qndEn: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .qndEn)
#else
        .init()
#endif
    }

    /// The "sac_edn_image" asset catalog image.
    static var sacEdn: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .sacEdn)
#else
        .init()
#endif
    }

    /// The "saf_en_image" asset catalog image.
    static var safEn: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .safEn)
#else
        .init()
#endif
    }

    /// The "send_code_image" asset catalog image.
    static var sendCode: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .sendCode)
#else
        .init()
#endif
    }

    /// The "suc_bg_a_image" asset catalog image.
    static var sucBgA: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .sucBgA)
#else
        .init()
#endif
    }

    /// The "suc_bg_ad_image" asset catalog image.
    static var sucBgAd: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .sucBgAd)
#else
        .init()
#endif
    }

    /// The "tc_im_imager" asset catalog image.
    static var tcImImager: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .tcImImager)
#else
        .init()
#endif
    }

    /// The "tim_c_image" asset catalog image.
    static var timC: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .timC)
#else
        .init()
#endif
    }

    /// The "try_again_image" asset catalog image.
    static var tryAgain: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .tryAgain)
#else
        .init()
#endif
    }

    /// The "wo_bg_image" asset catalog image.
    static var woBg: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .woBg)
#else
        .init()
#endif
    }

}
#endif

// MARK: - Thinnable Asset Support -

@available(iOS 11.0, macOS 10.13, tvOS 11.0, *)
@available(watchOS, unavailable)
extension ColorResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if AppKit.NSColor(named: NSColor.Name(thinnableName), bundle: bundle) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIColor(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    private convenience init?(thinnableResource: ColorResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    private init?(thinnableResource: ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    private init?(thinnableResource: ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}
#endif

@available(iOS 11.0, macOS 10.7, tvOS 11.0, *)
@available(watchOS, unavailable)
extension ImageResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if bundle.image(forResource: NSImage.Name(thinnableName)) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIImage(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    private convenience init?(thinnableResource: ImageResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    private convenience init?(thinnableResource: ImageResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

// MARK: - Backwards Deployment Support -

/// A color resource.
struct ColorResource: Swift.Hashable, Swift.Sendable {

    /// An asset catalog color resource name.
    fileprivate let name: Swift.String

    /// An asset catalog color resource bundle.
    fileprivate let bundle: Foundation.Bundle

    /// Initialize a `ColorResource` with `name` and `bundle`.
    init(name: Swift.String, bundle: Foundation.Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

/// An image resource.
struct ImageResource: Swift.Hashable, Swift.Sendable {

    /// An asset catalog image resource name.
    fileprivate let name: Swift.String

    /// An asset catalog image resource bundle.
    fileprivate let bundle: Foundation.Bundle

    /// Initialize an `ImageResource` with `name` and `bundle`.
    init(name: Swift.String, bundle: Foundation.Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    /// Initialize a `NSColor` with a color resource.
    convenience init(resource: ColorResource) {
        self.init(named: NSColor.Name(resource.name), bundle: resource.bundle)!
    }

}

protocol _ACResourceInitProtocol {}
extension AppKit.NSImage: _ACResourceInitProtocol {}

@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension _ACResourceInitProtocol {

    /// Initialize a `NSImage` with an image resource.
    init(resource: ImageResource) {
        self = resource.bundle.image(forResource: NSImage.Name(resource.name))! as! Self
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    /// Initialize a `UIColor` with a color resource.
    convenience init(resource: ColorResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}

@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// Initialize a `UIImage` with an image resource.
    convenience init(resource: ImageResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    /// Initialize a `Color` with a color resource.
    init(_ resource: ColorResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Image {

    /// Initialize an `Image` with an image resource.
    init(_ resource: ImageResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}
#endif