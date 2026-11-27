class WxMiniVideo < Formula
  desc "WeChat Mini Program media sniffer and downloader TUI (macOS preview)"
  homepage "https://github.com/muzijin701/wx-mini-video"
  url "https://github.com/muzijin701/wx-mini-video/releases/download/v0.2.1/wx-mini-video-macos-universal-unsigned.zip"
  version "0.2.1"
  sha256 "0ca51960de4f7872944a1ca8ef1a5970a4ea8f7a8f938184bac78a2883ac011f"
  license :cannot_represent

  depends_on :macos

  def install
    libexec.install Dir["*"]
    cp libexec/"wx-mini-video.yaml", libexec/"wx-mini-video.yaml.default"
    rm libexec/"wx-mini-video.yaml"
    bin.install_symlink libexec/"wx-mini-video.app/Contents/MacOS/wx-mini-video"
    bin.install_symlink libexec/"wx-mini-video.app/Contents/MacOS/wx-mini-video" => "wxmv"
  end

  def post_install
    data_dir = var/"wx-mini-video"
    downloads_dir = data_dir/"downloads"
    config_file = data_dir/"wx-mini-video.yaml"

    downloads_dir.mkpath
    cp libexec/"wx-mini-video.yaml.default", config_file unless config_file.exist?

    rm_rf libexec/"downloads" if (libexec/"downloads").exist? || (libexec/"downloads").symlink?
    (libexec/"downloads").make_symlink downloads_dir

    rm_f libexec/"wx-mini-video.yaml" if (libexec/"wx-mini-video.yaml").exist? || (libexec/"wx-mini-video.yaml").symlink?
    (libexec/"wx-mini-video.yaml").make_symlink config_file
  end

  def caveats
    <<~EOS
      wx-mini-video macOS build is currently unsigned (preview).
      Persistent config and downloads are stored in:
        #{var}/wx-mini-video
      Run `wx-mini-video` (or `wxmv`) in Terminal, or open the app bundle:
        open #{opt_libexec}/wx-mini-video.app
    EOS
  end

  test do
    assert_predicate bin/"wx-mini-video", :executable?
    assert_predicate bin/"wxmv", :executable?
  end
end
