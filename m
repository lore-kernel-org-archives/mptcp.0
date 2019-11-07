Content-Type: multipart/mixed; boundary="===============5713299695706878297=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Add DATA_FIN transmission and handling
Date: Thu, 07 Nov 2019 09:42:02 +0100
Message-ID: <24437d5555d670f9951f375ae6ec7707ff00e33c.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1911061303310.42057@cavianch-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2434

--===============5713299695706878297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-11-06 at 16:37 -0800, Mat Martineau wrote:
> On Wed, 6 Nov 2019, Paolo Abeni wrote:
> > I think we don't need a workqueue here: subflow could simply set
> > (WRITE_ONCE) one/some msk level field[s].
> > =

> > I don't think we need to deal with subflows concurrently writing
> > different values there - it will be a protocol violation, the stream
> > will be corrupted anyway.
> =

> The goal of the workqueue would be to process the DATA_FIN (and ack it if =

> the recv side is caught up) even when there's no pending send/recv from =

> userspace to wake up. That means the subflow error queue wouldn't work =

> either.

I mean: I think we can update msk->incoming_data_fin from
mptcp_incoming_options() even without locking, just using WRITE_ONCE().

Additionally we could use cmpxchg(), if we want detect cuncurrent
modification from multiple subflows, but that looks more a debug
features than a functional requirement to me.

> > [...]
> > > @@ -383,6 +383,13 @@ static int mptcp_sendmsg(struct sock *sk, struct=
 msghdr *msg, size_t len)
> > >  	lock_sock(ssk);
> > >  	mptcp_clean_una(sk);
> > >  	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
> > > +
> > > +	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
> > > +		ret =3D sk_stream_wait_connect(sk, &timeo);
> > > +		if (ret !=3D 0)
> > > +			goto put_out_subflow;
> > > +	}
> > > +
> > >  	while (msg_data_left(msg)) {
> > >  		ret =3D mptcp_sendmsg_frag(sk, ssk, msg, NULL, &timeo, &mss_now,
> > >  					 &size_goal);
> > =

> > I think waiting is not needed here?!? we could just bail out with
> > ENOTCONN if state is >=3D TCP_FIN_WAIT1. Such check could be located
> > before selecting the egress subflow: it should be outside the ssk lock.
> =

> I agree that the sk state check and possible waiting need to happen =

> outside the ssk lock, thank you for spotting that.
> =

> Waiting isn't needed for the states at the end of the connection, but I =

> saw that TCP sendmsg/do_tcp_sendpages verified the connection state prior =

> to sending in this way. =


Uhm... overall this looks a bugfix, perhaps it could be placed into
it's own patch for review's sake...

> What if I move this check very early in the =

> function, before the fallback sock_sendmsg()? If there's an attempt to =

> send before the handshake is done, we don't want to be waiting in the =

> regular TCP sendmsg().

I think you are right, otherwise we use the subflow as fallback, even
if the MP_CAPABLE handshake is still running and will complete
successfully. =


I additionally think we need something similar even for recvmsg(), for
similar reasons

Side note: with v1 MP_CAPABLE we will a similar problem, e.g. we can
start recvmsg() when the MP_CAPABLE handshake is not completed, but the
tcp connection is established (because v1 has a forth MP_CAPABLE
message). In theat scenario we will use the subflow as a MPTCP enabled
one - and block with no data. =


Later the MP_CAPABLE handshake can complete even unsuccessfully, and we
have to fallback to plain TCP, while still waiting in the MPTCP-
specific part of mptcp_recvmsg() - will be fun ;)

Cheers,

Paolo

--===============5713299695706878297==--
