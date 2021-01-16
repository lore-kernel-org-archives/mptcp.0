Content-Type: multipart/mixed; boundary="===============1005563119783689348=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next] mptcp: implement delegated actions
Date: Fri, 15 Jan 2021 16:16:06 -0800
Message-ID: <c726cf12-a2e6-727f-29d7-44bc691640d6@linux.intel.com>
In-Reply-To: de1057fa8de3cebc6150c410812c0b1ad3e4fd14.1610731067.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7401

--===============1005563119783689348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Jan 2021, Paolo Abeni wrote:

> On MPTCP-level ack reception, the packet scheduler
> may select a subflow other then the current one.
>
> Prior to this commit we rely on the workqueue to trigger
> action on such subflow.
>
> This changeset introduce an infrastructure that allows
> any MPTCP subflow to schedule actions (MPTCP xmit) on
> others subflows without resorting to (multiple) process
> reschedule.
>
> A dummy NAPI instance is used instead. When MPTCP needs to
> trigger action an a different subflow, it enqueues the target
> subflow on the NAPI backlog and schedule such instance as needed.
>
> The dummy NAPI poll method walk the sockets backlog and try
> to acquire the (BH) socket lock on each of them. If the socket
> is owned by the user space, the action will be completed by
> the sock release cb, otherwise push is started.
>
> This change leverage the delegated action infrastructure
> to avoid invoking the MPTCP worker to spool the pending data,
> when the packet scheduler picks a subflow other then the one
> currently processing the incoming MPTCP-level ack.
>
> Additinally we fourther refine the subflow selection
> invoking the packet scheduler for each chunk of data
> even inside __mptcp_subflow_push_pending()
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> v1 -> v2:
> - squash the 2 patches togethar

Thanks Paolo - I think it would be good to have this in the export branch =

for more test exposure.


Mat


