class Httm < Formula
  desc "Interactive, file-level Time Machine-like tool for ZFS/btrfs"
  homepage "https://github.com/kimono-koans/httm"
  url "https://github.com/kimono-koans/httm/archive/refs/tags/0.41.0.tar.gz"
  sha256 "72002c5d0b66f0550cd9ea07b2d2ea7d05fc137f793aaa22f92847e010c1e32c"
  license "MPL-2.0"
  head "https://github.com/kimono-koans/httm.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "6d02baddf41b812af2831f9129ee5608783c8c9a80ac73044036262c8f13be42"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c0a108c08c0b0726287253af4de3fb24c252b59bb9d4b726f74ee5c5cb3cf526"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "cfefaf85ed4f276dda79b138d3dee06e34dfc9c35bdd0c8980c7aa8c1de87b66"
    sha256 cellar: :any_skip_relocation, sonoma:         "d3c4ac62f3abf9584080836ee8c9512f74273293366c7de582b2ca4cb866f0c9"
    sha256 cellar: :any_skip_relocation, ventura:        "1f4d284424986d0ced7cc0d56320c18de67dca111192c96d8c9e3f5f42e07d64"
    sha256 cellar: :any_skip_relocation, monterey:       "7e97223d0a671ec0af12800760050cf2a82e33b23669dac57257efaadd1a2cae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "494e0626969fadfc04b56c7e33f195153bef64afce7e853adf9080a46cbfd7d8"
  end

  depends_on "rust" => :build

  on_linux do
    depends_on "acl"
  end

  conflicts_with "nicotine-plus", because: "both install `nicotine` binaries"

  def install
    system "cargo", "install", "--features", "xattrs,acls", *std_cargo_args
    man1.install "httm.1"

    bin.install "scripts/ounce.bash" => "ounce"
    bin.install "scripts/bowie.bash" => "bowie"
    bin.install "scripts/nicotine.bash" => "nicotine"
    bin.install "scripts/equine.bash" => "equine"
  end

  test do
    touch testpath/"foo"
    assert_equal "Error: httm could not find any valid datasets on the system.",
      shell_output("#{bin}/httm #{testpath}/foo 2>&1", 1).strip
    assert_equal "httm #{version}", shell_output("#{bin}/httm --version").strip
  end
end
