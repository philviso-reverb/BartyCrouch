import Foundation
import Toml
import BartyCrouchUtility

public struct NormalizeOptions {
  public let paths: [String]
  public let subpathsToIgnore: [String]
  public let sourceLocale: String
  public let harmonizeWithSource: Bool
  public let sortByKeys: Bool
}

extension NormalizeOptions: TomlCodable {
  static func make(toml: Toml) throws -> NormalizeOptions {
    let update: String = "update"
    let normalize: String = "normalize"

    return NormalizeOptions(
      paths: toml.filePaths(update, normalize, singularKey: "path", pluralKey: "paths"),
      subpathsToIgnore: toml.array(update, normalize, "subpathsToIgnore") ?? Constants.defaultSubpathsToIgnore,
      sourceLocale: toml.string(update, normalize, "sourceLocale") ?? "en",
      harmonizeWithSource: toml.bool(update, normalize, "harmonizeWithSource") ?? true,
      sortByKeys: toml.bool(update, normalize, "sortByKeys") ?? true
    )
  }

  func tomlContents() -> String {
    var lines: [String] = ["[update.normalize]"]

    lines.append("paths = \(paths)")
    lines.append("subpathsToIgnore = \(subpathsToIgnore)")
    lines.append("sourceLocale = \"\(sourceLocale)\"")
    lines.append("harmonizeWithSource = \(harmonizeWithSource)")
    lines.append("sortByKeys = \(sortByKeys)")

    return lines.joined(separator: "\n")
  }
}