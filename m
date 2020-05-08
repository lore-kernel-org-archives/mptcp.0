Content-Type: multipart/mixed; boundary="===============3874554768087363249=="
MIME-Version: 1.0
From: Herbert Xu <herbert at gondor.apana.org.au>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/7] sha1 library cleanup
Date: Fri, 08 May 2020 16:07:59 +1000
Message-ID: <20200508060759.GA24982@gondor.apana.org.au>
In-Reply-To: 20200502182427.104383-1-ebiggers@kernel.org
X-Status: 
X-Keywords:                  
X-UID: 4350

--===============3874554768087363249==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Eric Biggers <ebiggers(a)kernel.org> wrote:
> <linux/cryptohash.h> sounds very generic and important, like it's the
> header to include if you're doing cryptographic hashing in the kernel.
> But actually it only includes the library implementation of the SHA-1
> compression function (not even the full SHA-1).  This should basically
> never be used anymore; SHA-1 is no longer considered secure, and there
> are much better ways to do cryptographic hashing in the kernel.
> =

> Also the function is named just "sha_transform()", which makes it
> unclear which version of SHA is meant.
> =

> Therefore, this series cleans things up by moving these SHA-1
> declarations into <crypto/sha.h> where they better belong, and changing
> the names to say SHA-1 rather than just SHA.
> =

> As future work, we should split sha.h into sha1.h and sha2.h and try to
> remove the remaining uses of SHA-1.  For example, the remaining use in
> drivers/char/random.c is probably one that can be gotten rid of.
> =

> This patch series applies to cryptodev/master.
> =

> Eric Biggers (7):
>  mptcp: use SHA256_BLOCK_SIZE, not SHA_MESSAGE_BYTES
>  crypto: powerpc/sha1 - remove unused temporary workspace
>  crypto: powerpc/sha1 - prefix the "sha1_" functions
>  crypto: s390/sha1 - prefix the "sha1_" functions
>  crypto: lib/sha1 - rename "sha" to "sha1"
>  crypto: lib/sha1 - remove unnecessary includes of linux/cryptohash.h
>  crypto: lib/sha1 - fold linux/cryptohash.h into crypto/sha.h
> =

> Documentation/security/siphash.rst          |  2 +-
> arch/arm/crypto/sha1_glue.c                 |  1 -
> arch/arm/crypto/sha1_neon_glue.c            |  1 -
> arch/arm/crypto/sha256_glue.c               |  1 -
> arch/arm/crypto/sha256_neon_glue.c          |  1 -
> arch/arm/kernel/armksyms.c                  |  1 -
> arch/arm64/crypto/sha256-glue.c             |  1 -
> arch/arm64/crypto/sha512-glue.c             |  1 -
> arch/microblaze/kernel/microblaze_ksyms.c   |  1 -
> arch/mips/cavium-octeon/crypto/octeon-md5.c |  1 -
> arch/powerpc/crypto/md5-glue.c              |  1 -
> arch/powerpc/crypto/sha1-spe-glue.c         |  1 -
> arch/powerpc/crypto/sha1.c                  | 33 ++++++++++-----------
> arch/powerpc/crypto/sha256-spe-glue.c       |  1 -
> arch/s390/crypto/sha1_s390.c                | 12 ++++----
> arch/sparc/crypto/md5_glue.c                |  1 -
> arch/sparc/crypto/sha1_glue.c               |  1 -
> arch/sparc/crypto/sha256_glue.c             |  1 -
> arch/sparc/crypto/sha512_glue.c             |  1 -
> arch/unicore32/kernel/ksyms.c               |  1 -
> arch/x86/crypto/sha1_ssse3_glue.c           |  1 -
> arch/x86/crypto/sha256_ssse3_glue.c         |  1 -
> arch/x86/crypto/sha512_ssse3_glue.c         |  1 -
> crypto/sha1_generic.c                       |  5 ++--
> drivers/char/random.c                       |  8 ++---
> drivers/crypto/atmel-sha.c                  |  1 -
> drivers/crypto/chelsio/chcr_algo.c          |  1 -
> drivers/crypto/chelsio/chcr_ipsec.c         |  1 -
> drivers/crypto/omap-sham.c                  |  1 -
> fs/f2fs/hash.c                              |  1 -
> include/crypto/sha.h                        | 10 +++++++
> include/linux/cryptohash.h                  | 14 ---------
> include/linux/filter.h                      |  4 +--
> include/net/tcp.h                           |  1 -
> kernel/bpf/core.c                           | 18 +++++------
> lib/crypto/chacha.c                         |  1 -
> lib/sha1.c                                  | 24 ++++++++-------
> net/core/secure_seq.c                       |  1 -
> net/ipv6/addrconf.c                         | 10 +++----
> net/ipv6/seg6_hmac.c                        |  1 -
> net/mptcp/crypto.c                          |  4 +--
> 41 files changed, 69 insertions(+), 104 deletions(-)
> delete mode 100644 include/linux/cryptohash.h
> =

> =

> base-commit: 12b3cf9093542d9f752a4968815ece836159013f

All applied.  Thanks.
-- =

Email: Herbert Xu <herbert(a)gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--===============3874554768087363249==--
