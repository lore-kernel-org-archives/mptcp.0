Content-Type: multipart/mixed; boundary="===============7138802446872088144=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 3/7] mptcp: avoid blocking in
 tcp_sendpages due to skb alloc
Date: Thu, 07 May 2020 16:13:48 +0200
Message-ID: <ded361991210fd296fdd471d2a5dafa2da785163.camel@redhat.com>
In-Reply-To: 20200507114408.GM32392@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 4336

--===============7138802446872088144==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-05-07 at 13:44 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > On Wed, 2020-05-06 at 15:02 +0200, Florian Westphal wrote:
> > > If memory is tight, tcp_sendpages may fail because it can't
> > > allocate the skb head.
> > > =

> > > Now that we pass DONTWAIT to tcp_sendpages it won't block anymore on =
the
> > > subflow socket when this happens.
> > > =

> > > We can avoid such allocation failure in tcp code by preallocating an =
skb
> > > skb when we pick the subflow to use.
> > =

> > The sk_tx_skb_cache usage caused some TCP regression upstream:
> > =

> > commit 0b7d7f6b22084a3156f267c85303908a8f4c9a08
> > Author: Eric Dumazet <edumazet(a)google.com>
> > Date:   Fri Jun 14 16:22:20 2019 -0700
> > =

> >     tcp: add tcp_tx_skb_cache sysctl
> > =

> > but that one was not very clear and I guess does not matter for MPTCP -
> > lacking an established baseline.
> > =

> > So all good ;)
> > =

> > > @@ -656,9 +677,13 @@ static int mptcp_sendmsg_frag(struct sock *sk, s=
truct sock *ssk,
> > >  static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> > >  {
> > >  	struct mptcp_subflow_context *subflow;
> > > +	struct sock *sk =3D (struct sock *)msk;
> > >  	struct sock *backup =3D NULL;
> > >  =

> > > -	sock_owned_by_me((const struct sock *)msk);
> > > +	sock_owned_by_me(sk);
> > > +
> > > +	if (!mptcp_sendmsg_alloc_skb(sk))
> > > +		return NULL;
> > >  =

> > >  	mptcp_for_each_subflow(msk, subflow) {
> > >  		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> > =

> > Don't we need the same for mptcp_subflow_get_retrans() ?
> =

> Its optional.  If allocation doesn't fail there is no difference.
> =

> If it fails then as-is, mptcp_sendmsg_frag will return -EAGAIN and
> no packet is sent.
> =

> If I'd add mptcp_sendmsg_alloc_skb() call to the worker, then it
> would bail our right before (and would not sleep either).
> =

> So the end result is the same: no retransmission takes place.
> =

> Let me know if you prefer explicit mptcp_sendmsg_alloc_skb()
> for retransmit case too.

Ok, I missed/forgot that the retransmission must be non blocking.

I now see that retransmissions are fine as is!

Still on this, don't we need to check mptcp_sendmsg_alloc_skb() inside
the sendmsg() loop, too? Elsewhere we could fail on large send if we
complete the first skb, keep looping in sendmsg() and the next
iteration would block. Am I missing something?

Thanks!

Paolo


--===============7138802446872088144==--
