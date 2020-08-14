Content-Type: multipart/mixed; boundary="===============2433342712523305361=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: adjust mptcp receive buffer
 limit if subflow has larger one
Date: Fri, 14 Aug 2020 12:58:20 -0700
Message-ID: <alpine.OSX.2.23.453.2008141255470.20141@cakenne1-mobl1.amr.corp.intel.com>
In-Reply-To: 20200813073234.277347-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5558

--===============2433342712523305361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Aug 2020, Florian Westphal wrote:

> In addition to tcp autotuning during read, it may also increase the
> receive buffer in tcp_clamp_window().
>
> In this case, mptcp should adjust its receive buffer size as well so
> it can pull all pending skbs at once.
>
> At this time, when TCP grows its receive buffer, it may have more
> skbs ready for processing than what mptcp allows.
>
> In the mptcp case, the receive window is derived from free
> space of the mptcp parent socket instead of the individual subflows.
> Following the subflow allows mptcp to grow its receive buffer.
>
> This is especially noticable for loopback traffic, when even two
> skbs are enough to fill the initial receive window.
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> net/mptcp/protocol.c | 15 +++++++++++----
> 1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index c800b9147a3c..d9307a3e1e62 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -603,6 +603,7 @@ void mptcp_data_ready(struct sock *sk, struct sock *s=
sk)
> {
> 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> 	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	int sk_rbuf, ssk_rbuf;
> 	bool wake;
>
> 	/* move_skbs_to_msk below can legitly clear the data_avail flag,
> @@ -613,12 +614,18 @@ void mptcp_data_ready(struct sock *sk, struct sock =
*ssk)
> 	if (wake)
> 		set_bit(MPTCP_DATA_READY, &msk->flags);
>
> -	if (atomic_read(&sk->sk_rmem_alloc) < READ_ONCE(sk->sk_rcvbuf) &&
> -	    move_skbs_to_msk(msk, ssk))
> +	sk_rbuf =3D READ_ONCE(sk->sk_rcvbuf);
> +	ssk_rbuf =3D READ_ONCE(ssk->sk_rcvbuf);
> +	if (ssk_rbuf > sk_rbuf) {
> +		WRITE_ONCE(sk->sk_rcvbuf, ssk_rbuf);

Any concern about this racing with updates to sk->sk_rcvbuf assignment =

(with lock held) in mptcp_rcv_space_adjust() or other subflows =

concurrently calling mptcp_data_ready?

> +		sk_rbuf =3D ssk_rbuf;
> +	}
> +
> +	/* over limit? can't append more skbs to msk */
> +	if (atomic_read(&sk->sk_rmem_alloc) > sk_rbuf)
> 		goto wake;
>
> -	/* don't schedule if mptcp sk is (still) over limit */
> -	if (atomic_read(&sk->sk_rmem_alloc) > READ_ONCE(sk->sk_rcvbuf))
> +	if (move_skbs_to_msk(msk, ssk))
> 		goto wake;
>
> 	/* mptcp socket is owned, release_cb should retry */
> -- =

> 2.26.2

--
Mat Martineau
Intel
--===============2433342712523305361==--
