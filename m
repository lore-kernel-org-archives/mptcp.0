Content-Type: multipart/mixed; boundary="===============9190731012157914914=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC 3/3] mptcp: Add handling of incoming MP_JOIN requests
Date: Fri, 31 May 2019 05:56:51 -0700
Message-ID: <df4fec21fed34f9fa0fd6b067f4b99bbb58185ed.camel@linux.intel.com>
In-Reply-To: 515713d691f3e3f9883149e86c293bcc9eb5652c.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1271

--===============9190731012157914914==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-05-29 at 10:06 +0200, Paolo Abeni wrote:
> Hi,
> =

> On Tue, 2019-05-28 at 16:22 -0700, Peter Krystad wrote:
> > On Mon, 2019-05-27 at 16:52 +0200, Paolo Abeni wrote:
> > > On Wed, 2019-05-22 at 14:38 -0700, Peter Krystad wrote:
> > > > diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> > > > index 9c2a0d36fb20..baf8b975fce6 100644
> > > > --- a/net/ipv4/tcp_minisocks.c
> > > > +++ b/net/ipv4/tcp_minisocks.c
> > > > @@ -764,6 +764,12 @@ struct sock *tcp_check_req(struct sock *sk, st=
ruct sk_buff *skb,
> > > >  	if (!child)
> > > >  		goto listen_overflow;
> > > >  =

> > > > +	if (own_req && sk_is_mptcp(child) && mptcp_sk_is_subflow(child)) {
> > > > +		inet_csk_reqsk_queue_drop(sk, req);
> > > > +		reqsk_queue_removed(&inet_csk(sk)->icsk_accept_queue, req);
> > > > +		return child;
> > > > +	}
> > > > +
> > > =

> > > Don't we need to check this is not a fastopen before dropping the req?
> > =

> > I was thinking we would initially not support fastopen for MPTCP connec=
tions,
> > meaning we would ignore cookie requests in a SYN with MP_CAPABLE. I hav=
en't
> > added this check, what do others think about fastopen as a requirement =
for
> > MPTCP?
> =

> I'm sorry, I was not clear enough. I think fastopen is _NOT_ a
> requirement for MPTCP. My doubt is: can we hit the above conditional
> with a fast-open socket? (regardless of MPTCP code implementing support
> for fast-open). If so, should we explicitly fail the MP_JOIN to avoid
> messing with the tcp socket status?

Thanks Paolo - I understand your point. But my thinking was it would be bet=
ter
to avoid worrying about fastopen sockets here by rejecting them (forcing th=
em
to fall back to 3-way handshake) when the initial SYN is received, this way
if it is a MPTCP subflow socket it is NOT fastopen and the above clause wou=
ld
never be hit.

Peter.

> Not sure if the above is now more clear ;)
> =

> > > Can't we avoid the above hunck anyway, handling the special MP_JOIN
> > > scenario in mptcp_accept() ? so that we reduce hooking, the user-space
> > > is notified of a new subflow - 'accept()' would probably return a
> > > specific error code, not a new fd!!! - and we enforce some limits on
> > > the number of pending/new subflows.
> > =

> > I was not thinking of forcing a change to the typical user accept()
> > handling so this is how that is avoided. In earlier discussions it seem=
ed
> > making the user use a new protocol value was enough of a hurdle.
> =

> Ok, understood. I agree that we should avoid uAPI changes; before I did
> not consider such aspect. I'm fine with the current impl in this
> regard.
> =

> Thanks,
> =

> Paolo
> =



--===============9190731012157914914==--
