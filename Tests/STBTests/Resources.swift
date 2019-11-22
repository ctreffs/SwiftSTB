//
//  File.swift
//
//
//  Created by Christian Treffs on 22.11.19.
//

import Foundation

enum Resource: String {
    case logo_png = "https://raw.githubusercontent.com/fireblade-engine/media/master/media/Logo.png"
    case colorMap_png = "https://gitlab.com/ctreffs/assets/raw/master/image/ColorMap.png"
    case debug_color_01_png = "https://gitlab.com/ctreffs/assets/raw/master/image/debug/debug_color_01.png"
    case debug_color_02_png = "https://gitlab.com/ctreffs/assets/raw/master/image/debug/debug_color_02.png"
    case taylor_jpeg = "https://gitlab.com/ctreffs/assets/raw/master/image/taylor_texture.jpeg"

    case red_png   = "https://gitlab.com/ctreffs/assets/raw/master/image/debug/red/red.png"
    case green_bmp = "https://gitlab.com/ctreffs/assets/raw/master/image/debug/green/green.bmp"
    case blue_tiff  = "https://gitlab.com/ctreffs/assets/raw/master/image/debug/blue/blue.tiff"
    case white_png = "https://gitlab.com/ctreffs/assets/raw/master/image/debug/white/white.png"
    case black_png = "https://gitlab.com/ctreffs/assets/raw/master/image/debug/black/black.png"

    enum Error: Swift.Error {
        case invalidURL(String)
    }

    static func resourcesDir() -> URL {
        #if os(Linux)
        // linux does not have .allBundles yet.
        let bundle = Bundle.main
        #else
        guard let bundle = Bundle.allBundles.first(where: { $0.bundlePath.contains("Tests") }) else {
            fatalError("no test bundle found")
        }
        #endif
        var resourcesURL: URL = bundle.bundleURL
        resourcesURL.deleteLastPathComponent()
        return resourcesURL
    }

    static func load(_ resource: Resource) throws -> URL {
        guard let remoteURL: URL = URL(string: resource.rawValue) else {
            throw Error.invalidURL(resource.rawValue)
        }

        var name: String = remoteURL.pathComponents.reversed().prefix(3).reversed().joined(separator: "_")
        name.append(".")
        name.append(remoteURL.lastPathComponent)

        let localFile: URL = resourcesDir().appendingPathComponent(name)
        if !FileManager.default.fileExists(atPath: localFile.path) {
            let data = try Data(contentsOf: remoteURL)
            try data.write(to: localFile)
            print("⬇ Downloaded '\(localFile.path)' ⬇")
        }

        return localFile
    }
}
