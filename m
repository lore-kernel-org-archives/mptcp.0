Content-Type: multipart/mixed; boundary="===============5758670593419884150=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC 3/3] mptcp: Add handling of incoming MP_JOIN requests
Date: Wed, 29 May 2019 10:06:36 +0200
Message-ID: <515713d691f3e3f9883149e86c293bcc9eb5652c.camel@redhat.com>
In-Reply-To: d2c2df4ea2982352980ce973dd5202d661ea3060.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1263

--===============5758670593419884150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 2019-05-28 at 16:22 -0700, Peter Krystad wrote:
> On Mon, 2019-05-27 at 16:52 +0200, Paolo Abeni wrote:
> > On Wed, 2019-05-22 at 14:38 -0700, Peter Krystad wrote:
> > > diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> > > index 9c2a0d36fb20..baf8b975fce6 100644
> > > --- a/net/ipv4/tcp_minisocks.c
> > > +++ b/net/ipv4/tcp_minisocks.c
> > > @@ -764,6 +764,12 @@ struct sock *tcp_check_req(struct sock *sk, stru=
ct sk_buff *skb,
> > >  	if (!child)
> > >  		goto listen_overflow;
> > >  =

> > > +	if (own_req && sk_is_mptcp(child) && mptcp_sk_is_subflow(child)) {
> > > +		inet_csk_reqsk_queue_drop(sk, req);
> > > +		reqsk_queue_removed(&inet_csk(sk)->icsk_accept_queue, req);
> > > +		return child;
> > > +	}
> > > +
> > =

> > Don't we need to check this is not a fastopen before dropping the req?
> =

> I was thinking we would initially not support fastopen for MPTCP connecti=
ons,
> meaning we would ignore cookie requests in a SYN with MP_CAPABLE. I haven=
't
> added this check, what do others think about fastopen as a requirement for
> MPTCP?

I'm sorry, I was not clear enough. I think fastopen is _NOT_ a
requirement for MPTCP. My doubt is: can we hit the above conditional
with a fast-open socket? (regardless of MPTCP code implementing support
for fast-open). If so, should we explicitly fail the MP_JOIN to avoid
messing with the tcp socket status?

Not sure if the above is now more clear ;)

> > Can't we avoid the above hunck anyway, handling the special MP_JOIN
> > scenario in mptcp_accept() ? so that we reduce hooking, the user-space
> > is notified of a new subflow - 'accept()' would probably return a
> > specific error code, not a new fd!!! - and we enforce some limits on
> > the number of pending/new subflows.
> =

> I was not thinking of forcing a change to the typical user accept()
> handling so this is how that is avoided. In earlier discussions it seemed
> making the user use a new protocol value was enough of a hurdle.

Ok, understood. I agree that we should avoid uAPI changes; before I did
not consider such aspect. I'm fine with the current impl in this
regard.

Thanks,

Paolo


--===============5758670593419884150==--
