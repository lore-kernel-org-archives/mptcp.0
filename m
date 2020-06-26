Content-Type: multipart/mixed; boundary="===============5275778355871720515=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "net: mptcp: improve fallback to TCP"
Date: Fri, 26 Jun 2020 09:17:16 -0700
Message-ID: <alpine.OSX.2.23.453.2006260916580.66996@redsall-mobl2.amr.corp.intel.com>
In-Reply-To: 95262bb3dfcddcfe670fef5af0290b429df67e35.1593170557.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4820

--===============5275778355871720515==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 26 Jun 2020, Paolo Abeni wrote:

> This fixes blocking accept() never waking-up.
>
> When blocking, mptcp_stream_accept() calls into:
> ssock->ops->acceptk -> ssock->sk->sk_prot->accept ->
> inet_csk_accept() -> inet_csk_wait_for_connect(),
>
> which in turns waits on ssock->sk->sk_wq, while
> all signaling how happens on sock->sk->sk_wq.
>
> Since we ssock->sk->sk_wq is never used otherwise,
> just copy sock->sk->sk_wq into it at first subflow
> creatin time.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 4d6d35e99d0f..5ae8952189d2 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -128,6 +128,10 @@ static struct socket *__mptcp_socket_create(struct m=
ptcp_sock *msk, int state)
> 	list_add(&subflow->node, &msk->conn_list);
> 	subflow->request_mptcp =3D 1;
>
> +	/* accept() will wait on first subflow sk_wq, and we always wakes up
> +	 * via msk->sk_socket */
> +	RCU_INIT_POINTER(msk->first->sk_wq, &sk->sk_socket->wq);
> +
> set_state:
> 	if (state !=3D MPTCP_SAME_STATE)
> 		inet_sk_state_store(sk, state);
> -- =

> 2.26.2

This fixes the problem for me - thanks Paolo!

--
Mat Martineau
Intel
--===============5275778355871720515==--
