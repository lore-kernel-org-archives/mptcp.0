Content-Type: multipart/mixed; boundary="===============5996063357118660320=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: only orphan partially subflow at close time
Date: Thu, 12 Dec 2019 18:03:50 +0100
Message-ID: <9bca4459065bc1802c537be26087eea54c052453.camel@redhat.com>
In-Reply-To: 20191212161639.GN795@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 2891

--===============5996063357118660320==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-12-12 at 17:16 +0100, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > This close the following race
> > =

> > CPU 0				CPU 1
> > sock_orphan()
> > 	// SOCK_DEAD
> > 				tcp_done()
> > 					inet_csk_destroy_sock()
> > 						sock_put()
> > =

> > tcp_close()
> > 	// UAF
> > =

> > Note that we can't simply acquire an additional ref to the
> > sock before sock_orphan() and releasing it after close,
> > such ref will be consumed by inet_csk_destroy_sock when
> > the race is triggered.
> > =

> > Squash-to: "mptcp: Handle MP_CAPABLE options for outgoing connections"
> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > ---
> >  net/mptcp/protocol.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > =

> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 9506e04a2010..24d68e504e9c 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -178,8 +178,16 @@ static void __mptcp_close_ssk(struct sock *sk, str=
uct sock *ssk,
> >  		/* outgoing subflow */
> >  		sock_release(sock);
> >  	} else {
> > -		/* incoming subflow */
> > -		sock_orphan(ssk);
> > +		/* This is an incoming subflow. We almost orphan it,
> > +		 * but do not mark has death, otherwise inet_csk_destroy_sock
> > +		 * may kick-in via tcp_done() and steal one reference
> > +		 * before tcp_close below.
> > +		 */
> > +		write_lock_bh(&sk->sk_callback_lock);
> > +		sk_set_socket(sk, NULL);
> > +		sk->sk_wq  =3D NULL;
> > +		write_unlock_bh(&sk->sk_callback_lock);
> > +
> =

> Hmm, I wonder if we can't just remove sock_orphan()?

I overlooked at the need for orphans - is great that the TCP stack does
not need such bad thing ;)

I'm testing a simpler patch, hopefully I will post it soon.

/P

--===============5996063357118660320==--
