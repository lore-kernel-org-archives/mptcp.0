Content-Type: multipart/mixed; boundary="===============0536847156600404803=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 6/9] mptcp: refactor shutdown and close
Date: Mon, 28 Sep 2020 18:08:24 -0700
Message-ID: <alpine.OSX.2.23.453.2009281737370.6674@kemeng-mobl1.amr.corp.intel.com>
In-Reply-To: c877db9bf5e3433e5cf126d36ba5ef83033ab82c.1601304622.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6087

--===============0536847156600404803==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Sep 2020, Paolo Abeni wrote:

> We must not close the subflows before all the MPTCP level
> data, comprising the DATA_FIN has been acked at the MPTCP
> level, otherwise we could be unable to retransmit as needed.
>
> __mptcp_wr_shutdown() shutdown is responsible to check for the
> correct status and close all subflows. Is called by the output
> path after spooling any data and at shutdown/close time.
>
> In a similar way, __mptcp_destroy_sock() is responsible to clean-up
> the MPTCP level status, and is called when the msk transition
> to TCP_CLOSE.
>
> The protocol level close() does not force anymore the TCP_CLOSE
> status, but orphan the msk socket and all the subflows.
> Orphaned msk sockets are forciby closed after a timeout or
> when all MPTCP-level data is acked.
>
> There is a caveat about keeping the orphaned subflows around:
> the TCP stack can asynchronusly call tcp_cleanup_ulp() on them via
> tcp_close(). To prevent accessing freed memory on later MPTCP
> level operations, the msk acquires a reference to each subflow
> socket and prevent subflow_ulp_release() from releasing the
> subflow context before __mptcp_destroy_sock().
>
> The additional subflow references are released by __mptcp_done()
> and the async ULP release is detected checking ULP ops. If such
> field has been already cleared by the ULP release path, the
> dangling context is freed directly by __mptcp_done().
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> RFC -> v1:
> - drop TCP_TIME_WAIT status, we can't use it or will foul sk_fullsock()
> - refactor wr_shutdown, now split in 2 parts. DATA_FIN is sent
>   by __mptcp_check_send_data_fin() when snd_nxt + 1 =3D=3D write_seq
> - drop mptcp_wr_eof(), simply check for TCP_CLOSE state - Mat
> - do send data fin ack in TCP_FIN_WAIT2 state  (return; -> break; in
>   switch statement)
> ---
> net/mptcp/options.c  |   2 +-
> net/mptcp/protocol.c | 264 ++++++++++++++++++++++++++++++-------------
> net/mptcp/protocol.h |  10 +-
> net/mptcp/subflow.c  |  21 +++-
> 4 files changed, 212 insertions(+), 85 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index d2d8ac45bee1..3b9f7b2e706e 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -491,7 +491,7 @@ static bool mptcp_established_options_dss(struct sock=
 *sk, struct sk_buff *skb,
> 	bool ret =3D false;
>
> 	mpext =3D skb ? mptcp_get_ext(skb) : NULL;
> -	snd_data_fin_enable =3D READ_ONCE(msk->snd_data_fin_enable);
> +	snd_data_fin_enable =3D mptcp_data_fin_enabled(msk);
>
> 	if (!skb || (mpext && mpext->use_map) || snd_data_fin_enable) {
> 		unsigned int map_size;
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2b6c704d4505..207a618e6da9 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -21,6 +21,7 @@
> #include <net/transp_v6.h>
> #endif
> #include <net/mptcp.h>
> +#include <net/xfrm.h>
> #include "protocol.h"
> #include "mib.h"
>
> @@ -41,6 +42,8 @@ struct mptcp_skb_cb {
>
> static struct percpu_counter mptcp_sockets_allocated;
>
> +static void __mptcp_destroy_sock(struct sock *sk, int timeout);
> +
> /* If msk has an initial subflow socket, and the MP_CAPABLE handshake has=
 not
>  * completed yet or has failed, return the subflow socket.
>  * Otherwise return NULL.
> @@ -102,6 +105,7 @@ static int __mptcp_socket_create(struct mptcp_sock *m=
sk)
> 	msk->subflow =3D ssock;
> 	subflow =3D mptcp_subflow_ctx(ssock->sk);
> 	list_add(&subflow->node, &msk->conn_list);
> +	sock_hold(ssock->sk);
> 	subflow->request_mptcp =3D 1;
>
> 	/* accept() will wait on first subflow sk_wq, and we always wakes up
> @@ -313,6 +317,7 @@ static void mptcp_stop_timer(struct sock *sk)
> 	mptcp_sk(sk)->timer_ival =3D 0;
> }
>
> +/* return true when transitioning to CLOSE state */

Outdated comment? Function returns void.

> static void mptcp_check_data_fin_ack(struct sock *sk)
> {
> 	struct mptcp_sock *msk =3D mptcp_sk(sk);
> @@ -331,15 +336,20 @@ static void mptcp_check_data_fin_ack(struct sock *s=
k)
> 		switch (sk->sk_state) {
> 		case TCP_FIN_WAIT1:
> 			inet_sk_state_store(sk, TCP_FIN_WAIT2);
> -			sk->sk_state_change(sk);
> 			break;
> 		case TCP_CLOSING:
> 		case TCP_LAST_ACK:
> 			inet_sk_state_store(sk, TCP_CLOSE);
> -			sk->sk_state_change(sk);
> 			break;
> 		}
>
> +		/* if the socket is detached from user-space there is no point
> +		 * in keeping it around after spooling all the data
> +		 */
> +		if (sock_flag(sk, SOCK_DEAD))
> +			return;
> +
> +		sk->sk_state_change(sk);
> 		if (sk->sk_shutdown =3D=3D SHUTDOWN_MASK ||
> 		    sk->sk_state =3D=3D TCP_CLOSE)
> 			sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_HUP);
> @@ -418,7 +428,6 @@ static void mptcp_check_data_fin(struct sock *sk)
> 			break;
> 		case TCP_FIN_WAIT2:
> 			inet_sk_state_store(sk, TCP_CLOSE);
> -			// @@ Close subflows now?
> 			break;
> 		default:
> 			/* Other states not expected */
> @@ -435,8 +444,10 @@ static void mptcp_check_data_fin(struct sock *sk)
> 			release_sock(ssk);
> 		}
>
> -		sk->sk_state_change(sk);
> +		if (sock_flag(sk, SOCK_DEAD))
> +			return;
>
> +		sk->sk_state_change(sk);
> 		if (sk->sk_shutdown =3D=3D SHUTDOWN_MASK ||
> 		    sk->sk_state =3D=3D TCP_CLOSE)
> 			sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_HUP);
> @@ -672,6 +683,10 @@ static void mptcp_reset_timer(struct sock *sk)
> 	struct inet_connection_sock *icsk =3D inet_csk(sk);
> 	unsigned long tout;
>
> +	/* prevent rescheduling on close */
> +	if (unlikely(inet_sk_state_load(sk) =3D=3D TCP_CLOSE))
> +		return;
> +
> 	/* should never be called with mptcp level timer cleared */
> 	tout =3D READ_ONCE(mptcp_sk(sk)->timer_ival);
> 	if (WARN_ON_ONCE(!tout))
> @@ -1697,13 +1712,28 @@ void __mptcp_close_ssk(struct sock *sk, struct so=
ck *ssk,
>
> 	list_del(&subflow->node);
>
> -	if (sock && sock !=3D sk->sk_socket) {
> -		/* outgoing subflow */
> -		sock_release(sock);
> +	/* outgoing subflow */
> +	if (sock && sock !=3D sk->sk_socket)
> +		iput(SOCK_INODE(sock));
> +
> +	lock_sock(ssk);
> +
> +	/* if ssk hit tcp_done(), tcp_cleanup_ulp() cleared the related oops

Pointing out the oops/ops typo because "oops" has such major consequences =

in the kernel!

> +	 * the ssk has been already destroyed, we just need to release the
> +	 * reference owned by msk;
> +	 */
> +	if (!inet_csk(ssk)->icsk_ulp_ops) {
> +		kfree_rcu(subflow, rcu);

icsk_ulp_ops might have been cleared for fallback sockets, is that an =

expected case here too?

> 	} else {
> -		/* incoming subflow */
> -		tcp_close(ssk, timeout);
> +		/* otherwise ask tcp do dispose of ssk and subflow ctx */
> +		subflow->disposable =3D 1;
> +		__tcp_close(ssk, timeout);
> +
> +		/* close acquired an extra ref */
> +		__sock_put(ssk);
> 	}
> +	release_sock(ssk);
> +	sock_put(ssk);
> }
>

--
Mat Martineau
Intel
--===============0536847156600404803==--
