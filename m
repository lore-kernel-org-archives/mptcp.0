Content-Type: multipart/mixed; boundary="===============8363160736611952605=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2 mptcp] mptcp: switch sublist to mptcp socket
 lock protection
Date: Fri, 24 May 2019 15:47:13 +0200
Message-ID: <714994315fda216c566d97e176cce14ebfc79c1e.camel@redhat.com>
In-Reply-To: 20190524133939.peqnek4lrfwvkgjb@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1239

--===============8363160736611952605==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-05-24 at 15:39 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > On Wed, 2019-05-22 at 12:04 +0200, Florian Westphal wrote:
> > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > index 9a98c8e0c996..27f09ee9eaf1 100644
> > > --- a/net/mptcp/protocol.c
> > > +++ b/net/mptcp/protocol.c
> > =

> > [...]
> > =

> > > @@ -765,14 +751,34 @@ void mptcp_finish_connect(struct sock *sk, int =
mp_capable)
> > >  	if (mp_capable) {
> > >  		u64 ack_seq;
> > >  =

> > > +		/* sk (new subflow socket) is already locked, but we need
> > > +		 * to lock the parent (mptcp) socket now to add the tcp socket
> > > +		 * to the subflow list.
> > > +		 *
> > > +		 * From lockdep point of view, this creates an ABBA type
> > > +		 * deadlock: Normally (sendmsg, recvmsg, ..), we lock the mptcp
> > > +		 * socket, then acquire a subflow lock.
> > > +		 * Here we do the reverse: "subflow lock, then mptcp lock".
> > > +		 *
> > > +		 * Its alright to do this here, because this subflow is not yet
> > > +		 * on the mptcp sockets subflow list.
> > > +		 *
> > > +		 * IOW, if another CPU has this mptcp socket locked, it cannot
> > > +		 * acquire this particular subflow, because subflow->sk isn't
> > > +		 * on msk->conn_list.
> > > +		 */
> > > +		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
> > =

> > For the record: I had some doubts about the above, as I think this code
> > should be in BH context and lock_sock_nested() could sleep, but
> > CONFIG_DEBUG_ATOMIC_SLEEP=3Dy did not complain about the above.
> =

> Its wrong nontheless.
> =

> This must be changed to
> =

> local_bh_disable();
> bh_lock_sock_nested(sk);
> =

> It works because in mptcp_connect.sh test cases the completion
> occurs from backlog processing, but it could happen from bh context
> directly.

I additionally think that mptcp_finish_connect() should do nothing when
racing with mptcp_close(), that is, when sk->sk_state =3D=3D TCP_CLOSE.

Otherwise sock_release() will try to do lock_sock(sk) via tcp_close(),
still possibly in bh context.

Possibly mptcp_finish_connect() should use a return value to tell
subflow_finish_connect() to do nothing when the above race is hit.

Paolo


--===============8363160736611952605==--
