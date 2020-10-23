Content-Type: multipart/mixed; boundary="===============6055286493129362548=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v3] mptcp: track window announced to
 peer
Date: Fri, 23 Oct 2020 10:33:48 +0200
Message-ID: <585a027b0f4ea6a56c44b4050b76c8d3c0442083.camel@redhat.com>
In-Reply-To: de5a7226-d51-8d81-4032-17f75bb11d51@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6417

--===============6055286493129362548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-10-22 at 17:43 -0700, Mat Martineau wrote:
> On Thu, 22 Oct 2020, Florian Westphal wrote:
> @@ -1348,7 +1349,6 @@ static int __tcp_transmit_skb(struct sock *sk, stru=
ct sk_buff *skb,
> > 		}
> > 	}
> > =

> > -	tcp_options_write((__be32 *)(th + 1), tp, &opts);
> > 	skb_shinfo(skb)->gso_type =3D sk->sk_gso_type;
> > 	if (likely(!(tcb->tcp_flags & TCPHDR_SYN))) {
> > 		th->window      =3D htons(tcp_select_window(sk));
> =

> These lines of code between the old tcp_options_write() location and the =

> new location were last touched by Eric, doing some cache miss =

> optimizations. It doesn't seem like populating the TCP options just after =

> th->window instead of just before should behave similarly with the data =

> cache - are you concerned about this at all?

Thank you for the carefully review!

commit 51466a7545b73b7ad7bcfb33410d2823ccfaa501
Author: Eric Dumazet <edumazet(a)google.com>
Date:   Thu Jun 11 09:15:16 2015 -0700

    tcp: fill shinfo->gso_type at last moment

moves 'skb_shinfo(skb)->gso_type' initialization just after the option
write. Looking at the commit message, what actually makes a difference
in such commit is moving the mentioned assigment after the last xmit
check to avoid touching extra cache lines if not needed - and we
preserve that fact.

I think the above is sane performace-wise, but I guess Eric could still
teach me better ;)

> =

> > @@ -1359,6 +1359,9 @@ static int __tcp_transmit_skb(struct sock *sk, st=
ruct sk_buff *skb,
> > 		 */
> > 		th->window	=3D htons(min(tp->rcv_wnd, 65535U));
> > 	}
> > +
> > +	tcp_options_write((__be32 *)(th + 1), tp, &opts);
> > +
> > #ifdef CONFIG_TCP_MD5SIG
> > 	/* Calculate the MD5 hash, as we have all we need now */
> > 	if (md5) {
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index f2d1e27a2bc1..2e9f1c4ea008 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -991,7 +991,24 @@ void mptcp_incoming_options(struct sock *sk, struc=
t sk_buff *skb)
> > 	}
> > }
> > =

> > -void mptcp_write_options(__be32 *ptr, struct mptcp_out_options *opts)
> > +static void mptcp_set_rwin(const struct tcp_sock *tp)
> > +{
> > +	const struct sock *ssk =3D (const struct sock *)tp;
> > +	const struct mptcp_subflow_context *subflow;
> > +	struct mptcp_sock *msk;
> > +	u64 ack_seq;
> > +
> > +	subflow =3D mptcp_subflow_ctx(ssk);
> > +	msk =3D mptcp_sk(subflow->conn);
> > +
> > +	ack_seq =3D READ_ONCE(msk->ack_seq) + tp->rcv_wnd;
> > +
> > +	if (after64(ack_seq, READ_ONCE(msk->rcv_wnd_sent)))
> > +		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
> =

> This looks racy if packet headers on multiple subflows are created =

> concurrently: msk->rcv_wnd_sent could end up with an earlier sequence =

> number than it should have, leading to possible extra drops. It looks lik=
e =

> a hard race to trigger, but do you think rcv_wnd_sent should use cmpxchg =

> like wnd_end and snd_una?

I personally don't have a strong opinion on this, I guess we can live
with the potential race, we have MIBs reporting both MPTCP
retransmissions and OOW events, which would be both triggered if this
race happens and have any conseguence.

Possibly related: as some point we will probabaly need to consolidate
the cmpxchg()s with some other locking mechanims to reduce the atomic
operations needed.

Cheers,

/P

--===============6055286493129362548==--
