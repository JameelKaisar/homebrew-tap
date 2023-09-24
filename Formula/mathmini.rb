class Mathmini < Formula
  desc "Sample math library containing add and sub functions"
  homepage "https://github.com/JameelKaisar/mathmini-brew"
  url "https://github.com/JameelKaisar/mathmini-brew.git",
      tag:      "v1.0.2",
      revision: "d7b55f373b83b0ed8c699e3bdb0ec40e6c7fa5b8"
  license "MIT"

  bottle do
    root_url "https://github.com/JameelKaisar/homebrew-tap/releases/download/mathmini-1.0.2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "558d46aaa74d91d6821d88baaf6c7c7bccfaedcd31f80467cd1038a0908186b5"
  end

  depends_on "gcc" => :build
  depends_on "make" => :build

  def install
    system "make", "-C", "src"
    bin.install "src/mathmini"
    man1.install "docs/mathmini.1"
    include.install "src/mathmini.h"
    lib.install "src/libmathmini.a"
    if OS.mac?
      lib.install "src/libmathmini.dylib"
    elsif OS.linux?
      lib.install "src/libmathmini.so"
    end
  end

  def caveats
    <<~EOS
      To view the man page, use:
        man mathmini
    EOS
  end

  test do
    assert_match shell_output("#{bin}/mathmini add 10 5"), "add(10, 5) = 15\n"
    assert_match shell_output("#{bin}/mathmini sub 10 5"), "sub(10, 5) = 5\n"
  end
end
