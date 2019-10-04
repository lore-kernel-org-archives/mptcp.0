Content-Type: multipart/mixed; boundary="===============8482255400174138357=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: RFCv2 for netdev: what's missing?
Date: Fri, 04 Oct 2019 13:25:34 +0200
Message-ID: <4d1890a8-fd21-f9a1-f4e8-0ee9234831ed@tessares.net>
In-Reply-To: 20191003192158.GE13866@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 2015

--===============8482255400174138357==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 03/10/2019 21:21, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
>> I think that:
>>
>>        tcp: clean ext on tx recycle
>>
>> does have some minimal mptcp dependencies that can't be removed without
>> making such patch a no-op, so perhaps we should also include some very
>> minimal MPTCP stub definitions:
> =

> Why?  It doesn't have any MPTCP dep.  Just zap all the extension space
> and netfilter conntrack entry.
> =

> AFAICS things might already go wrong in case we get recycle skb that
> has an ipsec secpath assigned, or am I missing something?
> =

> And unless there is something in place that removes skb->nfct before
> the skb is placed on the socket cache, rmmod nf_conntrack can block
> forever as such queued skb holds a reference on conntrack struct.
> =

>> I *think* we can also do a bolder step and send this next iteration as
>> _NOT_ RFC, aiming at inclusion. My [mis]understanding is that we
>> should post later chunks after the first one is merged, easily.
> =

> Hmm, we can try but I am not sure upstream would accept exposure of
> some tcp core functions without a in-tree user.

We discussed a bit about these two topics at yesterday's meeting. May
you have a look at the minutes I sent this morning please? I guess the
list we established yesterday can be reduced, right?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8482255400174138357==--
