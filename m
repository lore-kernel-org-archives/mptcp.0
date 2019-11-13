Content-Type: multipart/mixed; boundary="===============5310284816047381266=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 3/4] mptcp: warn once if exceeding tcp opt space
 for dss/mp_capable
Date: Wed, 13 Nov 2019 17:35:31 +0100
Message-ID: <50b21bc2-1d6f-0c3e-5fed-a2cf4997a727@tessares.net>
In-Reply-To: 30fb471931a483bec09036b21b83c91ef0afb135.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2511

--===============5310284816047381266==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 13/11/2019 17:18, Paolo Abeni wrote:
> On Wed, 2019-11-13 at 16:48 +0100, Matthieu Baerts wrote:
>> <On 12/11/2019 09:21, Paolo Abeni wrote:
>>> AFAICS DSS, MP_CAPABLE and MP_JOIN are mutually esclusive, and the
>>> bigger is DSS with 64 bytes ack/seq and csum with a total of 28 bytes -
>>> which fit the TCP option space.
>>>
>>> Additional MPTCP options (ADD/DEL_ADDR/PRIO/FAIL/FASTCLOSE/...) can
>>> indeed run out of space, but that failure is not fatal (do not break
>>> the connection nor causes fallback) and is handled gracefully - no
>>> WARN, just omit the option. Additionally we could increment some MIB
>>> counter.
>>
>> When you say that the option is omitted, do you mean that the option is
>> sent in the new (dedicated?) ACK packet or dropped/never sent? :)
> =

> With the current code, prior to this series, the ADD/DEL_ADDR option
> exceeding the TCP option space is dropped/never sent. This series do
> not change such behavior.

Indeed, it was already the case. Thank you for your quick reply!

Should we already add the MIB counter? And/or add a TODO in the code?

We are not there yet but missing an ADD_ADDR can have bad consequences. =

And it would be unexpected for the userspace to drop it, especially with =

MPTCPv1 which should make it reliable :)

> Inserting a (duplicate) ack to try to fit such option looks doable, but
> also out-of-scope for this change.

Agreed. We should add this in a TODO list of "things for later" :) (or a =

TODO in the code?)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5310284816047381266==--
