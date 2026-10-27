cask "podrouter" do
  version "0.1.0"
  sha256 "afe937c0d86ffdb9baae7918dbdf1a60270b3fdd994fe618375fbc914283581b"

  url "https://github.com/hrunj1230/podrouter/releases/download/v#{version}/podrouter.zip"
  name "podrouter"
  desc "Turn RunPod GPU pods on and off"
  homepage "https://github.com/hrunj1230/podrouter"

  depends_on formula: "python@3.12"
  depends_on macos: :sonoma

  app "podrouter.app"

  # Ad-hoc signed, not notarized. Clearing quarantine lets it open without a warning.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-cr", "{{appdir}}/podrouter.app"]
  end

  uninstall launchctl: "io.github.hrunj1230.podrouter"

  # ~/podrouter holds the user's keys and Pod settings; it is left alone.
  zap trash: [
    "~/Library/Application Support/podrouter",
    "~/Library/LaunchAgents/io.github.hrunj1230.podrouter.plist",
    "~/Library/Preferences/io.github.hrunj1230.podrouter.plist",
  ]
end
