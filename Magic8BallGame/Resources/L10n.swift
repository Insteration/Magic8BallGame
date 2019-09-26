// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// Change your mind
  internal static let changeYourMind = L10n.tr("Localizable", "Change your mind")
  /// Choose answer
  internal static let chooseAnswer = L10n.tr("Localizable", "Choose answer")
  /// Just do it!
  internal static let justDoIt = L10n.tr("Localizable", "Just do it!")
  /// Keep on!
  internal static let keepOn = L10n.tr("Localizable", "Keep on!")
  /// Let's do it!
  internal static let letSDoIt = L10n.tr("Localizable", "Let's do it!")
  /// Not now
  internal static let notNow = L10n.tr("Localizable", "Not now")
  /// String One
  internal static let shakeForAnswer = L10n.tr("Localizable", "Shake for answer")
  /// Wait
  internal static let wait = L10n.tr("Localizable", "Wait")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
