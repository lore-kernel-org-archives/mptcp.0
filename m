Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118EE72
	for <mptcp@lists.linux.dev>; Tue,  6 Jul 2021 22:34:29 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="196372425"
X-IronPort-AV: E=Sophos;i="5.83,329,1616482800"; 
   d="scan'208";a="196372425"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 15:34:22 -0700
X-IronPort-AV: E=Sophos;i="5.83,329,1616482800"; 
   d="scan'208";a="410374328"
Received: from tmtoksta-mobl.amr.corp.intel.com ([10.209.95.113])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 15:34:22 -0700
Date: Tue, 6 Jul 2021 15:34:21 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-net] mptcp: properly account bulk freed memory
In-Reply-To: <4a413026831df9aaf1d2073f9a8b5b29d4376bfe.1624894631.git.pabeni@redhat.com>
Message-ID: <bf9b1b65-1ade-3c59-e3fd-fab589404337@linux.intel.com>
References: <4a413026831df9aaf1d2073f9a8b5b29d4376bfe.1624894631.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 28 Jun 2021, Paolo Abeni wrote:

> After commit 879526030c8b ("mptcp: protect the rx path with
> the msk socket spinlock") the rmem currently used by a given
> msk is really sk_rmem_alloc - rmem_released.
>
> The safety check in mptcp_data_ready() does not take the above
> in due account, as a result legit incoming data is keept in
> subflow receive queue with no reason, delaying or blocking
> MPTCP-level ack generation.
>
> This change addresses the issue introducing a new helper to fetch
> the rmem memory and using it as needed. Additionally add a MIB
> counter for the exceptional event described above - the peer is
> misbehaving.
>
> Finally update introduce the required annotation when rmem_released
> is updated.
>
> Fixes: 879526030c8b ("mptcp: protect the rx path with the msk socket spinlock")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/211
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
> - use WRITE_ONCE to update rmem_released (Mat)
> - introuce __mptcp_rmem() helper

Thanks for the v2 Paolo. Looks good to me, build & test are successful 
on my system too.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> ---
> net/mptcp/mib.c      |  1 +
> net/mptcp/mib.h      |  1 +
> net/mptcp/protocol.c | 12 +++++++-----
> net/mptcp/protocol.h | 10 +++++++++-
> 4 files changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index 52ea2517e856..ff2cc0e3273d 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
> @@ -44,6 +44,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
> 	SNMP_MIB_ITEM("RmSubflow", MPTCP_MIB_RMSUBFLOW),
> 	SNMP_MIB_ITEM("MPPrioTx", MPTCP_MIB_MPPRIOTX),
> 	SNMP_MIB_ITEM("MPPrioRx", MPTCP_MIB_MPPRIORX),
> +	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
> 	SNMP_MIB_SENTINEL
> };
>
> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> index 193466c9b549..0663cb12b448 100644
> --- a/net/mptcp/mib.h
> +++ b/net/mptcp/mib.h
> @@ -37,6 +37,7 @@ enum linux_mptcp_mib_field {
> 	MPTCP_MIB_RMSUBFLOW,		/* Remove a subflow */
> 	MPTCP_MIB_MPPRIOTX,		/* Transmit a MP_PRIO */
> 	MPTCP_MIB_MPPRIORX,		/* Received a MP_PRIO */
> +	MPTCP_MIB_RCVPRUNED,		/* Incoming packet dropped due to memory limit */
> 	__MPTCP_MIB_MAX
> };
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ddce5b7bbefd..4cc94ee425e4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -474,7 +474,7 @@ static void mptcp_cleanup_rbuf(struct mptcp_sock *msk)
> 	bool cleanup, rx_empty;
>
> 	cleanup = (space > 0) && (space >= (old_space << 1));
> -	rx_empty = !atomic_read(&sk->sk_rmem_alloc);
> +	rx_empty = !__mptcp_rmem(sk);
>
> 	mptcp_for_each_subflow(msk, subflow) {
> 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> @@ -720,8 +720,10 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
> 		sk_rbuf = ssk_rbuf;
>
> 	/* over limit? can't append more skbs to msk, Also, no need to wake-up*/
> -	if (atomic_read(&sk->sk_rmem_alloc) > sk_rbuf)
> +	if (__mptcp_rmem(sk) > sk_rbuf) {
> +		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
> 		return;
> +	}
>
> 	/* Wake-up the reader only for in-sequence data */
> 	mptcp_data_lock(sk);
> @@ -1754,7 +1756,7 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
> 		if (!(flags & MSG_PEEK)) {
> 			/* we will bulk release the skb memory later */
> 			skb->destructor = NULL;
> -			msk->rmem_released += skb->truesize;
> +			WRITE_ONCE(msk->rmem_released, msk->rmem_released + skb->truesize);
> 			__skb_unlink(skb, &msk->receive_queue);
> 			__kfree_skb(skb);
> 		}
> @@ -1873,7 +1875,7 @@ static void __mptcp_update_rmem(struct sock *sk)
>
> 	atomic_sub(msk->rmem_released, &sk->sk_rmem_alloc);
> 	sk_mem_uncharge(sk, msk->rmem_released);
> -	msk->rmem_released = 0;
> +	WRITE_ONCE(msk->rmem_released, 0);
> }
>
> static void __mptcp_splice_receive_queue(struct sock *sk)
> @@ -2380,7 +2382,7 @@ static int __mptcp_init_sock(struct sock *sk)
> 	msk->out_of_order_queue = RB_ROOT;
> 	msk->first_pending = NULL;
> 	msk->wmem_reserved = 0;
> -	msk->rmem_released = 0;
> +	WRITE_ONCE(msk->rmem_released, 0);
> 	msk->tx_pending_data = 0;
>
> 	msk->first = NULL;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 426ed80fe72f..0f0c026c5f8b 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -296,9 +296,17 @@ static inline struct mptcp_sock *mptcp_sk(const struct sock *sk)
> 	return (struct mptcp_sock *)sk;
> }
>
> +/* the msk socket don't use the backlog, also account for the bulk
> + * free memory
> + */
> +static inline int __mptcp_rmem(const struct sock *sk)
> +{
> +	return atomic_read(&sk->sk_rmem_alloc) - READ_ONCE(mptcp_sk(sk)->rmem_released);
> +}
> +
> static inline int __mptcp_space(const struct sock *sk)
> {
> -	return tcp_space(sk) + READ_ONCE(mptcp_sk(sk)->rmem_released);
> +	return tcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) - __mptcp_rmem(sk));
> }
>
> static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *sk)
> -- 
> 2.26.3
>
>
>

--
Mat Martineau
Intel
