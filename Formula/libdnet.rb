class Libdnet < Formula
  desc "Portable low-level networking library"
  homepage "https://github.com/dugsong/libdnet"
  url "https://github.com/dugsong/libdnet/archive/libdnet-1.12.tar.gz"
  sha256 "b6360659c93fa2e3cde9e0a1fc9c07bc4111f3448c5de856e095eb98315dd424"

  bottle do
    cellar :any
    rebuild 2
    sha256 "bfd53f9a4303380ecab6902b181f82a4f229650663443889e1183f4b865d8761" => :sierra
    sha256 "dc34f5bfbe3385420d7fd482029a3acc3c8328ee145a4fe2fc806f6de22e77f4" => :el_capitan
    sha256 "09996ef2a4fce855bd5302996000f5ab49fd28d3e6bf6f0d82d3f11d495baef1" => :yosemite
    sha256 "1b425f04354f60b2c9de0b6e031d50f626d3cda0dc50c892b163107a6eecacb9" => :mavericks
    sha256 "c8fda878e8ff2a87a3b521ca26a5ebb0d4b9eb82868a92149c723c4bf21f5b79" => :mountain_lion
  end

  option "without-python", "Build without python support"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    # autoreconf to get '.dylib' extension on shared lib
    ENV.append_path "ACLOCAL_PATH", "config"
    system "autoreconf", "-ivf"

    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --mandir=#{man}
    ]
    args << "--with-python" if build.with? "python"
    system "./configure", *args
    system "make", "install"
  end
end
