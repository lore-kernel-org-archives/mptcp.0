Content-Type: multipart/mixed; boundary="===============5945534043720563467=="
MIME-Version: 1.0
From: Eric Biggers <ebiggers at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 0/5] crypto: add sha256() function
Date: Wed, 08 Jul 2020 09:39:38 -0700
Message-ID: <20200708163943.52071-1-ebiggers@kernel.org>
X-Status: 
X-Keywords:                  
X-UID: 4951

--===============5945534043720563467==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series adds a function sha256() to the sha256 library so that users
who want to compute a hash in one step can just call sha256() instead of
sha256_init() + sha256_update() + sha256_final().

Patches 3-5 then convert some users to use it.

Changed v1 =3D> v2:
  - Added sparc patch to fix a build breakage caused by a
    static variable already named "sha256".
  - Added Reviewed-by, Acked-by, and Tested-by tags.

Eric Biggers (5):
  crypto: sparc - rename sha256 to sha256_alg
  crypto: lib/sha256 - add sha256() function
  efi: use sha256() instead of open coding
  mptcp: use sha256() instead of open coding
  ASoC: cros_ec_codec: use sha256() instead of open coding

 arch/sparc/crypto/sha256_glue.c          | 14 ++++++------
 drivers/firmware/efi/embedded-firmware.c |  9 +++-----
 include/crypto/sha.h                     |  1 +
 lib/crypto/sha256.c                      | 10 +++++++++
 net/mptcp/crypto.c                       | 15 +++----------
 sound/soc/codecs/cros_ec_codec.c         | 27 ++----------------------
 6 files changed, 26 insertions(+), 50 deletions(-)


base-commit: 57c8aa43b9f272c382c253573c82be5cb68fe22d
-- =

2.27.0

--===============5945534043720563467==--
