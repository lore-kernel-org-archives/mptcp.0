Content-Type: multipart/mixed; boundary="===============6281419039571839566=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v7 00/11] Multipath TCP: Prerequisites
Date: Thu, 09 Jan 2020 18:44:01 -0800
Message-ID: <20200109.184401.74056974361053845.davem@davemloft.net>
In-Reply-To: 20200109155924.30122-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3341

--===============6281419039571839566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Date: Thu,  9 Jan 2020 07:59:13 -0800

 ...
> The MPTCP upstreaming community has been collaborating on an
> upstreamable MPTCP implementation that complies with RFC 8684. A minimal
> set of features to comply with the specification involves a sizeable set
> of code changes, so David requested that we split this work in to
> multiple, smaller patch sets to build up MPTCP infrastructure.
> =

> The minimal MPTCP feature set we are proposing for review in the v5.6
> timeframe begins with these three parts:
> =

> Part 1 (this patch set): MPTCP prerequisites. Introduce some MPTCP
> definitions, additional ULP and skb extension features, TCP option space
> checking, and a few exported symbols.
> =

> Part 2: Single subflow implementation and self tests.
> =

> Part 3: Switch from MPTCP v0 (RFC 6824) to MPTCP v1 (new RFC 8684,
> publication expected in the next few days).
> =

> Additional patches for multiple subflow support, path management, active
> backup, and other features are in the pipeline for submission after
> making progress with the above reviews.
 ...

Series applied to net-next.
--===============6281419039571839566==--
