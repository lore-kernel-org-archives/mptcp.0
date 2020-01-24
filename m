Content-Type: multipart/mixed; boundary="===============1467911152962076654=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v3 00/19] Multipath TCP part 2: Single
 subflow & RFC8684 support
Date: Fri, 24 Jan 2020 15:24:25 +0100
Message-ID: <20200124.152425.1414135523887609628.davem@davemloft.net>
In-Reply-To: 20200122005633.21229-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 3495

--===============1467911152962076654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Christoph Paasch <cpaasch(a)apple.com>
Date: Tue, 21 Jan 2020 16:56:14 -0800

> v2 -> v3: Added RFC8684-style handshake (see below fore more details) and=
 some minor fixes
> v1 -> v2: Rebased on latest "Multipath TCP: Prerequisites" v3 series
> =

> This set adds MPTCP connection establishment, writing & reading MPTCP
> options on data packets, a sysctl to allow MPTCP per-namespace, and self
> tests. This is sufficient to establish and maintain a connection with a
> MPTCP peer, but will not yet allow or initiate establishment of
> additional MPTCP subflows.
> =

> We also add the necessary code for the RFC8684-style handshake.
> RFC8684 obsoletes the experimental RFC6824 and makes MPTCP move-on to
> version 1.
 ...

Honestly I don't see anything super objectionable here.

And if there is, it can be easily fixed up with follow-on patches.

Series applied, thanks!
--===============1467911152962076654==--