> ---
> net/mptcp/protocol.c | 83 +++++++++++++++++++++++++++++++++++++++++---
> net/mptcp/protocol.h | 52 +++++++++++++++++++++++++++
> net/mptcp/subflow.c  | 39 +++++++++++++++++++++
> 3 files changed, 170 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d538f5a6810c..583154c1f72d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -45,6 +45,9 @@ static struct percpu_counter mptcp_sockets_allocated;
> static void __mptcp_destroy_sock(struct sock *sk);
> static void __mptcp_check_send_data_fin(struct sock *sk);
>
> +DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
> +static struct net_device mptcp_napi_dev;
> +
> /* If msk has an initial subflow socket, and the MP_CAPABLE handshake has=
 not
>  * completed yet or has failed, return the subflow socket.
>  * Otherwise return NULL.
> @@ -1507,7 +1510,9 @@ static void __mptcp_subflow_push_pending(struct soc=
k *sk, struct sock *ssk)
> 	struct mptcp_sock *msk =3D mptcp_sk(sk);
> 	struct mptcp_sendmsg_info info;
> 	struct mptcp_data_frag *dfrag;
> +	struct sock *xmit_ssk;
> 	int len, copied =3D 0;
> +	bool first =3D true;
>
> 	info.flags =3D 0;
> 	while ((dfrag =3D mptcp_send_head(sk))) {
> @@ -1517,6 +1522,18 @@ static void __mptcp_subflow_push_pending(struct so=
ck *sk, struct sock *ssk)
> 		while (len > 0) {
> 			int ret =3D 0;
>
> +			/* the caller already invoked the packet scheduler,
> +			 * check for a different subflow usage only after
> +			 * spooling the first chunk of data
> +			 */
> +			xmit_ssk =3D first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
> +			if (!xmit_ssk)
> +				goto out;
> +			if (xmit_ssk !=3D ssk) {
> +				mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk));
> +				goto out;
> +			}
> +
> 			if (unlikely(mptcp_must_reclaim_memory(sk, ssk))) {
> 				__mptcp_update_wmem(sk);
> 				sk_mem_reclaim_partial(sk);
> @@ -1535,6 +1552,7 @@ static void __mptcp_subflow_push_pending(struct soc=
k *sk, struct sock *ssk)
> 			msk->tx_pending_data -=3D ret;
> 			copied +=3D ret;
> 			len -=3D ret;
> +			first =3D false;
> 		}
> 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> 	}
> @@ -2243,7 +2261,6 @@ static void mptcp_worker(struct work_struct *work)
> 	if (unlikely(state =3D=3D TCP_CLOSE))
> 		goto unlock;
>
> -	mptcp_push_pending(sk, 0);
> 	mptcp_check_data_fin_ack(sk);
> 	__mptcp_flush_join_list(msk);
>
> @@ -2903,10 +2920,12 @@ void __mptcp_check_push(struct sock *sk, struct s=
ock *ssk)
> 		return;
>
> 	if (!sock_owned_by_user(sk)) {
> -		if (mptcp_subflow_get_send(mptcp_sk(sk)) =3D=3D ssk)
> +		struct sock *xmit_ssk =3D mptcp_subflow_get_send(mptcp_sk(sk));
> +
> +		if (xmit_ssk =3D=3D ssk)
> 			__mptcp_subflow_push_pending(sk, ssk);
> -		else
> -			mptcp_schedule_work(sk);
> +		else if (xmit_ssk)
> +			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk));
> 	} else {
> 		set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags);
> 	}
> @@ -2957,6 +2976,20 @@ static void mptcp_release_cb(struct sock *sk)
> 	}
> }
>
> +void mptcp_subflow_process_delegated(struct sock *ssk)
> +{
> +	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> +	struct sock *sk =3D subflow->conn;
> +
> +	mptcp_data_lock(sk);
> +	if (!sock_owned_by_user(sk))
> +		__mptcp_subflow_push_pending(sk, ssk);
> +	else
> +		set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags);
> +	mptcp_data_unlock(sk);
> +	mptcp_subflow_delegated_done(subflow);
> +}
> +
> static int mptcp_hash(struct sock *sk)
> {
> 	/* should never be called,
> @@ -3373,13 +3406,55 @@ static struct inet_protosw mptcp_protosw =3D {
> #define MPTCP_USE_SLAB		1
> #endif
>
> +static int mptcp_napi_poll(struct napi_struct *napi, int budget)
> +{
> +	struct mptcp_delegated_action *delegated;
> +	struct mptcp_subflow_context *subflow;
> +	int work_done =3D 0;
> +
> +	delegated =3D container_of(napi, struct mptcp_delegated_action, napi);
> +	while ((subflow =3D mptcp_subflow_delegated_next(delegated)) !=3D NULL)=
 {
> +		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> +
> +		bh_lock_sock_nested(ssk);
> +		if (!sock_owned_by_user(ssk))
> +			mptcp_subflow_process_delegated(ssk);
> +
> +		/* if the sock is locked the delegated status will be cleared
> +		 * by tcp_release_cb_override
> +		 */
> +		bh_unlock_sock(ssk);
> +
> +		if (++work_done =3D=3D budget)
> +			return budget;
> +	}
> +
> +	/* always provide a 0 'work_done' argument, so that napi_complete_done
> +	 * will not try accessing the NULL napi->dev ptr
> +	 */
> +	napi_complete_done(napi, 0);
> +	return work_done;
> +}
> +
> void __init mptcp_proto_init(void)
> {
> +	struct mptcp_delegated_action *delegated;
> +	int cpu;
> +
> 	mptcp_prot.h.hashinfo =3D tcp_prot.h.hashinfo;
>
> 	if (percpu_counter_init(&mptcp_sockets_allocated, 0, GFP_KERNEL))
> 		panic("Failed to allocate MPTCP pcpu counter\n");
>
> +	init_dummy_netdev(&mptcp_napi_dev);
> +	for_each_possible_cpu(cpu) {
> +		delegated =3D per_cpu_ptr(&mptcp_delegated_actions, cpu);
> +		INIT_LIST_HEAD(&delegated->head);
> +		netif_tx_napi_add(&mptcp_napi_dev, &delegated->napi, mptcp_napi_poll,
> +				  NAPI_POLL_WEIGHT);
> +		napi_enable(&delegated->napi);
> +	}
> +
> 	mptcp_subflow_init();
> 	mptcp_pm_init();
> 	mptcp_token_init();
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 871534df6140..7fa2ac3f2f4e 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -378,6 +378,13 @@ enum mptcp_data_avail {
> 	MPTCP_SUBFLOW_OOO_DATA
> };
>
> +struct mptcp_delegated_action {
> +	struct napi_struct napi;
> +	struct list_head head;
> +};
> +
> +DECLARE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
> +
> /* MPTCP subflow context */
> struct mptcp_subflow_context {
> 	struct	list_head node;/* conn_list of subflows */
> @@ -415,6 +422,9 @@ struct mptcp_subflow_context {
> 	u8	local_id;
> 	u8	remote_id;
>
> +	long	delegated_status;
> +	struct	list_head delegated_node;
> +
> 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
> 	struct	sock *conn;	    /* parent mptcp_sock */
> 	const	struct inet_connection_sock_af_ops *icsk_af_ops;
> @@ -463,6 +473,48 @@ static inline void mptcp_add_pending_subflow(struct =
mptcp_sock *msk,
> 	spin_unlock_bh(&msk->join_list_lock);
> }
>
> +void mptcp_subflow_process_delegated(struct sock *ssk);
> +
> +static inline void mptcp_subflow_delegate(struct mptcp_subflow_context *=
subflow)
> +{
> +	struct mptcp_delegated_action *delegated;
> +	bool schedule;
> +
> +	if (!test_and_set_bit(1, &subflow->delegated_status)) {
> +		local_bh_disable();
> +		delegated =3D this_cpu_ptr(&mptcp_delegated_actions);
> +		schedule =3D list_empty(&delegated->head);
> +		list_add_tail(&subflow->delegated_node, &delegated->head);
> +		if (schedule)
> +			napi_schedule(&delegated->napi);
> +		local_bh_enable();
> +	}
> +}
> +
> +static inline struct mptcp_subflow_context *
> +mptcp_subflow_delegated_next(struct mptcp_delegated_action *delegated)
> +{
> +	struct mptcp_subflow_context *ret;
> +
> +	if (list_empty(&delegated->head))
> +		return NULL;
> +
> +	ret =3D list_first_entry(&delegated->head, struct mptcp_subflow_context=
, delegated_node);
> +	list_del_init(&ret->delegated_node);
> +	return ret;
> +}
> +
> +static inline bool mptcp_subflow_has_delegated_action(const struct mptcp=
_subflow_context *subflow)
> +{
> +	return !test_bit(1, &subflow->delegated_status);
> +}
> +
> +static inline void mptcp_subflow_delegated_done(struct mptcp_subflow_con=
text *subflow)
> +{
> +	clear_bit(1, &subflow->delegated_status);
> +	list_del_init(&subflow->delegated_node);
> +}
> +
> int mptcp_is_enabled(struct net *net);
> unsigned int mptcp_get_add_addr_timeout(struct net *net);
> void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflo=
w,
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 31cc362a4638..0a34d21e4d1f 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -18,6 +18,7 @@
> #include <net/tcp.h>
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> #include <net/ip6_route.h>
> +#include <net/transp_v6.h>
> #endif
> #include <net/mptcp.h>
> #include <uapi/linux/mptcp.h>
> @@ -428,6 +429,7 @@ static int subflow_v4_conn_request(struct sock *sk, s=
truct sk_buff *skb)
> static struct tcp_request_sock_ops subflow_request_sock_ipv6_ops;
> static struct inet_connection_sock_af_ops subflow_v6_specific;
> static struct inet_connection_sock_af_ops subflow_v6m_specific;
> +static struct proto tcpv6_prot_override;
>
> static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
> {
> @@ -509,6 +511,14 @@ static void subflow_ulp_fallback(struct sock *sk,
> 	icsk->icsk_ulp_ops =3D NULL;
> 	rcu_assign_pointer(icsk->icsk_ulp_data, NULL);
> 	tcp_sk(sk)->is_mptcp =3D 0;
> +
> +	/* undo override */
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	if (sk->sk_prot =3D=3D &tcpv6_prot_override)
> +		sk->sk_prot =3D &tcpv6_prot;
> +	else
> +#endif
> +		sk->sk_prot =3D &tcp_prot;
> }
>
> static void subflow_drop_ctx(struct sock *ssk)
> @@ -682,6 +692,7 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
> }
>
> static struct inet_connection_sock_af_ops subflow_specific;
> +static struct proto tcp_prot_override;
>
> enum mapping_status {
> 	MAPPING_OK,
> @@ -1206,6 +1217,16 @@ static void mptcp_attach_cgroup(struct sock *paren=
t, struct sock *child)
> #endif /* CONFIG_SOCK_CGROUP_DATA */
> }
>
> +static void mptcp_subflow_ops_override(struct sock *ssk)
> +{
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	if (ssk->sk_prot =3D=3D &tcpv6_prot)
> +		ssk->sk_prot =3D &tcpv6_prot_override;
> +	else
> +#endif
> +		ssk->sk_prot =3D &tcp_prot_override;
> +}
> +
> int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
> {
> 	struct mptcp_subflow_context *subflow;
> @@ -1261,6 +1282,7 @@ int mptcp_subflow_create_socket(struct sock *sk, st=
ruct socket **new_sock)
> 	*new_sock =3D sf;
> 	sock_hold(sk);
> 	subflow->conn =3D sk;
> +	mptcp_subflow_ops_override(sf->sk);
>
> 	return 0;
> }
> @@ -1277,6 +1299,7 @@ static struct mptcp_subflow_context *subflow_create=
_ctx(struct sock *sk,
>
> 	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
> 	INIT_LIST_HEAD(&ctx->node);
> +	INIT_LIST_HEAD(&ctx->delegated_node);
>
> 	pr_debug("subflow=3D%p", ctx);
>
> @@ -1442,6 +1465,16 @@ static void subflow_ulp_clone(const struct request=
_sock *req,
> 	}
> }
>
> +static void tcp_release_cb_override(struct sock *ssk)
> +{
> +	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> +
> +	if (mptcp_subflow_has_delegated_action(subflow))
> +		mptcp_subflow_process_delegated(ssk);
> +
> +	tcp_release_cb(ssk);
> +}
> +
> static struct tcp_ulp_ops subflow_ulp_ops __read_mostly =3D {
> 	.name		=3D "mptcp",
> 	.owner		=3D THIS_MODULE,
> @@ -1482,6 +1515,9 @@ void __init mptcp_subflow_init(void)
> 	subflow_specific.syn_recv_sock =3D subflow_syn_recv_sock;
> 	subflow_specific.sk_rx_dst_set =3D subflow_finish_connect;
>
> +	tcp_prot_override =3D tcp_prot;
> +	tcp_prot_override.release_cb =3D tcp_release_cb_override;
> +
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> 	subflow_request_sock_ipv6_ops =3D tcp_request_sock_ipv6_ops;
> 	subflow_request_sock_ipv6_ops.route_req =3D subflow_v6_route_req;
> @@ -1497,6 +1533,9 @@ void __init mptcp_subflow_init(void)
> 	subflow_v6m_specific.net_header_len =3D ipv4_specific.net_header_len;
> 	subflow_v6m_specific.mtu_reduced =3D ipv4_specific.mtu_reduced;
> 	subflow_v6m_specific.net_frag_header_len =3D 0;
> +
> +	tcpv6_prot_override =3D tcpv6_prot;
> +	tcpv6_prot_override.release_cb =3D tcp_release_cb_override;
> #endif
>
> 	mptcp_diag_subflow_init(&subflow_ulp_ops);
> -- =

> 2.26.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============1005563119783689348==--
