class Mathmini < Formula
  desc "Sample math library containing add and sub functions"
  homepage "https://github.com/JameelKaisar/mathmini-brew"
  url "https://github.com/JameelKaisar/mathmini-brew.git",
      tag:      "v1.0.5",
      revision: "faec24d0969831996e66e1911ac99caebdebeaa3"
  license "MIT"

  bottle do
    root_url "https://github.com/JameelKaisar/homebrew-tap/releases/download/mathmini-1.0.5"
    sha256 cellar: :any,                 ventura:      "20bf6540dc999ef0bdfaf1d3affd59b3ba9952089137807eb11f39194132f3eb"
    sha256 cellar: :any,                 monterey:     "c1e71f704adf2c7aefd7743d6eb9420b94bbf7e0b95a2d9c49ec7f11ab2c3e2b"
    sha256 cellar: :any,                 big_sur:      "d85aa5f9fee2fe0a0c4b4ae65ea360952130390dd38dc09a40bfb6fde0d175c1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "734db7a2c76ff3efb10db9778a0a573e62918bf6f27ed2151fe3577fce15e33a"
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
