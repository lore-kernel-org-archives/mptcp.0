Content-Type: multipart/mixed; boundary="===============6304001648104068115=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 03/12] mptcp: Use correct tcp_queue when calling
 mptcp_fragment
Date: Sun, 08 Apr 2018 21:04:52 -0700
Message-ID: <20180409040452.GQ16289@MacBook-Pro-6.local>
In-Reply-To: bdfbbb60-356a-1e56-8452-bc75ef3c1903@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 518

--===============6304001648104068115==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 04/04/18 - 17:55:27, Matthieu Baerts wrote:
> Hi Christoph,
> =

> On 26/03/2018 09:32, Christoph Paasch wrote:
> > The skb may come from the write-queue, the rtx-queue or the reinject
> > queue.
> =

> Good catch! :)
> =

> Should we not clearly document that in mptcp_fragment() code? I mean the =
skb
> may come from the write-queue, the rtx-queue or the reinject-queue but a
> reinjection is not a retransmission on the same sk, it should then go in =
the
> write-queue. This is quite tricky and specific to MPTCP, we need to have
> that in mind when looking at this code.

sounds good! I will add a comment at the top of the function.


Christoph

> =

> I guess it is not easy to debug when this kind of fragments are in the wr=
ong
> queue. :)
> =

> Best regards,
> Matt
> =

> > When it comes from the rtx-queue, we need to give mptcp_fragment the
> > right tcp_queue.
> > =

> > To handle the case when it comes from the reinject-queue, I will post a
> > follow-up patch as this seems to be a bug in the stable release as well.
> > =

> > Fixes: 8a1051d977cf ("Merge tag 'v4.15' into mptcp_trunk")
> > Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> > ---
> >   net/mptcp/mptcp_output.c | 12 +++++++++---
> >   1 file changed, 9 insertions(+), 3 deletions(-)
> > =

> > diff --git a/net/mptcp/mptcp_output.c b/net/mptcp/mptcp_output.c
> > index 43a21f66ac34..fc950a98ce31 100644
> > --- a/net/mptcp/mptcp_output.c
> > +++ b/net/mptcp/mptcp_output.c
> > @@ -607,7 +607,10 @@ static int mptcp_fragment(struct sock *meta_sk, en=
um tcp_queue tcp_queue,
> >   	if (ret)
> >   		return ret;
> > -	buff =3D skb->next;
> > +	if (tcp_queue =3D=3D TCP_FRAG_IN_WRITE_QUEUE)
> > +		buff =3D skb->next;
> > +	else
> > +		buff =3D skb_rb_next(skb);
> >   	flags =3D TCP_SKB_CB(skb)->mptcp_flags;
> >   	TCP_SKB_CB(skb)->mptcp_flags =3D flags & ~(MPTCPHDR_FIN);
> > @@ -740,6 +743,7 @@ bool mptcp_write_xmit(struct sock *meta_sk, unsigne=
d int mss_now, int nonagle,
> >   	while ((skb =3D mpcb->sched_ops->next_segment(meta_sk, &reinject, &s=
ubsk,
> >   						    &sublimit))) {
> > +		enum tcp_queue tcp_queue =3D TCP_FRAG_IN_WRITE_QUEUE;
> >   		unsigned int limit;
> >   		WARN(TCP_SKB_CB(skb)->sacked, "sacked: %u reinject: %u",
> > @@ -755,6 +759,8 @@ bool mptcp_write_xmit(struct sock *meta_sk, unsigne=
d int mss_now, int nonagle,
> >   				__kfree_skb(skb);
> >   				continue;
> >   			}
> > +		} else if (reinject =3D=3D -1) {
> > +			tcp_queue =3D TCP_FRAG_IN_RTX_QUEUE;
> >   		}
> >   		/* If the segment was cloned (e.g. a meta retransmission),
> > @@ -817,7 +823,7 @@ bool mptcp_write_xmit(struct sock *meta_sk, unsigne=
d int mss_now, int nonagle,
> >   			limit =3D min(limit, sublimit);
> >   		if (skb->len > limit &&
> > -		    unlikely(mptcp_fragment(meta_sk, TCP_FRAG_IN_WRITE_QUEUE,
> > +		    unlikely(mptcp_fragment(meta_sk, tcp_queue,
> >   					    skb, limit, gfp, reinject)))
> >   			break;
> > @@ -1545,7 +1551,7 @@ int mptcp_retransmit_skb(struct sock *meta_sk, st=
ruct sk_buff *skb)
> >   					    TCP_NAGLE_OFF);
> >   	if (skb->len > limit &&
> > -	    unlikely(mptcp_fragment(meta_sk, TCP_FRAG_IN_WRITE_QUEUE, skb,
> > +	    unlikely(mptcp_fragment(meta_sk, TCP_FRAG_IN_RTX_QUEUE, skb,
> >   				    limit, GFP_ATOMIC, 0)))
> >   		goto failed;
> > =

> =

> -- =

> Matthieu Baerts | R&D Engineer
> matthieu.baerts(a)tessares.net
> Tessares SA | Hybrid Access Solutions
> www.tessares.net
> 1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
> =

> -- =

> =

> =

> DISCLAIMER.
> This email and any files transmitted with it are confidential and intended
> solely for the use of the individual or entity to whom they are addressed.
> If you have received this email in error please notify the system manager.
> This message contains confidential information and is intended only for t=
he
> individual named. If you are not the named addressee you should not
> disseminate, distribute or copy this e-mail. Please notify the sender
> immediately by e-mail if you have received this e-mail by mistake and del=
ete
> this e-mail from your system. If you are not the intended recipient you a=
re
> notified that disclosing, copying, distributing or taking any action in
> reliance on the contents of this information is strictly prohibited.

--===============6304001648104068115==--
