Content-Type: multipart/mixed; boundary="===============7077062082108517258=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 1/2] mptcp: implement deferred action
 infrastructure
Date: Tue, 12 Jan 2021 15:22:24 +0100
Message-ID: <c472883391a6fde4b4e34ea52e02474f78939ee3.camel@redhat.com>
In-Reply-To: 06d7dd5b5a2a5da7507bcd54d61f6b06a2ee919c.1610404441.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7327

--===============7077062082108517258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2021-01-11 at 23:43 +0100, Paolo Abeni wrote:
> @@ -3375,13 +3402,58 @@ static struct inet_protosw mptcp_protosw =3D {
>  #define MPTCP_USE_SLAB		1
>  #endif
>  =

> +DEFINE_PER_CPU(struct mptcp_deferred_action, mptcp_deferred_actions);
> +
> +static int mptcp_napi_poll(struct napi_struct *napi, int budget)
> +{
> +	struct mptcp_deferred_action *deferred;
> +	struct mptcp_subflow_context *subflow;
> +	int work_done =3D 0;
> +
> +	deferred =3D container_of(napi, struct mptcp_deferred_action, napi);
> +	while ((subflow =3D mptcp_subflow_deferred_next(deferred)) !=3D NULL) {
> +		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> +
> +		bh_lock_sock_nested(ssk);
> +		if (!sock_owned_by_user(ssk))
> +			mptcp_subflow_process_deferred(ssk);
> +
> +		/* if the sock is locked the deferred status will be cleared
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
>  void __init mptcp_proto_init(void)
>  {
> +	int cpu;
> +
>  	mptcp_prot.h.hashinfo =3D tcp_prot.h.hashinfo;
>  =

>  	if (percpu_counter_init(&mptcp_sockets_allocated, 0, GFP_KERNEL))
>  		panic("Failed to allocate MPTCP pcpu counter\n");
>  =

> +	for_each_possible_cpu(cpu) {
> +		struct mptcp_deferred_action *deferred =3D per_cpu_ptr(&mptcp_deferred=
_actions, cpu);
> +
> +		INIT_LIST_HEAD(&deferred->head);
> +		netif_tx_napi_add(init_net.loopback_dev, &deferred->napi, mptcp_napi_p=
oll,
> +				  NAPI_POLL_WEIGHT);

I just noted and learned that some device driver/protocol layer use a
dummy network device for this sort of thing:

	init_dummy_netdev(&<static struct net_device>)
	<add napis to the above>

I'll do that in the next iteration, to avoid pollute the lo device.

/P

--===============7077062082108517258==--
