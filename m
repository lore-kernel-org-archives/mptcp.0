Content-Type: multipart/mixed; boundary="===============5264280340155879757=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: add missing memory scheduling in the
 rx path
Date: Fri, 23 Oct 2020 10:40:43 +0200
Message-ID: <906f4968f6c5bc102809e425e32b859e2f2fa715.camel@redhat.com>
In-Reply-To: af3eea79-834-6ece-1546-5e6e7ad598b6@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6418

--===============5264280340155879757==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-10-22 at 16:48 -0700, Mat Martineau wrote:
> On Tue, 20 Oct 2020, Paolo Abeni wrote:
> =

> > When moving the skbs from the subflow into the msk receive
> > queue, we must schedule there the required amount of memory.
> > =

> > Try to borrow the required memory from the subflow, if needed,
> > so that we leverage the existing TCP heuristic.
> > =

> > Fixes: 6771bfd9ee24 ("mptcp: update mptcp ack sequence from work queue")
> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > ---
> > @Florian: this is somewhat relates to the RFC patch
> > "mptcp: add ooo prune support". I think we could try to prune the
> > subflow via tcp_prune_queue()/tcp_prune_ofo_queue() when the msk is
> > under memory pressure, so that we don't need to drop data already
> > acked at the TCP level.
> =

> I was hoping to hear from Florian on this one, since he's more experience=
d =

> with socket memory accounting.
> =

> > ---
> > net/mptcp/protocol.c | 10 ++++++++++
> > 1 file changed, 10 insertions(+)
> > =

> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 1f0c5ad44eef..ebb43b2c1b34 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -286,6 +286,15 @@ static bool __mptcp_move_skb(struct mptcp_sock *ms=
k, struct sock *ssk,
> > 	skb_ext_reset(skb);
> > 	skb_orphan(skb);
> > =

> > +	/* try to fetch required memory from subflow */
> > +	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
> > +		if (ssk->sk_forward_alloc < skb->truesize)
> > +			goto drop;
> > +		__sk_mem_reclaim(ssk, skb->truesize);
> =

> It's not obvious to me why this reclaim is needed only when =

> sk_rmem_schedule() returns false - it seems odd to sometimes proceed with =

> the ssk memory adjusted, and to sometimes not adjust it. Is this handled =

> automatically somewhere else?

Usually the forward allocated memory is not reclaimed, so that it could
be used for the next packet[s]. That reduces drammatically the number
of call into cgroup mem accounting and is a relevant TCP optimization.
Memory is reclaimed (partially) only when strictly needed/under memory
pressure as in the above case.

See e.g. the sk_mem_reclaim() calls in  tcp_prune_ofo_queue() and/or
tcp_prune_queue().

Thanks,

Paolo

--===============5264280340155879757==--
