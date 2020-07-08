Content-Type: multipart/mixed; boundary="===============0988698785533396895=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 3/4] mptcp: use sha256() instead of open coding
Date: Wed, 08 Jul 2020 13:22:35 +0200
Message-ID: <b69102bb-47a0-567b-0e02-b572a9b1bbbf@tessares.net>
In-Reply-To: 20200707185818.80177-4-ebiggers@kernel.org
X-Status: 
X-Keywords:                  
X-UID: 4947

--===============0988698785533396895==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On 07/07/2020 20:58, Eric Biggers wrote:
> From: Eric Biggers <ebiggers(a)google.com>
> =

> Now that there's a function that calculates the SHA-256 digest of a
> buffer in one step, use it instead of sha256_init() + sha256_update() +
> sha256_final().
> =

> Cc: mptcp(a)lists.01.org
> Cc: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> Cc: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Signed-off-by: Eric Biggers <ebiggers(a)google.com>

Thank you for this simplification and update MPTCP code, it's clearer!

Acked-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0988698785533396895==--
