class Httm < Formula
  desc "Interactive, file-level Time Machine-like tool for ZFS/btrfs"
  homepage "https://github.com/kimono-koans/httm"
  url "https://github.com/kimono-koans/httm/archive/refs/tags/0.45.4.tar.gz"
  sha256 "ff130208f7d16798b4b4bf07e692299b11017df22de89307a9a42b8059db15cc"
  license "MPL-2.0"
  head "https://github.com/kimono-koans/httm.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4c6e9cae5be2dfea1805904c11072fabf0840630f9bc51cb0aad30fbc5d59edb"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "08b6c0523df8d000af4c313a312efde492f79265708b1af0e5e52f761f1e9bba"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "879d351517f9b644238ebb9e7a0b05912408ff4c302bbb668179e956d7327b78"
    sha256 cellar: :any_skip_relocation, sonoma:        "999e04b2eb21b8425beecce0ea7429c5b6010e2d54dfa06adabb369d9a4f8572"
    sha256 cellar: :any_skip_relocation, ventura:       "842d97a98f3c4a573b0612f1263ba6cfeeffb46a018989c4fd3c9dee2031f687"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d7d3b0f49d4f78f8425ce69f91440b009220a014361c61ec14220c4a46bbdad0"
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
    assert_equal "ERROR: httm could not find any valid datasets on the system.",
      shell_output("#{bin}/httm #{testpath}/foo 2>&1", 1).strip
    assert_equal "httm #{version}", shell_output("#{bin}/httm --version").strip
  end
end
