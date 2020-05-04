Content-Type: multipart/mixed; boundary="===============1729863049431435622=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: SYN/ACK+MP_JOIN keeps getting retransmitted
Date: Mon, 04 May 2020 09:36:30 -0700
Message-ID: <20200504163630.GA33923@MacBook-Pro-64.local>
In-Reply-To: cfe42a3d900474e650896cbc7b1ebecf761a81cf.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4308

--===============1729863049431435622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 02/05/20 - 09:30:43, Paolo Abeni wrote:
> Hi,
> =

> On Fri, 2020-05-01 at 11:09 -0700, Christoph Paasch wrote:
> > while testing forked MPTCP as client and upstream MPTCP as server and o=
ne
> > forgets to set the max_subflow limit with iproute, I end up having a
> > scenario where SYN+MP_JOIN is followed by SYN/ACK+MP_JOIN followed by t=
he
> > ACK+MP_JOIN, which then gets RST by the server.
> > =

> > This makes for a weird packet-trace:
> > 16:48:01.626118 IP 10.1.3.1.35561 > 10.2.1.1.5001: Flags [S], seq 32677=
01968, win 42340, options [mss 1460,sackOK,TS val 1457348237 ecr 0,nop,wsca=
le 7,mptcp join id 4 token 0x8e133996 nonce 0xee4ce80a], length 0
> > 16:48:01.626163 IP 10.2.1.1.5001 > 10.1.3.1.35561: Flags [S.], seq 2603=
10350, ack 3267701969, win 43440, options [mss 1460,sackOK,TS val 391670343=
7 ecr 1457348237,nop,wscale 7,mptcp join id 0 hmac 0x30e5a618ce852835 nonce=
 0x3238ac63], length 0
> > 16:48:01.626411 IP 10.1.3.1.35561 > 10.2.1.1.5001: Flags [.], ack 1, wi=
n 991, options [nop,nop,TS val 1457348238 ecr 3916703437,mptcp join hmac 0x=
5c9f67595a7c0f15e72b8d45d2abe73de3a86bf8], length 0
> > 16:48:01.626427 IP 10.2.1.1.5001 > 10.1.3.1.35561: Flags [R.], seq 1, a=
ck 1, win 340, options [nop,nop,TS val 3916703438 ecr 1457348238,mptcp dss =
ack 7475064947213107918], length 0
> > ^^^
> > Server kills the connection -> this is because subflow_syn_recv_sock do=
es
> > the goto close_child and will return NULL to tcp_check_req
> > =

> > 16:48:02.653269 IP 10.2.1.1.5001 > 10.1.3.1.35561: Flags [S.], seq 2603=
10350, ack 3267701969, win 43440, options [mss 1460,sackOK,TS val 391670446=
4 ecr 1457348238,nop,wscale 7,mptcp join id 0 hmac 0x30e5a618ce852835 nonce=
 0x3238ac63], length 0
> > ^^^
> > But, server keeps on retransmitting the SYN/ACK, which happens because
> > tcp_check_req did not remove the request-socket after subflow_syn_recv_=
sock
> > returned NULL
> > =

> > 16:48:02.653692 IP 10.1.3.1.35561 > 10.2.1.1.5001: Flags [R], seq 32677=
01969, win 0, length 0
> > ^^^
> > This time, the client will send the RST because of the previous RST fro=
m the
> > server
> > =

> > =

> > 16:48:04.701270 IP 10.2.1.1.5001 > 10.1.3.1.35561: Flags [S.], seq 2603=
10350, ack 3267701969, win 43440, options [mss 1460,sackOK,TS val 391670651=
2 ecr 1457348238,nop,wscale 7,mptcp join id 0 hmac 0x30e5a618ce852835 nonce=
 0x3238ac63], length 0
> > 16:48:04.701707 IP 10.1.3.1.35561 > 10.2.1.1.5001: Flags [R], seq 32677=
01969, win 0, length 0
> > ^^^
> > And server keeps on retransmitting the SYN/ACK until things time out.
> > =

