Content-Type: multipart/mixed; boundary="===============1811390818639159663=="
MIME-Version: 1.0
From: Eric Dumazet <eric.dumazet at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 10/10] mptcp: refine MPTCP-level ack
 scheduling
Date: Mon, 23 Nov 2020 12:57:17 +0100
Message-ID: <ca0b65f8-7a69-ff4e-9e0d-66a7a923b0c1@gmail.com>
In-Reply-To: 20201119194603.103158-11-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6894

--===============1811390818639159663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 11/19/20 8:46 PM, Mat Martineau wrote:
> From: Paolo Abeni <pabeni(a)redhat.com>
> =

> Send timely MPTCP-level ack is somewhat difficult when
> the insertion into the msk receive level is performed
> by the worker.
> =

> It needs TCP-level dup-ack to notify the MPTCP-level
> ack_seq increase, as both the TCP-level ack seq and the
> rcv window are unchanged.
> =

> We can actually avoid processing incoming data with the
> worker, and let the subflow or recevmsg() send ack as needed.
> =

> When recvmsg() moves the skbs inside the msk receive queue,
> the msk space is still unchanged, so tcp_cleanup_rbuf() could
> end-up skipping TCP-level ack generation. Anyway, when
> __mptcp_move_skbs() is invoked, a known amount of bytes is
> going to be consumed soon: we update rcv wnd computation taking
> them in account.
> =

> Additionally we need to explicitly trigger tcp_cleanup_rbuf()
> when recvmsg() consumes a significant amount of the receive buffer.
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---
>  net/mptcp/options.c  |   1 +
>  net/mptcp/protocol.c | 105 +++++++++++++++++++++----------------------
>  net/mptcp/protocol.h |   8 ++++
>  net/mptcp/subflow.c  |   4 +-
>  4 files changed, 61 insertions(+), 57 deletions(-)
> =

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 248e3930c0cb..8a59b3e44599 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -530,6 +530,7 @@ static bool mptcp_established_options_dss(struct sock=
 *sk, struct sk_buff *skb,
>  		opts->ext_copy.ack64 =3D 0;
>  	}
>  	opts->ext_copy.use_ack =3D 1;
> +	WRITE_ONCE(msk->old_wspace, __mptcp_space((struct sock *)msk));
>  =

>  	/* Add kind/length/subtype/flag overhead if mapping is not populated */
>  	if (dss_size =3D=3D 0)
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 4ae2c4a30e44..748343f1a968 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -407,16 +407,42 @@ static void mptcp_set_timeout(const struct sock *sk=
, const struct sock *ssk)
>  	mptcp_sk(sk)->timer_ival =3D tout > 0 ? tout : TCP_RTO_MIN;
>  }
>  =

> -static void mptcp_send_ack(struct mptcp_sock *msk)
> +static bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
> +{
> +	struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> +
> +	/* can't send if JOIN hasn't completed yet (i.e. is usable for mptcp) */
> +	if (subflow->request_join && !subflow->fully_established)
> +		return false;
> +
> +	/* only send if our side has not closed yet */
> +	return ((1 << ssk->sk_state) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT));
> +}
> +
> +static void mptcp_send_ack(struct mptcp_sock *msk, bool force)
>  {
>  	struct mptcp_subflow_context *subflow;
> +	struct sock *pick =3D NULL;
>  =

>  	mptcp_for_each_subflow(msk, subflow) {
>  		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
>  =

> -		lock_sock(ssk);
> -		tcp_send_ack(ssk);
> -		release_sock(ssk);
> +		if (force) {
> +			lock_sock(ssk);
> +			tcp_send_ack(ssk);
> +			release_sock(ssk);
> +			continue;
> +		}
> +
> +		/* if the hintes ssk is still active, use it */
> +		pick =3D ssk;
> +		if (ssk =3D=3D msk->ack_hint)
> +			break;
> +	}
> +	if (!force && pick) {
> +		lock_sock(pick);
> +		tcp_cleanup_rbuf(pick, 1);

Calling tcp_cleanup_rbuf() on a socket that was never established is going =
to fail
with a divide by 0 (mss being 0)

AFAIK, mptcp_recvmsg() can be called right after a socket(AF_INET, SOCK_STR=
EAM, IPPROTO_MPTCP)
call.

Probably, after a lock_sock(), you should double check socket state (same a=
bove before calling tcp_send_ack())



> +		release_sock(pick);
>  	}
>  }
>  =



....

>  =

> +		/* be sure to advertise window change */
> +		old_space =3D READ_ONCE(msk->old_wspace);
> +		if ((tcp_space(sk) - old_space) >=3D old_space)
> +			mptcp_send_ack(msk, false);
> +

Yes, if we call recvmsg() right after socket(), we will end up calling tcp_=
cleanup_rbuf(),
while no byte was ever copied/drained.

--===============1811390818639159663==--
