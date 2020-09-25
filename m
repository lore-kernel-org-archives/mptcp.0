Content-Type: multipart/mixed; boundary="===============5738636156900672323=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 6/8] mptcp: refactor shutdown and close
Date: Fri, 25 Sep 2020 19:07:27 +0200
Message-ID: <e5c6714206ac09c07d760646349258345e7cea32.camel@redhat.com>
In-Reply-To: 6ba1cefb2825480dc5b5c3a29a14b63373e44dc6.1600955407.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6046

--===============5738636156900672323==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-09-24 at 15:59 +0200, Paolo Abeni wrote:
> @@ -1946,42 +2024,43 @@ static int mptcp_close_state(struct sock *sk)
>  	return next & TCP_ACTION_FIN;
>  }
>  =

> -static void mptcp_close(struct sock *sk, long timeout)
> +static void __mptcp_wr_shutdown(struct sock *sk)
>  {
> -	struct mptcp_subflow_context *subflow, *tmp;
> +	struct mptcp_subflow_context *subflow;
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
> -	LIST_HEAD(conn_list);
>  =

> -	lock_sock(sk);
> -	sk->sk_shutdown =3D SHUTDOWN_MASK;
> +	pr_debug("msk=3D%p snd_data_fin_enable=3D%d shutdown=3D%x state=3D%d pe=
nding=3D%d",
> +		 msk, msk->snd_data_fin_enable, sk->sk_shutdown, sk->sk_state,
> +		 !!mptcp_send_head(sk));
>  =

> -	if (sk->sk_state =3D=3D TCP_LISTEN) {
> -		inet_sk_state_store(sk, TCP_CLOSE);
> -		goto cleanup;
> -	} else if (sk->sk_state =3D=3D TCP_CLOSE) {
> -		goto cleanup;
> -	}
> +	/* If we've already sent a FIN, we still need to enqueue data to
> +	 * subflows or not really shutting down, skip this
> +	 */
> +	if (msk->snd_data_fin_enable ||
> +	    !(sk->sk_shutdown & SEND_SHUTDOWN) || mptcp_send_head(sk) ||
> +	    (sk->sk_state !=3D TCP_FIN_WAIT1 && sk->sk_state !=3D TCP_LAST_ACK))
> +		return;
>  =

> -	if (__mptcp_check_fallback(msk)) {
> -		goto update_state;
> -	} else if (mptcp_close_state(sk)) {
> -		pr_debug("Sending DATA_FIN sk=3D%p", sk);
> -		WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
> -		WRITE_ONCE(msk->snd_data_fin_enable, 1);
> +	/* will be ignored by fallback sockets */
> +	WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
> +	WRITE_ONCE(msk->snd_data_fin_enable, 1);

Here I need to increment also snd_nxt, or we will drop DATA FIN ack
in ack_update_msk(). Technically this last change could land in a
previous patch, but will be irrelevant till the next one.

/P

--===============5738636156900672323==--