> > =

> > I think we should move the subflow-count check to the SYN+MP_JOIN recep=
tion
> > =C3=A0 la:
> > =

> > -------
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index e1f23016ed3f..adddf2da5dcc 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -1611,7 +1611,6 @@ bool mptcp_finish_join(struct sock *sk)
> >  	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> >  	struct sock *parent =3D (void *)msk;
> >  	struct socket *parent_sock;
> > -	bool ret;
> > =

> >  	pr_debug("msk=3D%p, subflow=3D%p", msk, subflow);
> > =

> > @@ -1627,15 +1626,12 @@ bool mptcp_finish_join(struct sock *sk)
> >  	if (parent_sock && !sk->sk_socket)
> >  		mptcp_sock_graft(sk, parent_sock);
> > =

> > -	ret =3D mptcp_pm_allow_new_subflow(msk);
> > -	if (ret) {
> > -		/* active connections are already on conn_list */
> > -		spin_lock_bh(&msk->join_list_lock);
> > -		if (!WARN_ON_ONCE(!list_empty(&subflow->node)))
> > -			list_add_tail(&subflow->node, &msk->join_list);
> > -		spin_unlock_bh(&msk->join_list_lock);
> > -	}
> > -	return ret;
> > +	/* active connections are already on conn_list */
> > +	spin_lock_bh(&msk->join_list_lock);
> > +	if (!WARN_ON_ONCE(!list_empty(&subflow->node)))
> > +		list_add_tail(&subflow->node, &msk->join_list);
> > +	spin_unlock_bh(&msk->join_list_lock);
> > +	return true;
> >  }
> > =

> >  bool mptcp_sk_is_subflow(const struct sock *sk)
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 009d5c478062..0684bfc42f88 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -99,6 +99,10 @@ static bool subflow_token_join_request(struct reques=
t_sock *req,
> >  		return false;
> >  	}
> > =

> > +	if (!mptcp_pm_allow_new_subflow(msk)) {
> > +		return false;
> > +	}
> > +
> >  	local_id =3D mptcp_pm_get_local_id(msk, (struct sock_common *)req);
> >  	if (local_id < 0) {
> >  		sock_put((struct sock *)msk);
> > =

> > =

> > =

> > Thoughts?
> > =

> > This is not going to trigger a RST from the server (see comment in
> > subflow_init_req, because we are not passing up a return-value from ini=
t_req
> > to tcp_conn_request - but that should be easy to change).
> =

> Thank you for the detailed analisys! LGTM, with a couple of notes:
> =

> - I think it would be nicer if we additionally decreases the subflows
> if the mp_join request sk 'fails'/fallback before completing the 3WHS

regarding decrease - I saw that and actually was surprised that we *never*
decrease the subflow-counter (at least, I couldn't find where it is being
decremented).

Was that intended? Because, that means if I set max_subflows to 3 and even =
if
I only ever have 2 subflows in parallel, after the third subflow I am block=
ed.

> - we should cope better with failures when processing incoming mp_join
> syn-ack - e.g. dropping the req socket. =


These failures should be fairly easy to repro with packetdrill.
E.g., the state-check in finish_join.

But, looking at removing the request-sock upon failure in
subflow_syn_recv_sock(). That looks tricky to me because we would need to
somehow tell tcp_check_req() whether or not to continue processing.

Looking at DCCP, which seems to have some kind of activation of features
requested during the handshake - it also just seems to return NULL without
killing the request-sock.


Would it make sense to rather do the validity-checks (e.g., correctness of
hmac) in tcp_check_req where it is easy to fail the request-sock ?

> The latter scenario will be IMHO very difficult to test without the bug
> you outline here, so perhaps we can [try to] fix them in reverse order?
> =

> Thanks!
> =

> Paolo
> =

> p.s. could you please share the out-of-tree v1 code - even on a
> devel/test/experimental branch?

Yes, I just published them on mptcp-dev. They apply on top of mptcp_trunk.


Christoph

--===============1729863049431435622==--
