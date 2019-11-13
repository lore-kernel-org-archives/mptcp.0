Content-Type: multipart/mixed; boundary="===============5130164406864231268=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 3/4] mptcp: warn once if exceeding tcp opt space
 for dss/mp_capable
Date: Wed, 13 Nov 2019 16:48:11 +0100
Message-ID: <7db67f6d-1323-38e6-ba79-73bef7db8eb4@tessares.net>
In-Reply-To: 728e24cae8748a2a2f2622cff018446650f88150.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2509

--===============5130164406864231268==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 12/11/2019 09:21, Paolo Abeni wrote:
> On Mon, 2019-11-11 at 13:50 -0800, Peter Krystad wrote:
>> Hi Paolo -
>>
>> On Mon, 2019-11-11 at 17:53 +0100, Paolo Abeni wrote:
>>> since such option will always fit the tcp header, module bugs.
>>
>> "modulo"
> =

> thnx! Hopefully comment should be dropped when squashing ;)
> =

>> How is it guaranteed that it will always fit, now and in the future?
> =

> TCP option space must accomodate tstamp (12 bytes) and MPTCP options.
> =

> AFAICS DSS, MP_CAPABLE and MP_JOIN are mutually esclusive, and the
> bigger is DSS with 64 bytes ack/seq and csum with a total of 28 bytes -
> which fit the TCP option space.
> =

> Additional MPTCP options (ADD/DEL_ADDR/PRIO/FAIL/FASTCLOSE/...) can
> indeed run out of space, but that failure is not fatal (do not break
> the connection nor causes fallback) and is handled gracefully - no
> WARN, just omit the option. Additionally we could increment some MIB
> counter.

When you say that the option is omitted, do you mean that the option is =

sent in the new (dedicated?) ACK packet or dropped/never sent? :)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5130164406864231268==--
