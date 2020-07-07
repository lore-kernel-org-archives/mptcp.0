Content-Type: multipart/mixed; boundary="===============3031977583665781801=="
MIME-Version: 1.0
From: Eric Biggers <ebiggers at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/4] crypto: add sha256() function
Date: Tue, 07 Jul 2020 11:58:14 -0700
Message-ID: <20200707185818.80177-1-ebiggers@kernel.org>
X-Status: 
X-Keywords:                  
X-UID: 4937

--===============3031977583665781801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series adds a function sha256() to the sha256 library so that users
who want to compute a hash in one step can just call sha256() instead of
sha256_init() + sha256_update() + sha256_final().

Patches 2-4 then convert some users to use it.

Eric Biggers (4):
  crypto: lib/sha256 - add sha256() function
  efi: use sha256() instead of open coding
  mptcp: use sha256() instead of open coding
  ASoC: cros_ec_codec: use sha256() instead of open coding

 drivers/firmware/efi/embedded-firmware.c |  9 +++-----
 include/crypto/sha.h                     |  1 +
 lib/crypto/sha256.c                      | 10 +++++++++
 net/mptcp/crypto.c                       | 15 +++----------
 sound/soc/codecs/cros_ec_codec.c         | 27 ++----------------------
 5 files changed, 19 insertions(+), 43 deletions(-)


base-commit: 57c8aa43b9f272c382c253573c82be5cb68fe22d
-- =

2.27.0

--===============3031977583665781801==--
