class MatlabShell < Formula
  desc "Interactive terminal MATLAB CLI (msh / matlab-shell)"
  homepage "https://github.com/muzijin701/matlab-shell"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/muzijin701/matlab-shell/releases/download/v0.1.1/matlab-shell-0.1.1-macos-arm64.tar.gz"
      sha256 "a2f8020fbdf2197a0672b0cef7833b91b07abb5a9d509b56abe51926ac40cab2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/muzijin701/matlab-shell/releases/download/v0.1.1/matlab-shell-0.1.1-linux-x86_64.tar.gz"
      sha256 "137c120e4f52c8532d2f0b59f4a3c7c2bc91469b225fa5a20c57532b8312d30e"
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
