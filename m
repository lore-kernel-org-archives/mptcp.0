Content-Type: multipart/mixed; boundary="===============2391377755553774968=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 3/4] mptcp: warn once if exceeding tcp opt space
 for dss/mp_capable
Date: Wed, 13 Nov 2019 15:43:50 -0800
Message-ID: <18306f745c356048335f1196515db0d6ea28022e.camel@linux.intel.com>
In-Reply-To: 728e24cae8748a2a2f2622cff018446650f88150.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2522

--===============2391377755553774968==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-11-12 at 09:21 +0100, Paolo Abeni wrote:
> On Mon, 2019-11-11 at 13:50 -0800, Peter Krystad wrote:
> > Hi Paolo -
> > =

> > On Mon, 2019-11-11 at 17:53 +0100, Paolo Abeni wrote:
> > > since such option will always fit the tcp header, module bugs.
> > =

> > "modulo"
> =

> thnx! Hopefully comment should be dropped when squashing ;)
> =

> > How is it guaranteed that it will always fit, now and in the future?
> =

> TCP option space must accomodate tstamp (12 bytes) and MPTCP options.
> =

> AFAICS DSS, MP_CAPABLE and MP_JOIN are mutually esclusive, and the
> bigger is DSS with 64 bytes ack/seq and csum with a total of 28 bytes -
> which fit the TCP option space.

Just FYI, I should have mentioned this earlier, I have observed the mptcp.o=
rg
kernel sending 32-bit DSS ack-only in the same header as final MP_CAPABLE A=
CK
so this statement isn't completely true.

Peter.
 =

> =

> Additional MPTCP options (ADD/DEL_ADDR/PRIO/FAIL/FASTCLOSE/...) can
> indeed run out of space, but that failure is not fatal (do not break
> the connection nor causes fallback) and is handled gracefully - no
> WARN, just omit the option. Additionally we could increment some MIB
> counter.
> =

> Thanks,
> =

> Paolo
>=20

--===============2391377755553774968==--
