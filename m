Content-Type: multipart/mixed; boundary="===============2465406563307562105=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v2] mptcp: adjust mptcp receive buffer
 limit if subflow has larger one
Date: Wed, 19 Aug 2020 10:49:02 +0200
Message-ID: <20200819084902.GG15804@breakpoint.cc>
In-Reply-To: alpine.OSX.2.23.453.2008171736170.12394@saborios-mobl3.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5581

--===============2465406563307562105==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> > In mptcp_data_ready() we do not hold the mptcp socket lock, so
> > modification of sk_rcvbuf is racy.  Do it when moving skbs from subflow
> > to mptcp socket, both sockets are locked in this case.
> > =

> > v2: move rcvbuf update to __mptcp_move_skbs_from_subflow where both
> > mptcp and subflow sk locks are held (pointed out by Mat).
> > =

> > Signed-off-by: Florian Westphal <fw(a)strlen.de>
> > ---
> > net/mptcp/protocol.c | 22 +++++++++++++++++-----
> > 1 file changed, 17 insertions(+), 5 deletions(-)
> > =

> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 77d655b0650c..ecf93d0bec14 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -454,10 +454,17 @@ static bool __mptcp_move_skbs_from_subflow(struct=
 mptcp_sock *msk,
> > 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> > 	struct sock *sk =3D (struct sock *)msk;
> > 	unsigned int moved =3D 0;
> > +	int sk_rbuf, ssk_rbuf;
> > 	bool more_data_avail;
> > 	struct tcp_sock *tp;
> > 	bool done =3D false;
> > =

> > +	ssk_rbuf =3D READ_ONCE(ssk->sk_rcvbuf);
> > +	sk_rbuf =3D READ_ONCE(sk->sk_rcvbuf);
> > +
> > +	if (unlikely(ssk_rbuf > sk_rbuf))
> > +		WRITE_ONCE(sk->sk_rcvbuf, ssk_rbuf);
> > +
> =

> The v2 changes do address my concerns with v1, but now I'm looking at how
> this change interacts with mptcp_rcv_space_adjust() and it's not obvious
> what all the consequences are. Is ssk_rbuf always in a valid range for the
> msk,

What is the 'valid range'?  TCP caps ssk_rcvbuf at rmem[2] sysctl.

> and is it ok if that is propagated to msk->sk_rcvbuf and changes the
> way other ssk->sk_rcvbuf values are updated in mptcp_rcv_space_adjust()?

Hmm, the values should be kept in-sync.

If msk->sk_rcvbuf is large (e.g. increased via msk autotune) and we
don't make the subflow rcvbuf setting follow along (this is what we do
ATM), then subflow will drop packets on the floor if we can't drain fast
enough.

If TCP has increased the subflow sk_rcvbuf via clamp_window() path and we
don't update the msk (which is what this patch changes), then we may
end up not moving all pending skbs to the mptcp socket because TCP
queued up more than what the mptcp rcvbuf limit allows.

That seems quite stupid to me -- data is already here, why have a delay?
Making this change gets rid of excess delays in the "lo" test cases for
me.

> Also what about checking (sk->sk_userlocks & SOCK_RCVBUF_LOCK)?

Agreed, that should be added.

I can send a v3, let me know.
--===============2465406563307562105==--
