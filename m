Content-Type: multipart/mixed; boundary="===============3768020509458288639=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 3/4] mptcp: warn once if exceeding tcp opt space
 for dss/mp_capable
Date: Wed, 13 Nov 2019 17:18:48 +0100
Message-ID: <30fb471931a483bec09036b21b83c91ef0afb135.camel@redhat.com>
In-Reply-To: 7db67f6d-1323-38e6-ba79-73bef7db8eb4@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2510

--===============3768020509458288639==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-11-13 at 16:48 +0100, Matthieu Baerts wrote:
> <On 12/11/2019 09:21, Paolo Abeni wrote:
> > AFAICS DSS, MP_CAPABLE and MP_JOIN are mutually esclusive, and the
> > bigger is DSS with 64 bytes ack/seq and csum with a total of 28 bytes -
> > which fit the TCP option space.
> > =

> > Additional MPTCP options (ADD/DEL_ADDR/PRIO/FAIL/FASTCLOSE/...) can
> > indeed run out of space, but that failure is not fatal (do not break
> > the connection nor causes fallback) and is handled gracefully - no
> > WARN, just omit the option. Additionally we could increment some MIB
> > counter.
> =

> When you say that the option is omitted, do you mean that the option is =

> sent in the new (dedicated?) ACK packet or dropped/never sent? :)

With the current code, prior to this series, the ADD/DEL_ADDR option
exceeding the TCP option space is dropped/never sent. This series do
not change such behavior.

Inserting a (duplicate) ack to try to fit such option looks doable, but
also out-of-scope for this change. =


Cheers,

Paolo

--===============3768020509458288639==--
