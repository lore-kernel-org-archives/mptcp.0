Content-Type: multipart/mixed; boundary="===============5984778612927914519=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC 06/14] sendmsg: block until mptcp sk is writeable
Date: Mon, 18 Nov 2019 13:11:25 +0100
Message-ID: <20191118121125.GA2284@breakpoint.cc>
In-Reply-To: c5c49589a929e651f957fee74b1eb264cdc35104.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2578

--===============5984778612927914519==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Thu, 2019-11-14 at 18:32 +0100, Florian Westphal wrote:
> > This disables transmit of new data until the peer has acked
> > enough mptcp data to get below the wspace write threshold (more than
> > half of wspace upperlimit is available again).
> > =

> > Also have poll not report EPOLLOUT in this case, its not relevant if a
> > subflow is writeable.
> > =

> > The latter is a temporary workaround that is needed because mptcp_poll
> > walks the subflows and calls __tcp_poll on each of them.
> > Because subflow ssk is usually writable, we will have to undo-that
> > if the mptcp sndbuf is exhausted.  This won't be needed anymore once
> > __tcp_poll is removed, I am working on this.
> > =

> > Signed-off-by: Florian Westphal <fw(a)strlen.de>
> > ---
> >  net/mptcp/protocol.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> > =

> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 2144e80b8704..83be407e1dd6 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -406,6 +406,18 @@ static int mptcp_sendmsg(struct sock *sk, struct m=
sghdr *msg, size_t len)
> >  		return ret;
> >  	}
> >  =

> > +	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
> > +
> > +	mptcp_clean_una(sk);
> > +
> > +	while (!sk_stream_memory_free(sk)) {
> > +		ret =3D sk_stream_wait_memory(sk, &timeo);
> > +		if (ret)
> > +			goto out;
> > +
> > +		mptcp_clean_una(sk);
> > +	}
> > +
> =

> Can we move the above loop to the non fallback case only ? e.g. after
> the below !mptcp_subflow_get(msk) checks?
> =

> If so, we could have a single loop checking for:
> =

> !sk_stream_memory_free(sk) || !mptcp_subflow_get_send()
> =

> (together with the next patch)

It would be easy to do if I remove

       if (!msg_data_left(msg)) {
	       pr_debug("empty send");
	       ret =3D sock_sendmsg(ssk->sk_socket, msg);

any idea why this is there in the first place?
--===============5984778612927914519==--
