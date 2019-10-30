Content-Type: multipart/mixed; boundary="===============7556881351983929050=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 2/2] mptcp: sendmsg: transmit on backup if
 other subflows have been closed
Date: Wed, 30 Oct 2019 16:58:02 +0100
Message-ID: <20191030155802.GE876@breakpoint.cc>
In-Reply-To: 6a4d6f0bef7b05292e77ec1b7998837cc988c793.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2358

--===============7556881351983929050==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Wed, 2019-10-30 at 15:03 +0100, Florian Westphal wrote:
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index d15d64d16136..2b847e079619 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -344,6 +344,38 @@ static int mptcp_sendmsg_frag(struct sock *sk, str=
uct sock *ssk,
> >  	return ret;
> >  }
> >  =

> > +static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> > +{
> > +	struct mptcp_subflow_context *subflow;
> > +	struct sock *backup =3D NULL;
> > +
> > +	sock_owned_by_me((const struct sock *)msk);
> > +
> > +	mptcp_for_each_subflow(msk, subflow) {
> > +		struct sock *ssk =3D mptcp_subflow_tcp_socket(subflow)->sk;
> > +
> > +		if (!sk_stream_is_writeable(ssk)) {
> > +			struct socket *sock =3D ssk->sk_socket;
> > +
> > +			if (sock)
> > +				set_bit(SOCK_NOSPACE, &sock->flags);
> =

> Out of sheer ignorance, why is this required? I thought setting NOSPACE
> was required only before waiting for memory.

Its needed for tcp to call sk->sk_write_space() once the substream
becomes writeable.

> > -	if (!msg_data_left(msg)) {
> > +	if (unlikely(!msg_data_left(msg))) {
> > +		ssk =3D mptcp_subflow_get(msk);
> >  		pr_debug("empty send");
> >  		ret =3D sock_sendmsg(ssk->sk_socket, msg);
> >  		goto out;
> >  	}
> >  =

> > +	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
> > +
> > +	smp_mb__before_atomic();
> > +	clear_bit(MPTCP_SEND_SPACE, &msk->flags);
> > +	smp_mb__after_atomic();
> =

> Perhaps the above lines could be moved just before the
> sk_stream_wait_memory() call below?

you mean

while (!ssk) {
     	clear_bit(MPTCP_SEND_SPACE, &msk->flags);
	ret =3D sk_stream_wait_memory(sk, &timeo);
	...
?
--===============7556881351983929050==--
