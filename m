Content-Type: multipart/mixed; boundary="===============4847366183705270734=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: select CRYPTO
Date: Sun, 16 Feb 2020 19:37:32 -0800
Message-ID: <20200216.193732.474649064358030475.davem@davemloft.net>
In-Reply-To: 20200215144556.956173-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3666

--===============4847366183705270734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Date: Sat, 15 Feb 2020 15:45:56 +0100

> Without this modification and if CRYPTO is not selected, we have this
> warning:
> =

>   WARNING: unmet direct dependencies detected for CRYPTO_LIB_SHA256
>     Depends on [n]: CRYPTO [=3Dn]
>     Selected by [y]:
>     - MPTCP [=3Dy] && NET [=3Dy] && INET [=3Dy]
> =

> MPTCP selects CRYPTO_LIB_SHA256 which seems to depend on CRYPTO. CRYPTO
> is now selected to avoid this issue.
> =

> Even though the config system prints that warning, it looks like
> sha256.c is compiled and linked even without CONFIG_CRYPTO. Since MPTCP
> will end up needing CONFIG_CRYPTO anyway in future commits -- currently
> in preparation for net-next -- we propose to add it now to fix the
> warning.
> =

> The dependency in the config system comes from the fact that
> CRYPTO_LIB_SHA256 is defined in "lib/crypto/Kconfig" which is sourced
> from "crypto/Kconfig" only if CRYPTO is selected.
> =

> Fixes: 65492c5a6ab5 (mptcp: move from sha1 (v0) to sha256 (v1))
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Applied.
--===============4847366183705270734==--
