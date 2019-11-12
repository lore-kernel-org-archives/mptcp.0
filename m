Content-Type: multipart/mixed; boundary="===============3107311490073663770=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 3/4] mptcp: warn once if exceeding tcp opt space
 for dss/mp_capable
Date: Tue, 12 Nov 2019 09:21:19 +0100
Message-ID: <728e24cae8748a2a2f2622cff018446650f88150.camel@redhat.com>
In-Reply-To: 93158d7788e55c71ff95b741257923df9518772e.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2480

--===============3107311490073663770==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-11-11 at 13:50 -0800, Peter Krystad wrote:
> Hi Paolo -
> =

> On Mon, 2019-11-11 at 17:53 +0100, Paolo Abeni wrote:
> > since such option will always fit the tcp header, module bugs.
> =

> "modulo"

thnx! Hopefully comment should be dropped when squashing ;)

> How is it guaranteed that it will always fit, now and in the future?

TCP option space must accomodate tstamp (12 bytes) and MPTCP options.

AFAICS DSS, MP_CAPABLE and MP_JOIN are mutually esclusive, and the
bigger is DSS with 64 bytes ack/seq and csum with a total of 28 bytes -
which fit the TCP option space.

Additional MPTCP options (ADD/DEL_ADDR/PRIO/FAIL/FASTCLOSE/...) can
indeed run out of space, but that failure is not fatal (do not break
the connection nor causes fallback) and is handled gracefully - no
WARN, just omit the option. Additionally we could increment some MIB
counter.

Thanks,

Paolo

--===============3107311490073663770==--
