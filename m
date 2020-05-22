Content-Type: multipart/mixed; boundary="===============8936002704799887469=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: use untruncated hash in ADD_ADDR HMAC
Date: Fri, 22 May 2020 14:22:11 -0700
Message-ID: <20200522.142211.889204416624218899.davem@davemloft.net>
In-Reply-To: 20200522021049.361606-1-todd.malsbary@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4461

--===============8936002704799887469==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Todd Malsbary <todd.malsbary(a)linux.intel.com>
Date: Thu, 21 May 2020 19:10:49 -0700

> There is some ambiguity in the RFC as to whether the ADD_ADDR HMAC is
> the rightmost 64 bits of the entire hash or of the leftmost 160 bits
> of the hash.  The intention, as clarified with the author of the RFC,
> is the entire hash.
> =

> This change returns the entire hash from
> mptcp_crypto_hmac_sha (instead of only the first 160 bits), and moves
> any truncation/selection operation on the hash to the caller.
> =

> Fixes: 12555a2d97e5 ("mptcp: use rightmost 64 bits in ADD_ADDR HMAC")
> Reviewed-by: Christoph Paasch <cpaasch(a)apple.com>
> Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> Signed-off-by: Todd Malsbary <todd.malsbary(a)linux.intel.com>

Applied, thank you.
--===============8936002704799887469==--
