class WechatChannelsDownloader < Formula
  desc "Portable TUI for downloading WeChat Channels videos and image posts"
  homepage "https://github.com/muzijin701/wechat-channels-downloader"
  version "0.2.0"

  on_macos do
    on_arm do
      url "https://github.com/muzijin701/wechat-channels-downloader/releases/download/v0.2.0/wechat-channels-downloader-darwin-arm64.tar.gz"
      sha256 "afae173f59c6d6caff2c243858f867aa81f6aa01c0e4f75234cb4740685ed164"
    end
    on_intel do
      url "https://github.com/muzijin701/wechat-channels-downloader/releases/download/v0.2.0/wechat-channels-downloader-darwin-x64.tar.gz"
      sha256 "8be25f5ddab1c51c3d6549cd481f613b32f41cd448c6fcf86c9c17f80a99b320"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/muzijin701/wechat-channels-downloader/releases/download/v0.2.0/wechat-channels-downloader-linux-x64.tar.gz"
      sha256 "b028d887a1ea72573c30b4a559e63dbe4bc642a5c73e9ed0817bb4f2a5f20494"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"wechat-channels-downloader"
    bin.install_symlink libexec/"wechat-channels-downloader" => "wcd"
  end

  def post_install
    base_dir = var/"wechat-channels-downloader"
    %w[data downloads].each do |dir_name|
      target = base_dir/dir_name
      target.mkpath
      link_path = libexec/dir_name
      rm_rf link_path if link_path.exist? || link_path.symlink?
      link_path.make_symlink target
    end
  end

  def caveats
    <<~EOS
      Persistent login state and downloaded files are stored in:
        #{var}/wechat-channels-downloader/data
        #{var}/wechat-channels-downloader/downloads
      Run `wechat-channels-downloader` (or `wcd`) in Terminal.
      On macOS (unsigned build), you can also launch the app bundle via:
        open #{opt_libexec}/wechat-channels-downloader.app
    EOS
  end

  test do
    assert_predicate bin/"wechat-channels-downloader", :executable?
    assert_predicate bin/"wcd", :executable?
  end
end
