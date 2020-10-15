Content-Type: multipart/mixed; boundary="===============4178061763499392731=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [mptcp-next] mptcp: track window announced to peer
Date: Thu, 15 Oct 2020 16:49:26 +0200
Message-ID: <ce7ab495722f27f6abc58210ed8d4511cb48dc6d.camel@redhat.com>
In-Reply-To: 20201015135921.GG16895@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 6319

--===============4178061763499392731==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-10-15 at 15:59 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > > index 9abf5a0358d5..89946e451365 100644
> > > --- a/net/ipv4/tcp_output.c
> > > +++ b/net/ipv4/tcp_output.c
> > > @@ -279,6 +279,8 @@ static u16 tcp_select_window(struct sock *sk)
> > >  	}
> > >  	tp->rcv_wnd =3D new_win;
> > >  	tp->rcv_wup =3D tp->rcv_nxt;
> > > +	if (sk_is_mptcp(sk))
> > > +		mptcp_set_rwin(sk, new_win);
> > >  =

> > >  	/* Make sure we do not exceed the maximum possible
> > >  	 * scaled window.
> > =

> > I'm wondering if we could avoid this extra hook moving option writing
> > after tcp wind selection, passing the tcp_sock to mptcp_write_options
> > and fetch rcv_wup there.
> =

> Maybe, I agree the extra hooking is stupid.
> I'll have a look.
> =

> > >  	if (READ_ONCE(msk->use_64bit_ack)) {
> > >  		ack_size =3D TCPOLEN_MPTCP_DSS_ACK64;
> > > -		opts->ext_copy.data_ack =3D READ_ONCE(msk->ack_seq);
> > > +		opts->ext_copy.data_ack =3D ack_seq;
> > >  		opts->ext_copy.ack64 =3D 1;
> > >  	} else {
> > >  		ack_size =3D TCPOLEN_MPTCP_DSS_ACK32;
> > > -		opts->ext_copy.data_ack32 =3D (uint32_t)READ_ONCE(msk->ack_seq);
> > > +		opts->ext_copy.data_ack32 =3D (uint32_t)ack_seq;
> > >  		opts->ext_copy.ack64 =3D 0;
> > >  	}
> > > +
> > > +	ack_seq +=3D tcp_sk(sk)->rcv_wnd;
> > > +
> > > +	if (after64(ack_seq, msk->rcv_wnd_sent))
> > > +		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
> > > +
> > =

> > Don't we need to READ_ONCE() the msk wnd ?
> =

> wnd?  You mean tcp_sk()->rcv_wnd?

Yep, that is!

> > For TCP-generated acks or
> > TCP retransmissions, here we could be outside the msk socket lock.
> =

> Yes, we can't assume msk lock is held.
> =

> > Looks very good to me. I'm trying a few iteration of simult xmit self
> > test to see how it goes...
> =

> The alternative would be to relax the OOW test and allow a cushion,
> maybe based on msk rmem space, before deciding we have OoW packet and
> dropping it.

This code is working greatly! No more OoW here and self-test are much
more stable. There are still quite rare outlier but I think they are
unrelated to mptcp code (likely something else scheduled on the CPU
running the VM - still to be investigated).

Trimming the extra hook is not critical, I think, but would be nice if
doable without much larger changes. Otherwise I'm more then fine also
this way!

Cheers,

Paolo

--===============4178061763499392731==--
