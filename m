Content-Type: multipart/mixed; boundary="===============5090008096407070676=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC 3/3] mptcp: Add handling of incoming MP_JOIN requests
Date: Tue, 28 May 2019 16:22:00 -0700
Message-ID: <d2c2df4ea2982352980ce973dd5202d661ea3060.camel@linux.intel.com>
In-Reply-To: efc387a96bddc542bd921a065048ab6005e294f2.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1261

--===============5090008096407070676==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-05-27 at 16:52 +0200, Paolo Abeni wrote:
> Hi,
> =

> I'm sorry for the late feedback, I'm still looking at this code...
> =

> On Wed, 2019-05-22 at 14:38 -0700, Peter Krystad wrote:
> > diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> > index 9c2a0d36fb20..baf8b975fce6 100644
> > --- a/net/ipv4/tcp_minisocks.c
> > +++ b/net/ipv4/tcp_minisocks.c
> > @@ -764,6 +764,12 @@ struct sock *tcp_check_req(struct sock *sk, struct=
 sk_buff *skb,
> >  	if (!child)
> >  		goto listen_overflow;
> >  =

> > +	if (own_req && sk_is_mptcp(child) && mptcp_sk_is_subflow(child)) {
> > +		inet_csk_reqsk_queue_drop(sk, req);
> > +		reqsk_queue_removed(&inet_csk(sk)->icsk_accept_queue, req);
> > +		return child;
> > +	}
> > +
> =

> Don't we need to check this is not a fastopen before dropping the req?

I was thinking we would initially not support fastopen for MPTCP connection=
s,
meaning we would ignore cookie requests in a SYN with MP_CAPABLE. I haven't
added this check, what do others think about fastopen as a requirement for
MPTCP?

> =

> Can't we avoid the above hunck anyway, handling the special MP_JOIN
> scenario in mptcp_accept() ? so that we reduce hooking, the user-space
> is notified of a new subflow - 'accept()' would probably return a
> specific error code, not a new fd!!! - and we enforce some limits on
> the number of pending/new subflows.

I was not thinking of forcing a change to the typical user accept()
handling so this is how that is avoided. In earlier discussions it seemed
making the user use a new protocol value was enough of a hurdle.

Peter.
  =

> WDYT?
> =

> Thanks,
> =

> Paolo
> =



--===============5090008096407070676==--
