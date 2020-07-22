Content-Type: multipart/mixed; boundary="===============8988563279442784004=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 07/12] mptcp: Send DATA_FIN in
 appropriate states during shutdown or close
Date: Wed, 22 Jul 2020 15:22:42 -0700
Message-ID: <20200722222242.GM73500@MacBook-Pro-64.local>
In-Reply-To: e3c85bd8458cf859480524382617bd90258282a2.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5184

--===============8988563279442784004==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 07/22/20 - 19:37, Paolo Abeni wrote:
> On Wed, 2020-07-15 at 17:20 -0700, Mat Martineau wrote:
> > mptcp_shutdown now sends DATA_FIN on the subflows without shutting the
> > subflows themselves down. The subflows need to stay connected while
> > DATA_FIN is acked or possibly retransmitted.
> > =

> > mptcp_close should only send DATA_FIN if the MPTCP-level connection
> > state requires it.
> > =

> > Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> > ---
> >  net/mptcp/protocol.c | 44 ++++++++++++++++++++++++++++++++------------
> >  1 file changed, 32 insertions(+), 12 deletions(-)
> > =

> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 2a93976fdb58..9eef1fbe300b 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -1512,7 +1512,7 @@ static void mptcp_cancel_work(struct sock *sk)
> >  		sock_put(sk);
> >  }
> >  =

> > -static void mptcp_subflow_shutdown(struct sock *ssk, int how)
> > +static void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, =
int how)
> >  {
> >  	lock_sock(ssk);
> >  =

> > @@ -1525,8 +1525,8 @@ static void mptcp_subflow_shutdown(struct sock *s=
sk, int how)
> >  		tcp_disconnect(ssk, O_NONBLOCK);
> >  		break;
> >  	default:
> > -		ssk->sk_shutdown |=3D how;
> > -		tcp_shutdown(ssk, how);
> > +		mptcp_set_timeout(sk, ssk);
> > +		tcp_send_ack(ssk);
> >  		break;
> >  	}
> >  =

> > @@ -1565,9 +1565,11 @@ static void mptcp_close(struct sock *sk, long ti=
meout)
> >  	struct mptcp_subflow_context *subflow, *tmp;
> >  	struct mptcp_sock *msk =3D mptcp_sk(sk);
> >  	LIST_HEAD(conn_list);
> > +	int prev_state;
> >  =

> >  	lock_sock(sk);
> >  =

> > +	prev_state =3D sk->sk_state;
> >  	inet_sk_state_store(sk, TCP_CLOSE);
> >  =

> >  	/* be sure to always acquire the join list lock, to sync vs
> > @@ -1578,7 +1580,15 @@ static void mptcp_close(struct sock *sk, long ti=
meout)
> >  	spin_unlock_bh(&msk->join_list_lock);
> >  	list_splice_init(&msk->conn_list, &conn_list);
> >  =

> > -	msk->snd_data_fin_enable =3D 1;
> > +	if ((1 << prev_state) &
> > +	    (TCPF_ESTABLISHED | TCPF_SYN_SENT |
> > +	     TCPF_SYN_RECV | TCPF_CLOSE_WAIT)) {
> > +		WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
> > +		WRITE_ONCE(msk->snd_data_fin_enable, 1);
> > +	} else {
> > +		/* DATA_FIN has already been sent in other states */
> > +		WRITE_ONCE(msk->snd_data_fin_enable, 0);
> > +	}
> >  =

> >  	__mptcp_clear_xmit(sk);
> >  =

> > @@ -2263,11 +2273,8 @@ static int mptcp_shutdown(struct socket *sock, i=
nt how)
> >  	pr_debug("sk=3D%p, how=3D%d", msk, how);
> >  =

> >  	lock_sock(sock->sk);
> > -	if (how =3D=3D SHUT_WR || how =3D=3D SHUT_RDWR)
> > -		inet_sk_state_store(sock->sk, TCP_FIN_WAIT1);
> >  =

> >  	how++;
> > -
> >  	if ((how & ~SHUTDOWN_MASK) || !how) {
> >  		ret =3D -EINVAL;
> >  		goto out_unlock;
> > @@ -2281,13 +2288,26 @@ static int mptcp_shutdown(struct socket *sock, =
int how)
> >  			sock->state =3D SS_CONNECTED;
> >  	}
> >  =

> > -	__mptcp_flush_join_list(msk);
> > -	msk->snd_data_fin_enable =3D 1;
> > +	/* If we've already sent a FIN, or it's a closed state, skip this. */
> > +	if ((how & SEND_SHUTDOWN) &&
> > +	    ((1 << sock->sk->sk_state) &
> > +	     (TCPF_ESTABLISHED | TCPF_SYN_SENT |
> > +	      TCPF_SYN_RECV | TCPF_CLOSE_WAIT))) {
> >  =

> > -	mptcp_for_each_subflow(msk, subflow) {
> > -		struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
> > +		if (mptcp_close_state(sock->sk)) {
> > +			__mptcp_flush_join_list(msk);
> >  =

> > -		mptcp_subflow_shutdown(tcp_sk, how);
> > +			WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
> > +			WRITE_ONCE(msk->snd_data_fin_enable, 1);
> > +
> > +			mptcp_for_each_subflow(msk, subflow) {
> > +				struct sock *tcp_sk;
> > +
> > +				tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
> > +
> > +				mptcp_subflow_shutdown(sock->sk, tcp_sk, how);
> > +			}
> > +		}
> =

> I just notice the above is problematic in case we are using multiple
> subflows for xmit, and we need reinjection after mptcp level
> shutdown(SEND_SHUTDOWN).
> =

> Since each subflow is closed for sending, we can't reinject the data...
> =

> @Christoph does mptcp.org handle the above scenario in some specific

The RFC says:

   It is only permissible to combine these signals on one subflow if there =
is
   no data outstanding on other subflows.  Otherwise, it may be
   necessary to retransmit data on different subflows.  Essentially, a
   host MUST NOT close all functioning subflows unless it is safe to do
   so, i.e., until all outstanding data has been DATA_ACKed or until the
   segment with the DATA_FIN flag set is the only outstanding segment.

So, in mptcp.org, we tag the DATA_FIN along with a FIN only if the segment
being sent is the last segment of the MPTCP send-queue. Unless that, we
never set the FIN-flag on a subflow and only close the subflows after the
DATA_FIN has been DATA_ACK'd.


Christoph



> way?
> =

> Thanks!
> =

> /P
>=20
--===============8988563279442784004==--
