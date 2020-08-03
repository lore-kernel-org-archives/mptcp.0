Content-Type: multipart/mixed; boundary="===============0220902533955705295=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 11/12] mptcp: allow picking different xmit
 subflows
Date: Mon, 03 Aug 2020 15:23:33 +0200
Message-ID: <dbf14c6b78109e62f17388217de97eb9a88ee9a4.camel@redhat.com>
In-Reply-To: 20200803125604.GP29169@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 5442

--===============0220902533955705295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-08-03 at 14:56 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > On Sun, 2020-08-02 at 01:50 +0200, Florian Westphal wrote:
> > > Paolo Abeni <pabeni(a)redhat.com> wrote:
> > > > Update the scheduler to less trivial heuristic: cache
> > > > the last used subflow, and try to send on it a reasonably
> > > > long burst of data. When the burst or the subflow send
> > > > space is exausted, move to the next one with available
> > > > send space.
> > > > =

> > > > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > > > ---
> > > >  net/mptcp/protocol.c | 112 +++++++++++++++++++++++++++++++++++++--=
----
> > > >  net/mptcp/protocol.h |   6 ++-
> > > >  2 files changed, 101 insertions(+), 17 deletions(-)
> > > > =

> > > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > > index ef5b68c4ff49..89c0400593d1 100644
> > > > --- a/net/mptcp/protocol.c
> > > > +++ b/net/mptcp/protocol.c
> > > > @@ -1012,39 +1012,112 @@ static void mptcp_nospace(struct sock *sk,=
 struct sock *ssk)
> > > >  		set_bit(SOCK_NOSPACE, &sock->flags);
> > > >  }
> > > >  =

> > > > +static bool mptcp_subflow_active(struct mptcp_subflow_context *sub=
flow,
> > > > +				 bool fallback)
> > > > +{
> > > > +	struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> > > > +
> > > > +	/* subflow must be open for write */
> > > > +	if ((1 << ssk->sk_state) &
> > > > +	    (TCPF_CLOSE | TCPF_LAST_ACK | TCPF_CLOSING | TCPF_FIN_WAIT2 |
> > > > +	     TCPF_FIN_WAIT1))
> > > > +		return false;
> > > =

> > > Hmmm, why is this not checking for TCP_ESTABLISHED -> true, rather th=
an
> > > checking 'states i do not want'?
> > =

> > I think we can pick a subflow for xmit even after receiving a TCP FIN
> > on such subflows, so the subflow status could be different from
> > TCP_ESTABLISHED. =

> > =

> > To my twiested mind was more natural check for not allowed states, I
> > can flip to allowed one if needed.
> =

> I would prefer that.  Otherwise I have to invert manually during review,
> and this makes no sense to me when I do the negation:
> =

> States:
> TCPF_ESTABLISHED =3D (1 << TCP_ESTABLISHED),
> TCPF_SYN_SENT    =3D (1 << TCP_SYN_SENT),
> TCPF_SYN_RECV    =3D (1 << TCP_SYN_RECV),
> TCPF_FIN_WAIT1   =3D (1 << TCP_FIN_WAIT1),
> TCPF_FIN_WAIT2   =3D (1 << TCP_FIN_WAIT2),
> TCPF_TIME_WAIT   =3D (1 << TCP_TIME_WAIT),
> TCPF_CLOSE       =3D (1 << TCP_CLOSE),
> TCPF_CLOSE_WAIT  =3D (1 << TCP_CLOSE_WAIT),
> TCPF_LAST_ACK    =3D (1 << TCP_LAST_ACK),
> TCPF_LISTEN      =3D (1 << TCP_LISTEN),
> TCPF_CLOSING     =3D (1 << TCP_CLOSING),
> TCPF_NEW_SYN_RECV =3D (1 << TCP_NEW_SYN_RECV),
> =

> So, above checks disables:
> TCPF_CLOSE       =3D (1 << TCP_CLOSE),
> TCPF_LAST_ACK    =3D (1 << TCP_LAST_ACK),
> TCPF_CLOSING     =3D (1 << TCP_CLOSING),
> TCPF_FIN_WAIT1   =3D (1 << TCP_FIN_WAIT1),
> TCPF_FIN_WAIT2   =3D (1 << TCP_FIN_WAIT2),
> =

> ... which makes following ok:
> =

> TCPF_ESTABLISHED =3D (1 << TCP_ESTABLISHED),
> =

> Agree on that.
> =

> TCPF_SYN_SENT    =3D (1 << TCP_SYN_SENT),
> =

> we don't know yet if connection will complete, or if
> mptcp will be available.
> =

> TCPF_SYN_RECV    =3D (1 << TCP_SYN_RECV),
> =

> same.
> =

> TCPF_TIME_WAIT   =3D (1 << TCP_TIME_WAIT),
> =

> This is also strange, this is a quiesence period to catch
> in-flight packets.  I don't think this subflow should still
> be used for xmit.
> =

> TCPF_CLOSE_WAIT  =3D (1 << TCP_CLOSE_WAIT),
> =

> Agree on this one as well -- its ok to xmit here.
> =

> TCPF_LISTEN      =3D (1 << TCP_LISTEN),
> =

> Should not happen of course, but its definitely
> not usable :-)
> =

> TCPF_NEW_SYN_RECV =3D (1 << TCP_NEW_SYN_RECV),
> =

> and that is... mhhh... strange.  Why is this one ok?

Agreed to the above - we also aready have sk_stream_wait_connect() if
state is not TCPF_ESTABLISHED | TCPF_CLOSE_WAIT.

> Checking 'fallback' made no sense to me.  Why do we need to check for thi=
s?

In teory we should not have additional subflows in the fallback status,
but we can have an MPJ handskake and fallback racing togethar, so we
end-up with msk in fallback status and one or more fully established
subflows. If/when that happen we must avoid picking mpj subflows. =


Perhaps is just easier/clearer add an explict (unlikely???) case
in mptcp_subflow_get_send() and mptcp_subflow_get_retrans()

> > > Hmm, should this be a separate bug fix (prevent non-fully-established=
-join)?
> > =

> > I think the bug is only apparent after we have non backup subflows
> > and/or remove addr support ?!?
> =

> What about other mptcp stack peer?  Couldn't they create a non-backup flo=
w?
> =

> [ I don't mind if you don't want a separate patch for this, it just
> looked like a small fix to me that could be applied already ]

yep, we can have non backup subflows with mptcp.org peers. I still
would opt for a single patch ;)

/P

--===============0220902533955705295==--
