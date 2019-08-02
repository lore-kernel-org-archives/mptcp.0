Content-Type: multipart/mixed; boundary="===============3687050597440040917=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2 02/10] Fix locking in mptcp_finish_join.
Date: Fri, 02 Aug 2019 16:06:27 +0200
Message-ID: <312c87ca38a7c69e218c341ceb0ba454353cc9c3.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1908011749410.6574@tmdiggs-mobl2.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1578

--===============3687050597440040917==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-01 at 17:56 -0700, Mat Martineau wrote:
> On Thu, 25 Jul 2019, Peter Krystad wrote:
> =

> > Lock was being taken on the subflow sock, not mptcp_sock.
> > =

> > squashto:  Add handling of incoming MP_JOIN requests
> > =

> > Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> > ---
> > net/mptcp/protocol.c | 9 +++++----
> > net/mptcp/protocol.h | 2 +-
> > net/mptcp/subflow.c  | 2 +-
> > 3 files changed, 7 insertions(+), 6 deletions(-)
> > =

> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 5501c405c6e0..8a841d489b52 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -816,18 +816,19 @@ void mptcp_finish_connect(struct sock *sk, int mp=
_capable)
> > 	inet_sk_state_store(sk, TCP_ESTABLISHED);
> > }
> > =

> > -void mptcp_finish_join(struct sock *conn, struct sock *sk)
> > +void mptcp_finish_join(struct sock *sk)
> > {
> > 	struct subflow_context *subflow =3D subflow_ctx(sk);
> > -	struct mptcp_sock *msk =3D mptcp_sk(conn);
> > +	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> > =

> > 	pr_debug("msk=3D%p, subflow=3D%p", msk, subflow);
> > =

> > 	local_bh_disable();
> > -	bh_lock_sock_nested(sk);
> > +	bh_lock_sock_nested(subflow->conn);
> > 	list_add_tail(&subflow->node, &msk->conn_list);
> > -	bh_unlock_sock(sk);
> > +	bh_unlock_sock(subflow->conn);
> =

> This is the sort of locking I'm getting deadlock warnings for in my =

> mptcp-level data_ready function (patch that tries to fix the MPTCP socket =

> wakeup problem). The selftest didn't trigger the lock warning for me, but =

> it doesn't do any joins yet! I didn't get a chance to test against the =

> multipath-tcp.org kernel yet.

I *think* this specific inversion in lock acquisition order should be
safe, for the same reason the one mptcp_finish_connect().

Generally speaking each inversion in lock acquisition order done to
just insert the subflow socket into the connected socket list should be
safe.

> This function reverses the order of lock acquisition (locks the mptcp =

> socket second), so it could deadlock. How we solve this is part of our =

> larger locking discussion so I don't have a solution to give here :)

Lately I'm thinking that using a new, third spinlock to protect
connection level shared datas - among them the connection list - could
simplify the code a bit.

But that would be for later work, I think this patch is good as is.

/P


--===============3687050597440040917==--
