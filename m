Content-Type: multipart/mixed; boundary="===============3119082816403254337=="
MIME-Version: 1.0
From: Hans de Goede <hdegoede at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/4] crypto: add sha256() function
Date: Wed, 08 Jul 2020 13:01:34 +0200
Message-ID: <7b5617f4-905f-5f27-9caf-3c842cbdb0d8@redhat.com>
In-Reply-To: 20200707185818.80177-1-ebiggers@kernel.org
X-Status: 
X-Keywords:                  
X-UID: 4946

--===============3119082816403254337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 7/7/20 8:58 PM, Eric Biggers wrote:
> This series adds a function sha256() to the sha256 library so that users
> who want to compute a hash in one step can just call sha256() instead of
> sha256_init() + sha256_update() + sha256_final().
> =

> Patches 2-4 then convert some users to use it.
> =

> Eric Biggers (4):
>    crypto: lib/sha256 - add sha256() function
>    efi: use sha256() instead of open coding
>    mptcp: use sha256() instead of open coding
>    ASoC: cros_ec_codec: use sha256() instead of open coding
> =

>   drivers/firmware/efi/embedded-firmware.c |  9 +++-----
>   include/crypto/sha.h                     |  1 +
>   lib/crypto/sha256.c                      | 10 +++++++++
>   net/mptcp/crypto.c                       | 15 +++----------
>   sound/soc/codecs/cros_ec_codec.c         | 27 ++----------------------
>   5 files changed, 19 insertions(+), 43 deletions(-)
> =

> =

> base-commit: 57c8aa43b9f272c382c253573c82be5cb68fe22d

I've done some quick tests on this series to make sure that
the efi embedded-firmware support did not regress.
That still works fine, so this series is;

Tested-by: Hans de Goede <hdegoede(a)redhat.com>

Regards,

Hans

--===============3119082816403254337==--
