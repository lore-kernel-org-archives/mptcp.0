Content-Type: multipart/mixed; boundary="===============1565228097587564268=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/7] mptcp: use SHA256_BLOCK_SIZE,
 not SHA_MESSAGE_BYTES
Date: Sat, 02 May 2020 20:56:37 +0200
Message-ID: <22ea2039-18f3-12f0-cdc3-99b49c413f77@tessares.net>
In-Reply-To: 20200502182427.104383-2-ebiggers@kernel.org
X-Status: 
X-Keywords:                  
X-UID: 4300

--===============1565228097587564268==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On 02/05/2020 20:24, Eric Biggers wrote:
> From: Eric Biggers <ebiggers(a)google.com>
> =

> In preparation for naming the SHA-1 stuff in <linux/cryptohash.h>
> properly and moving it to a more appropriate header, fix the HMAC-SHA256
> code in mptcp_crypto_hmac_sha() to use SHA256_BLOCK_SIZE instead of
> "SHA_MESSAGE_BYTES" which is actually the SHA-1 block size.
> (Fortunately these are both 64 bytes, so this wasn't a "real" bug...)

Good catch! I guess it was left when switching from SHA-1 to SHA-256 in =

65492c5a6ab5 (mptcp: move from sha1 (v0) to sha256 (v1)).

For MPTCP related code, it looks good to me, thank you for this!

Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============1565228097587564268==--
