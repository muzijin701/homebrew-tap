class MatlabShell < Formula
  desc "Interactive terminal MATLAB CLI (msh / matlab-shell)"
  homepage "https://github.com/muzijin701/matlab-shell"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/muzijin701/matlab-shell/releases/download/v0.1.0/matlab-shell-0.1.0-macos-arm64.tar.gz"
      sha256 "7cb547e09a68516a316c67b70f219313d58ad6b0af91f4432c8b3fdeb49657f9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/muzijin701/matlab-shell/releases/download/v0.1.0/matlab-shell-0.1.0-linux-x86_64.tar.gz"
      sha256 "4f3e9dfa7fe8aa0798483eb811d92ac47ad7e285c0781f905383056889bbdfa1"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"msh"
    bin.install_symlink libexec/"matlab-shell"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/msh --version")
  end
end
