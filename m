Content-Type: multipart/mixed; boundary="===============6507749626513103708=="
MIME-Version: 1.0
From: Ard Biesheuvel <ardb at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/4] crypto: add sha256() function
Date: Wed, 08 Jul 2020 08:47:40 +0300
Message-ID: <CAMj1kXHPazApxFDK9nz=1V+-dyu7dStiMOu=LdD=i9NXqxjY=g@mail.gmail.com>
In-Reply-To: 20200707185818.80177-1-ebiggers@kernel.org
X-Status: 
X-Keywords:                  
X-UID: 4943

--===============6507749626513103708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Jul 2020 at 21:59, Eric Biggers <ebiggers(a)kernel.org> wrote:
>
> This series adds a function sha256() to the sha256 library so that users
> who want to compute a hash in one step can just call sha256() instead of
> sha256_init() + sha256_update() + sha256_final().
>
> Patches 2-4 then convert some users to use it.
>
> Eric Biggers (4):
>   crypto: lib/sha256 - add sha256() function
>   efi: use sha256() instead of open coding
>   mptcp: use sha256() instead of open coding
>   ASoC: cros_ec_codec: use sha256() instead of open coding
>

For the series,

Reviewed-by: Ard Biesheuvel <ardb(a)kernel.org>

Feel free to take the EFI patch through the crypto tree.


>  drivers/firmware/efi/embedded-firmware.c |  9 +++-----
>  include/crypto/sha.h                     |  1 +
>  lib/crypto/sha256.c                      | 10 +++++++++
>  net/mptcp/crypto.c                       | 15 +++----------
>  sound/soc/codecs/cros_ec_codec.c         | 27 ++----------------------
>  5 files changed, 19 insertions(+), 43 deletions(-)
>
>
> base-commit: 57c8aa43b9f272c382c253573c82be5cb68fe22d
> --
> 2.27.0
>
--===============6507749626513103708==--
