Content-Type: multipart/mixed; boundary="===============6375119558470956525=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC 6/7] add mptcp_subflow_shutdown
Date: Mon, 25 Nov 2019 15:58:00 +0100
Message-ID: <cf51f973cc359df224bef67a1d0468503934d4fc.camel@redhat.com>
In-Reply-To: 20191125122323.GA795@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 2685

--===============6375119558470956525==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-11-25 at 13:23 +0100, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > On Mon, 2019-11-25 at 03:15 +0100, Florian Westphal wrote:
> > > +static void mptcp_subflow_shutdown(struct sock *ssk, int how)
> > > +{
> > > +	lock_sock(ssk);
> > > +
> > > +	switch (ssk->sk_state) {
> > > +	case TCP_LISTEN:
> > > +		if (!(how & RCV_SHUTDOWN))
> > > +			break;
> > > +		/* fall through */
> > > +	case TCP_SYN_SENT:
> > > +		tcp_disconnect(ssk, O_NONBLOCK);
> > > +		break;
> > > +	default:
> > > +		ssk->sk_shutdown |=3D how;
> > > +		tcp_shutdown(ssk, how);
> > > +		break;
> > > +	}
> > > +
> > > +	/* Wake up anyone sleeping in poll. */
> > > +	ssk->sk_state_change(ssk);
> > > +	release_sock(ssk);
> > > +}
> > =

> > I think we can move this one can be moved to subflow.c.
> > =

> > Yep, it will lose the 'static' scope, but protocol.c is becoming quite
> > big...
> =

> Yes, but its still small compared to e.g. tcp_input.c.
> =

> > WDYT?
> =

> I like static scope. For every visible symbol one needs to check where
> else it might be used before making changes to it...

Oks, no objections on my side.

Cheers,

Paolo

--===============6375119558470956525==--
