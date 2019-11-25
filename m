Content-Type: multipart/mixed; boundary="===============4070672013500863186=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC 6/7] add mptcp_subflow_shutdown
Date: Mon, 25 Nov 2019 13:23:23 +0100
Message-ID: <20191125122323.GA795@breakpoint.cc>
In-Reply-To: f10b15f98f58b168624f3a2366ea5e9cae4975c8.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2682

--===============4070672013500863186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Mon, 2019-11-25 at 03:15 +0100, Florian Westphal wrote:
> > +static void mptcp_subflow_shutdown(struct sock *ssk, int how)
> > +{
> > +	lock_sock(ssk);
> > +
> > +	switch (ssk->sk_state) {
> > +	case TCP_LISTEN:
> > +		if (!(how & RCV_SHUTDOWN))
> > +			break;
> > +		/* fall through */
> > +	case TCP_SYN_SENT:
> > +		tcp_disconnect(ssk, O_NONBLOCK);
> > +		break;
> > +	default:
> > +		ssk->sk_shutdown |=3D how;
> > +		tcp_shutdown(ssk, how);
> > +		break;
> > +	}
> > +
> > +	/* Wake up anyone sleeping in poll. */
> > +	ssk->sk_state_change(ssk);
> > +	release_sock(ssk);
> > +}
> =

> I think we can move this one can be moved to subflow.c.
> =

> Yep, it will lose the 'static' scope, but protocol.c is becoming quite
> big...

Yes, but its still small compared to e.g. tcp_input.c.

> WDYT?

I like static scope. For every visible symbol one needs to check where
else it might be used before making changes to it...
--===============4070672013500863186==--
