Content-Type: multipart/mixed; boundary="===============5137271961847001704=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp] squashto: mptcp: protect the rx path with
 the msk socket spinlock
Date: Fri, 20 Nov 2020 14:18:31 +0100
Message-ID: <20201120131831.GA1831@breakpoint.cc>
In-Reply-To: 5f06de0671cc23d9be8723cd9ed7f8a15d21ddeb.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6878

--===============5137271961847001704==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 92236a2ccbea..e62d34034d9e 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2707,7 +2707,9 @@ void mptcp_destroy_common(struct mptcp_sock *msk)
> >  =

> >  	__mptcp_clear_xmit(sk);
> >  =

> > -	skb_queue_splice_tail_init(&sk->sk_receive_queue, &msk->receive_queue=
);
> > +	/* move to sk_receive_queue, sk_stream_kill_queues will purge it */
> > +	skb_queue_splice_tail_init(&msk->receive_queue, &sk->sk_receive_queue=
);
> > +
> >  	skb_rbtree_purge(&msk->out_of_order_queue);
> >  	mptcp_token_destroy(msk);
> >  	mptcp_pm_free_anno_list(msk);
> =

> =

> LGTM, thanks for catching this!
> =

> Not sure why self-tests did non complain loudly here ?!?

Probably all test cases drain the rx queue completely before exiting,
we might need something new to cover this.

That being said, packetdrill tests catch it but I suppose those do not
run as frequently as the kselftest infra.
--===============5137271961847001704==--
