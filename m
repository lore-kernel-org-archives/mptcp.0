Content-Type: multipart/mixed; boundary="===============2521818656257051588=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 10/10] mptcp: refine MPTCP-level ack
 scheduling
Date: Mon, 23 Nov 2020 15:21:03 +0100
Message-ID: <88ac6b9ddbdc6cf825ac3d7f65c9e0ee7f5cadd9.camel@redhat.com>
In-Reply-To: ca0b65f8-7a69-ff4e-9e0d-66a7a923b0c1@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6895

--===============2521818656257051588==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 2020-11-23 at 12:57 +0100, Eric Dumazet wrote:
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 4ae2c4a30e44..748343f1a968 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -407,16 +407,42 @@ static void mptcp_set_timeout(const struct sock *=
sk, const struct sock *ssk)
> >  	mptcp_sk(sk)->timer_ival =3D tout > 0 ? tout : TCP_RTO_MIN;
> >  }
> >  =

> > -static void mptcp_send_ack(struct mptcp_sock *msk)
> > +static bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
> > +{
> > +	struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> > +
> > +	/* can't send if JOIN hasn't completed yet (i.e. is usable for mptcp)=
 */
> > +	if (subflow->request_join && !subflow->fully_established)
> > +		return false;
> > +
> > +	/* only send if our side has not closed yet */
> > +	return ((1 << ssk->sk_state) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT));
> > +}
> > +
> > +static void mptcp_send_ack(struct mptcp_sock *msk, bool force)
> >  {
> >  	struct mptcp_subflow_context *subflow;
> > +	struct sock *pick =3D NULL;
> >  =

> >  	mptcp_for_each_subflow(msk, subflow) {
> >  		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> >  =

> > -		lock_sock(ssk);
> > -		tcp_send_ack(ssk);
> > -		release_sock(ssk);
> > +		if (force) {
> > +			lock_sock(ssk);
> > +			tcp_send_ack(ssk);
> > +			release_sock(ssk);
> > +			continue;
> > +		}
> > +
> > +		/* if the hintes ssk is still active, use it */
> > +		pick =3D ssk;
> > +		if (ssk =3D=3D msk->ack_hint)
> > +			break;
> > +	}
> > +	if (!force && pick) {
> > +		lock_sock(pick);
> > +		tcp_cleanup_rbuf(pick, 1);
> =

> Calling tcp_cleanup_rbuf() on a socket that was never established is goin=
g to fail
> with a divide by 0 (mss being 0)
> =

> AFAIK, mptcp_recvmsg() can be called right after a socket(AF_INET, SOCK_S=
TREAM, IPPROTO_MPTCP)
> call.
> =

> Probably, after a lock_sock(), you should double check socket state (same=
 above before calling tcp_send_ack())

Thank you for looking into this.

Indeed you are right! I'll try to cook a fix.

Cheers,

Paolo

--===============2521818656257051588==--
