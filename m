Content-Type: multipart/mixed; boundary="===============6439688202370956201=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 11/12] mptcp: allow picking different xmit
 subflows
Date: Mon, 03 Aug 2020 14:56:04 +0200
Message-ID: <20200803125604.GP29169@breakpoint.cc>
In-Reply-To: f49ad309972273d0598f720c08f8afe4f7967a5e.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5440

--===============6439688202370956201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Sun, 2020-08-02 at 01:50 +0200, Florian Westphal wrote:
> > Paolo Abeni <pabeni(a)redhat.com> wrote:
> > > Update the scheduler to less trivial heuristic: cache
> > > the last used subflow, and try to send on it a reasonably
> > > long burst of data. When the burst or the subflow send
> > > space is exausted, move to the next one with available
> > > send space.
> > > =

> > > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > > ---
> > >  net/mptcp/protocol.c | 112 +++++++++++++++++++++++++++++++++++++----=
--
> > >  net/mptcp/protocol.h |   6 ++-
> > >  2 files changed, 101 insertions(+), 17 deletions(-)
> > > =

> > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > index ef5b68c4ff49..89c0400593d1 100644
> > > --- a/net/mptcp/protocol.c
> > > +++ b/net/mptcp/protocol.c
> > > @@ -1012,39 +1012,112 @@ static void mptcp_nospace(struct sock *sk, s=
truct sock *ssk)
> > >  		set_bit(SOCK_NOSPACE, &sock->flags);
> > >  }
> > >  =

> > > +static bool mptcp_subflow_active(struct mptcp_subflow_context *subfl=
ow,
> > > +				 bool fallback)
> > > +{
> > > +	struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> > > +
> > > +	/* subflow must be open for write */
> > > +	if ((1 << ssk->sk_state) &
> > > +	    (TCPF_CLOSE | TCPF_LAST_ACK | TCPF_CLOSING | TCPF_FIN_WAIT2 |
> > > +	     TCPF_FIN_WAIT1))
> > > +		return false;
> > =

> > Hmmm, why is this not checking for TCP_ESTABLISHED -> true, rather than
> > checking 'states i do not want'?
> =

> I think we can pick a subflow for xmit even after receiving a TCP FIN
> on such subflows, so the subflow status could be different from
> TCP_ESTABLISHED. =

>
> To my twiested mind was more natural check for not allowed states, I
> can flip to allowed one if needed.

I would prefer that.  Otherwise I have to invert manually during review,
and this makes no sense to me when I do the negation:

States:
TCPF_ESTABLISHED =3D (1 << TCP_ESTABLISHED),
TCPF_SYN_SENT    =3D (1 << TCP_SYN_SENT),
TCPF_SYN_RECV    =3D (1 << TCP_SYN_RECV),
TCPF_FIN_WAIT1   =3D (1 << TCP_FIN_WAIT1),
TCPF_FIN_WAIT2   =3D (1 << TCP_FIN_WAIT2),
TCPF_TIME_WAIT   =3D (1 << TCP_TIME_WAIT),
TCPF_CLOSE       =3D (1 << TCP_CLOSE),
TCPF_CLOSE_WAIT  =3D (1 << TCP_CLOSE_WAIT),
TCPF_LAST_ACK    =3D (1 << TCP_LAST_ACK),
TCPF_LISTEN      =3D (1 << TCP_LISTEN),
TCPF_CLOSING     =3D (1 << TCP_CLOSING),
TCPF_NEW_SYN_RECV =3D (1 << TCP_NEW_SYN_RECV),

So, above checks disables:
TCPF_CLOSE       =3D (1 << TCP_CLOSE),
TCPF_LAST_ACK    =3D (1 << TCP_LAST_ACK),
TCPF_CLOSING     =3D (1 << TCP_CLOSING),
TCPF_FIN_WAIT1   =3D (1 << TCP_FIN_WAIT1),
TCPF_FIN_WAIT2   =3D (1 << TCP_FIN_WAIT2),

... which makes following ok:

TCPF_ESTABLISHED =3D (1 << TCP_ESTABLISHED),

Agree on that.

TCPF_SYN_SENT    =3D (1 << TCP_SYN_SENT),

we don't know yet if connection will complete, or if
mptcp will be available.

TCPF_SYN_RECV    =3D (1 << TCP_SYN_RECV),

same.

TCPF_TIME_WAIT   =3D (1 << TCP_TIME_WAIT),

This is also strange, this is a quiesence period to catch
in-flight packets.  I don't think this subflow should still
be used for xmit.

TCPF_CLOSE_WAIT  =3D (1 << TCP_CLOSE_WAIT),

Agree on this one as well -- its ok to xmit here.

TCPF_LISTEN      =3D (1 << TCP_LISTEN),

Should not happen of course, but its definitely
not usable :-)

TCPF_NEW_SYN_RECV =3D (1 << TCP_NEW_SYN_RECV),

and that is... mhhh... strange.  Why is this one ok?

Checking 'fallback' made no sense to me.  Why do we need to check for this?

Am I missing anything?  If yes, please add a comment explaining that
scenario.  Same for fallback, I do not understand how fallback yes/no makes
a difference here.

> > I don't understand this comment.  The part with 'fully established
> > MP_JOIN' is clear to me.
> > =

> > Is this about SYN_SENT state is fine if ssk tested is the 'msk->first'
> > subflow?
> =

> yes, exactly.

Ok.  Would still like to understand how this can occur (data to transmit,
first connection not established yet).

> > If so, it might make sense to re-arrange the check to something like
> > 'subflow->request_join && established && subflow->fully_established &&
> > !fallback' -> return true
> > else, return state =3D=3D ESTABLISHED?
> > =

> > or even, ".. else subflow requal to msk->first and state eq ESTABLISHED
> > return true'?
> =

> I think we need to check for more TCP states than ESTABLISHED for both
> first and MP_JOIN subflow. For '->first' we should additionally
> allow SYN_SENT and TCP_SYN_RECV. Not sure the above will simplify ?!?

Check for syn sent/recv makes no sense to me.  How can we get
data to send at this point?

I would propose something like:

static bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
{
  struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);

  /* can't send if JOIN hasn't completed yet (i.e. is usable for mptcp) */
  if (subflow->request_join && !subflow->fully_established)
     return false;

  /* only send if our side has not closed yet */
  return ((1 << ssk->sk_state) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT));
}

Way less cases/tests.  What breaks/is missing here?

> > > @@ -1358,6 +1432,10 @@ static bool __mptcp_move_skbs(struct mptcp_soc=
k *msk)
> > >  	unsigned int moved =3D 0;
> > >  	bool done;
> > >  =

> > > +	if (((struct sock *)msk)->sk_state =3D=3D TCP_CLOSE)
> > > +		return false;
> > =

> > This looks funny -- why is this needed?
> =

> mptcp workqueue is called on a subflow with empty rx queue - flushed by =

> __mptcp_close_ssk - and not null data_avail. __mptcp_move_skbs() will
> loop forever. I can likely clear data_avail in __mptcp_close_ssk(), but
> never tried.

Ok, if that doesn't work please just add a small comment with above
explanation.  Thanks.

> > Hmm, should this be a separate bug fix (prevent non-fully-established-j=
oin)?
> =

> I think the bug is only apparent after we have non backup subflows
> and/or remove addr support ?!?

What about other mptcp stack peer?  Couldn't they create a non-backup flow?

[ I don't mind if you don't want a separate patch for this, it just
looked like a small fix to me that could be applied already ]
--===============6439688202370956201==--
