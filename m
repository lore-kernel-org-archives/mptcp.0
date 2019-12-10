Content-Type: multipart/mixed; boundary="===============2586848784653584705=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 2/4] imptcp: cleanup fallback handling
Date: Tue, 10 Dec 2019 15:18:13 +0100
Message-ID: <b6a7eee20776b33615a39b2607919e4e019b4ba6.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1912091815380.11558@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 2857

--===============2586848784653584705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-12-09 at 18:28 -0800, Mat Martineau wrote:
> On Mon, 9 Dec 2019, Mat Martineau wrote:
> =

> > On Tue, 10 Dec 2019, Paolo Abeni wrote:
> =

> ...
> > > @@ -962,11 +994,15 @@ static int mptcp_listen(struct socket *sock, in=
t =

> > > backlog)
> > > =

> > > 	pr_debug("msk=3D%p", msk);
> > > =

> > > -	ssock =3D mptcp_socket_create_get(msk);
> > > +	ssock =3D mptcp_socket_create_get(msk, TCP_LISTEN);
> > > 	if (IS_ERR(ssock))
> > > 		return PTR_ERR(ssock);
> > > =

> > > 	err =3D ssock->ops->listen(ssock, backlog);
> > > +
> > > +	/* should we keep msk socket lock instead? and release it this
> > > +	 * latter state update */
> > =

> > Same locking comment as mptcp_stream_connect above, and same caveat =

> > concerning patch 4 and squashing.
> > =

> > Other than these two functions, locking looks ok.
> > =

> > =

> > Mat
> > =

> > =

> > > +	inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
> > > 	sock_put(ssock->sk);
> > > 	return err;
> > > }
> > > @@ -985,13 +1021,20 @@ static int mptcp_stream_accept(struct socket *=
sock, =

> > > struct socket *newsock,
> > > {
> > > 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
> > > 	struct socket *ssock;
> > > -	int err;
> > > +	int err =3D -EINVAL;
> > > =

> > > 	pr_debug("msk=3D%p", msk);
> > > =

> > > -	ssock =3D mptcp_fallback_get_ref(msk);
> > > +	lock_sock(sock->sk);
> > > +	if (sock->sk->sk_state !=3D TCP_LISTEN)
> > > +		goto unlock_fail;
> > > +
> > > +	ssock =3D __mptcp_nmpc_socket(msk);
> > > 	if (!ssock)
> > > -		return -EINVAL;
> > > +		goto unlock_fail;
> > > +
> > > +	sock_hold(ssock->sk);
> > > +	release_sock(sock->sk);
> > > =

> > > 	err =3D ssock->ops->accept(sock, newsock, flags, kern);
> > > 	if (err =3D=3D 0 && !is_tcp_proto(newsock->sk->sk_prot)) {
> =

> I did just say "locking looks ok", but just below this is some iteration =

> over msk->conn_list without the msk lock held. The locking there is =

> unaffected by your patch, but this might be a good chance to take a look =

> at the locking around that list iteration!

Thank you for the feedback! I'll cope in the next iteration.

The lockless access to msk->conn_list requires a bit more changes, I'm
unsure I can deal with that in a timely manner. I'll try. =


Idea would be  dropping the intermendiate inet_accept() call and open-
code part of it, so we don't have to acquire and release the locks
multiple times.

Would it fit you if the above lands in a later patch?

Thanks!

Paolo

--===============2586848784653584705==--
