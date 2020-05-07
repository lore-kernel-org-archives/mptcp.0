Content-Type: multipart/mixed; boundary="===============7991452618114992122=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 3/7] mptcp: avoid blocking in
 tcp_sendpages due to skb alloc
Date: Thu, 07 May 2020 16:38:44 +0200
Message-ID: <b26e0db2e360fca39144019505f1aa418a544fa8.camel@redhat.com>
In-Reply-To: 20200507143348.GO32392@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 4341

--===============7991452618114992122==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-05-07 at 16:33 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > Ok, I missed/forgot that the retransmission must be non blocking.
> > =

> > I now see that retransmissions are fine as is!
> > =

> > Still on this, don't we need to check mptcp_sendmsg_alloc_skb() inside
> > the sendmsg() loop, too? Elsewhere we could fail on large send if we
> > complete the first skb, keep looping in sendmsg() and the next
> > iteration would block. Am I missing something?
> =

> You mean:
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 780d873b6c19..66a67b11d01b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -814,6 +814,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
>                 if (!tx_ok)
>                         break;
>                 if (!sk_stream_memory_free(ssk) ||
> +                   !mptcp_sendmsg_alloc_skb(ssk) ||
>                     !mptcp_page_frag_refill(ssk, pfrag) ||
>                     !mptcp_ext_cache_refill(msk)) {
>                         tcp_push(ssk, msg->msg_flags, mss_now,
> =

> ?

Yep exactly!

> Yes, that could be added.  Its not a huge deal since mptcp_sendmsg_frag()=
 would
> yield -EAGAIN if do_tcp_sendpages would block, and that will then re-star=
t for
> the 'blocking io' case (i.e., ssk is released and 'goto restart' fetches =
next
> ssk with posssible wait_for_memory).

Again, I missed some pieces of the puzzle ;) Yep, we are good even
without that. The lack of simmetry WRT the other allocation is a bit
confusing to me, but it's really a subjective matter.

I'm good with or without the above chunk

Thanks for the clarifications!

Paolo

(ack to the whole series!)


--===============7991452618114992122==--
