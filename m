Content-Type: multipart/mixed; boundary="===============1674446534007602321=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v3 07/11] tcp: Prevent coalesce/collapse
 when skb has MPTCP extensions
Date: Wed, 18 Dec 2019 23:15:46 +0100
Message-ID: <5e6ae66a8adea061388919fe0ce5b766feab4c31.camel@redhat.com>
In-Reply-To: 20191218.124510.1971632024371398726.davem@davemloft.net
X-Status: 
X-Keywords:                  
X-UID: 3166

--===============1674446534007602321==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-12-18 at 12:45 -0800, David Miller wrote:
> From: Eric Dumazet <eric.dumazet(a)gmail.com>
> Date: Wed, 18 Dec 2019 11:50:24 -0800
> =

> > On 12/17/19 12:38 PM, Mat Martineau wrote:
> >> The MPTCP extension data needs to be preserved as it passes through the
> >> TCP stack. Make sure that these skbs are not appended to others during
> >> coalesce or collapse, so the data remains associated with the payload =
of
> >> the given skb.
> > =

> > This seems a very pessimistic change to me.
> > =

> > Are you planing later to refine this limitation ?
> > =

> > Surely if a sender sends TSO packet, we allow all the segments
> > being aggregated at receive side either by GRO or TCP coalescing.
> =

> This turns off absolutely crucial functional elements of our TCP
> stack, and will avoid all of the machinery that avoids wastage in TCP
> packets sitting in the various queues.  skb->truesize management, etc.

Thank you for the feedback!

Just to clarify, with the code we have currently posted TSO trains of
MPTCP packets can be aggregated by the GRO engine almost exactly as
currently happens for plain TCP packets.

We still have chances to aggregate packets belonging to a MPTCP stream,
as not all of them carry a DSS option.

We opted to not coalesce at the TCP level for the moment to avoid
adding additional hook code inside the coalescing code.

If you are ok without such hooks in the initial version, we can handle
MPTCP coalescing, too. The real work will likely land in part 2.

Would that fit you?

Thanks,

Paolo

--===============1674446534007602321==--
