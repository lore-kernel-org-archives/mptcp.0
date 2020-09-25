Content-Type: multipart/mixed; boundary="===============8284558817439742334=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 6/8] mptcp: refactor shutdown and close
Date: Fri, 25 Sep 2020 19:02:58 +0200
Message-ID: <1ad5ba55c3e1e32025b83d13ca9ccbe8996505f1.camel@redhat.com>
In-Reply-To: 6ba1cefb2825480dc5b5c3a29a14b63373e44dc6.1600955407.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6045

--===============8284558817439742334==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-09-24 at 15:59 +0200, Paolo Abeni wrote:
> We must not close the subflows before all the MPTCP level
> data, comprising the DATA_FIN has been acked at the MPTCP
> level, otherwise we could be unable to retransmit as needed.
> =

> __mptcp_wr_shutdown() shutdown is responsible to check for the
> correct status and close all subflows. Is called by the output
> path after spooling any data and at shutdown/close time.
> =

> In a similar way, __mptcp_destroy_sock() is responsible to clean-up
> the MPTCP level status, and is called when the msk transition
> to TCP_CLOSE.
> =

> The protocol level close() does not force anymore the TCP_CLOSE
> status, but orphan the msk socket and all the subflows.
> Orphaned msk sockets are forciby closed after a timeout or
> when all MPTCP-level data is acked.
> =

> There is a caveat about keeping the orphaned subflows around:
> the TCP stack can asynchronusly call tcp_cleanup_ulp() on them via
> tcp_close(). To prevent accessing freed memory on later MPTCP
> level operations, the msk acquires a reference to each subflow
> socket and prevent subflow_ulp_release() from releasing the
> subflow context before __mptcp_destroy_sock().
> =

> The additional subflow references are released by __mptcp_done()
> and the async ULP release is detected checking ULP ops. If such
> field has been already cleared by the ULP release path, the
> dangling context is freed directly by __mptcp_done().
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> Note:
> The convoluted ctx deallocation schema fixes the UaF described in:
> =

> https://lists.01.org/hyperkitty/list/mptcp(a)lists.01.org/message/JC7GTZH=
EKI6A3WHQKAWF3SYUSBEU5DYM/
> =

> for me.
> ---
>  net/mptcp/protocol.c | 264 ++++++++++++++++++++++++++++++-----------
> --
>  net/mptcp/protocol.h |   4 +-
>  net/mptcp/subflow.c  |  21 +++-
>  3 files changed, 203 insertions(+), 86 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2b6c704d4505..dec703103398 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -21,6 +21,7 @@
>  #include <net/transp_v6.h>
>  #endif
>  #include <net/mptcp.h>
> +#include <net/xfrm.h>
>  #include "protocol.h"
>  #include "mib.h"
>  =

> @@ -41,6 +42,8 @@ struct mptcp_skb_cb {
>  =

>  static struct percpu_counter mptcp_sockets_allocated;
>  =

> +static void __mptcp_destroy_sock(struct sock *sk, int timeout);
> +
>  /* If msk has an initial subflow socket, and the MP_CAPABLE
> handshake has not
>   * completed yet or has failed, return the subflow socket.
>   * Otherwise return NULL.
> @@ -102,6 +105,7 @@ static int __mptcp_socket_create(struct
> mptcp_sock *msk)
>  	msk->subflow =3D ssock;
>  	subflow =3D mptcp_subflow_ctx(ssock->sk);
>  	list_add(&subflow->node, &msk->conn_list);
> +	sock_hold(ssock->sk);
>  	subflow->request_mptcp =3D 1;
>  =

>  	/* accept() will wait on first subflow sk_wq, and we always
> wakes up
> @@ -313,6 +317,13 @@ static void mptcp_stop_timer(struct sock *sk)
>  	mptcp_sk(sk)->timer_ival =3D 0;
>  }
>  =

> +static bool mptcp_wr_eof(const struct sock *sk)
> +{
> +	return sk->sk_state =3D=3D TCP_FIN_WAIT2 || sk->sk_state =3D=3D
> TCP_TIME_WAIT ||
> +	       sk->sk_state =3D=3D TCP_CLOSE;
> +}
> +
> +/* return true when transitioning to CLOSE state */
>  static void mptcp_check_data_fin_ack(struct sock *sk)
>  {
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
> @@ -331,15 +342,22 @@ static void mptcp_check_data_fin_ack(struct
> sock *sk)
>  		switch (sk->sk_state) {
>  		case TCP_FIN_WAIT1:
>  			inet_sk_state_store(sk, TCP_FIN_WAIT2);
> -			sk->sk_state_change(sk);
>  			break;
>  		case TCP_CLOSING:
> +			inet_sk_state_store(sk, TCP_TIME_WAIT);
> +			break;

I can't use TIME_WAIT here nor later, otherwise sk_fullsock() will be
fooled. Not sure why I did not notice before. I'll use directly
TCP_CLOSE.

Paolo

--===============8284558817439742334==--
