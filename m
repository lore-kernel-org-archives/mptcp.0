Content-Type: multipart/mixed; boundary="===============7995631477713965596=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC 10/14] recv: make DATA_READY reflect ssk in-sequence
 state
Date: Mon, 18 Nov 2019 13:36:01 +0100
Message-ID: <20191118123601.GC2284@breakpoint.cc>
In-Reply-To: 525d25169a7a800ca7a3775fbf2ec09e47ecb8fd.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2581

--===============7995631477713965596==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Thu, 2019-11-14 at 18:32 +0100, Florian Westphal wrote:
> > @@ -614,8 +612,7 @@ static int mptcp_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
> >  			if (bytes_read < 0) {
> >  				if (!copied)
> >  					copied =3D bytes_read;
> > -				done =3D true;
> =

> Why 'done' is not set here anymore? I think we want to quit the
> recvmsg() loop on socket error ?!?

Right, I'll add it back.

> >  		/* only the master socket status is relevant here. The exit
> >  		 * conditions mirror closely tcp_recvmsg()
> >  		 */
> >  		if (copied >=3D target)
> > -			break;
> > +			goto out;
> =

> Double checking I'm following correctly the patch: 'goto out' and
> 'break;' jump to the same position right? - just after the main
> recvmsg() loop.

I'll re-add the 'break' statements adn remove the out label.
> =

> The same in several places below.
> =

> [...]
> > +out:
> > +	if (more_data_avail) {
> > +		if (!test_bit(MPTCP_DATA_READY, &msk->flags))
> > +			set_bit(MPTCP_DATA_READY, &msk->flags);
> =

> Can we use test_and_set_bit() here? Othewise, don't we need some smp
> barriers?

Yes, but why?  We would not use its return value.
Its only purpose is to avoid usless set_bit in case its already
set  -- which it is in most cases.

We don't need barriers here in any case (the check is on same memory
address and there is no depencency to any other memory address here).

> > +	} else if (!wait_data) {
> > +		clear_bit(MPTCP_DATA_READY, &msk->flags);
> > +
> > +		/* .. race-breaker: ssk might get new data after last
> > +		 * data_available() returns false.
> > +		 */
> > +		ssk =3D mptcp_subflow_recv_lookup(msk);
> > +		if (unlikely(ssk))
> > +			set_bit(MPTCP_DATA_READY, &msk->flags);
> =

> Don't we need smp barriers around the bit operations here?

Why?  What sequence would result in a problem?

Cpu0                                  Cpu1
  clear_bit()
  ssk =3D recv_lookup()                 data_ready()
  if (NULL)...                        -> set_bit()


Result: DATA_READY is set.

I can't come up with a sequence where we'd do:

data_ready()
  ->set_bit()
clear_bit()
... and then have mptcp_subflow_recv_lookup() come
up with a NULL ssk if the subflow has data available.

(Which would mean DATA_READY is unset instead of set).
--===============7995631477713965596==--
