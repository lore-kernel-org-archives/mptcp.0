Content-Type: multipart/mixed; boundary="===============6624801196210734828=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: RFCv2 for netdev: what's missing?
Date: Thu, 03 Oct 2019 21:21:58 +0200
Message-ID: <20191003192158.GE13866@breakpoint.cc>
In-Reply-To: 01b35a0bb501816a157e9c6681d2ee59d86278af.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2012

--===============6624801196210734828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> I think that:
> =

>        tcp: clean ext on tx recycle
> =

> does have some minimal mptcp dependencies that can't be removed without
> making such patch a no-op, so perhaps we should also include some very
> minimal MPTCP stub definitions:

Why?  It doesn't have any MPTCP dep.  Just zap all the extension space
and netfilter conntrack entry.

AFAICS things might already go wrong in case we get recycle skb that
has an ipsec secpath assigned, or am I missing something?

And unless there is something in place that removes skb->nfct before
the skb is placed on the socket cache, rmmod nf_conntrack can block
forever as such queued skb holds a reference on conntrack struct.

> I *think* we can also do a bolder step and send this next iteration as
> _NOT_ RFC, aiming at inclusion. My [mis]understanding is that we
> should post later chunks after the first one is merged, easily.

Hmm, we can try but I am not sure upstream would accept exposure of
some tcp core functions without a in-tree user.
--===============6624801196210734828==--
