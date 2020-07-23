Content-Type: multipart/mixed; boundary="===============4786529310172491482=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v2 07/12] mptcp: Add helper to process
 acks of DATA_FIN
Date: Thu, 23 Jul 2020 07:27:56 -0700
Message-ID: <20200723142756.GP73500@MacBook-Pro-64.local>
In-Reply-To: 20200723003219.90547-8-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5245

--===============4786529310172491482==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 07/22/20 - 17:32, Mat Martineau wrote:
> After DATA_FIN has been sent, the peer will acknowledge it. An ack of
> the relevant MPTCP-level sequence number will update the MPTCP
> connection state appropriately.
> =

> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---
>  net/mptcp/protocol.c | 54 +++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 46 insertions(+), 8 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index a07a037f8405..468dd9c969ae 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -143,6 +143,14 @@ static void __mptcp_move_skb(struct mptcp_sock *msk,=
 struct sock *ssk,
>  	MPTCP_SKB_CB(skb)->offset =3D offset;
>  }
>  =

> +static void mptcp_stop_timer(struct sock *sk)
> +{
> +	struct inet_connection_sock *icsk =3D inet_csk(sk);
> +
> +	sk_stop_timer(sk, &icsk->icsk_retransmit_timer);
> +	mptcp_sk(sk)->timer_ival =3D 0;
> +}
> +
>  /* both sockets must be locked */
>  static bool mptcp_subflow_dsn_valid(const struct mptcp_sock *msk,
>  				    struct sock *ssk)
> @@ -164,6 +172,42 @@ static bool mptcp_subflow_dsn_valid(const struct mpt=
cp_sock *msk,
>  	return mptcp_subflow_data_available(ssk);
>  }
>  =

> +static void mptcp_check_data_fin_ack(struct sock *sk)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +
> +	if (__mptcp_check_fallback(msk))
> +		return;
> +
> +	/* Look for an acknowledged DATA_FIN */
> +	if (((1 << sk->sk_state) &
> +	    (TCPF_FIN_WAIT1 | TCPF_CLOSING | TCPF_LAST_ACK)) &&
> +	    (msk->write_seq =3D=3D atomic64_read(&msk->snd_una))) {

Another one:

CHECK: Unnecessary parentheses around 'msk->write_seq =3D=3D atomic64_read(=
&msk->snd_una)'
#151: FILE: net/mptcp/protocol.c:183:
+	if (((1 << sk->sk_state) &
+	    (TCPF_FIN_WAIT1 | TCPF_CLOSING | TCPF_LAST_ACK)) &&
+	    (msk->write_seq =3D=3D atomic64_read(&msk->snd_una))) {



Christoph

> +		mptcp_stop_timer(sk);
> +
> +		WRITE_ONCE(msk->snd_data_fin_enable, 0);
> +
> +		switch (sk->sk_state) {
> +		case TCP_FIN_WAIT1:
> +			inet_sk_state_store(sk, TCP_FIN_WAIT2);
> +			sk->sk_state_change(sk);
> +			break;
> +		case TCP_CLOSING:
> +			fallthrough;
> +		case TCP_LAST_ACK:
> +			inet_sk_state_store(sk, TCP_CLOSE);
> +			sk->sk_state_change(sk);
> +			break;
> +		}
> +
> +		if (sk->sk_shutdown =3D=3D SHUTDOWN_MASK ||
> +		    sk->sk_state =3D=3D TCP_CLOSE)
> +			sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_HUP);
> +		else
> +			sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
> +	}
> +}
> +
>  static bool mptcp_pending_data_fin(struct sock *sk, u64* seq)
>  {
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
> @@ -222,6 +266,8 @@ static void mptcp_check_data_fin(struct sock *sk)
>  		WRITE_ONCE(msk->rcv_data_fin, 0);
>  =

>  		sk->sk_shutdown |=3D RCV_SHUTDOWN;
> +		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
> +		set_bit(MPTCP_DATA_READY, &msk->flags);
>  =

>  		switch (sk->sk_state) {
>  		case TCP_ESTABLISHED:
> @@ -455,14 +501,6 @@ static void mptcp_check_for_eof(struct mptcp_sock *m=
sk)
>  	}
>  }
>  =

> -static void mptcp_stop_timer(struct sock *sk)
> -{
> -	struct inet_connection_sock *icsk =3D inet_csk(sk);
> -
> -	sk_stop_timer(sk, &icsk->icsk_retransmit_timer);
> -	mptcp_sk(sk)->timer_ival =3D 0;
> -}
> -
>  static bool mptcp_ext_cache_refill(struct mptcp_sock *msk)
>  {
>  	const struct sock *sk =3D (const struct sock *)msk;
> -- =

> 2.27.0
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
--===============4786529310172491482==--
