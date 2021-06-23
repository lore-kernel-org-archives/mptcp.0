Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6B0173
	for <mptcp@lists.linux.dev>; Wed, 23 Jun 2021 00:23:42 +0000 (UTC)
IronPort-SDR: fgOGxmRv/2YkiOJ3wsiUIUJgu5k+ZvwaOm5XbvaSRISwRU8d8EuYF3hd/w51hdKT7uqmwdT3a0
 l562OS9DFQYg==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="206982947"
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="206982947"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 17:23:40 -0700
IronPort-SDR: ti1miG9vDa5Bm7xSSH7kX65SYtACmvmeq7Zl2L77mCetquw0D9RLzxYAXBCgf6mQhbUcysD3Kl
 OM5WwchmlsWg==
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="641817446"
Received: from mrsastry-mobl1.amr.corp.intel.com ([10.212.137.16])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 17:23:40 -0700
Date: Tue, 22 Jun 2021 17:23:39 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-net] mptcp: properly account bulk freed memory
In-Reply-To: <dc58277ea9c9bb6d8a71130a8fc19d995cb49b0c.1624357695.git.pabeni@redhat.com>
Message-ID: <6577515c-4e89-d720-615e-7659b72924c@linux.intel.com>
References: <dc58277ea9c9bb6d8a71130a8fc19d995cb49b0c.1624357695.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 22 Jun 2021, Paolo Abeni wrote:

> After commit 879526030c8b ("mptcp: protect the rx path with
> the msk socket spinlock") the rmem currently used by a given
> msk is really sk_rmem_alloc - rmem_released.
>
> The safety check in mptcp_data_ready() does not take the above
> in due account, as a result legit incoming data is keept in
> subflow receive queue with no reason, delaying or blocking
> MPTCP-level ack generation.
>
> This change addresses the issue updating the check in mptcp_data_ready()
> as needed. Additionally add a counter for such exceptional event
> - the peer is misbehaving.
>
> Finally update __mptcp_space() to properly compute the window size
> given the current memory allocation.
>
> Fixes: 879526030c8b ("mptcp: protect the rx path with the msk socket spinlock")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/211
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> This additionally improves simult_flows.sh stability. @matttbe: could
> you please have a spin in your testbad to see if we could close
> issues/137, too?
>
> side note: if the VM is slow enough, it could end-up causing failures
> even if the protocol would be "perfect", not sure if we should consider
> baremetal (or less VM nesting) here.
> ---
> net/mptcp/mib.c      | 1 +
> net/mptcp/mib.h      | 1 +
> net/mptcp/protocol.c | 4 +++-
> net/mptcp/protocol.h | 7 ++++++-
> 4 files changed, 11 insertions(+), 2 deletions(-)
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
> index ddce5b7bbefd..105b312b1036 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -720,8 +720,10 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
> 		sk_rbuf = ssk_rbuf;
>
> 	/* over limit? can't append more skbs to msk, Also, no need to wake-up*/
> -	if (atomic_read(&sk->sk_rmem_alloc) > sk_rbuf)
> +	if (atomic_read(&sk->sk_rmem_alloc) - READ_ONCE(msk->rmem_released) > sk_rbuf) {
> +		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
> 		return;
> +	}
>
> 	/* Wake-up the reader only for in-sequence data */
> 	mptcp_data_lock(sk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 426ed80fe72f..60bd78210a36 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -296,9 +296,14 @@ static inline struct mptcp_sock *mptcp_sk(const struct sock *sk)
> 	return (struct mptcp_sock *)sk;
> }
>
> +/* the msk socket don't use the backlog, also account for the bulk
> + * free memory
> + */
> static inline int __mptcp_space(const struct sock *sk)
> {
> -	return tcp_space(sk) + READ_ONCE(mptcp_sk(sk)->rmem_released);
> +	return tcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) -
> +				  atomic_read(&sk->sk_rmem_alloc) +
> +				  mptcp_sk(sk)->rmem_released);

Does this last rmem_released need a READ_ONCE() like it had before? 
__mptcp_space is called without the MPTCP data lock.

Looks like msk->rmem_released is updated without WRITE_ONCE() in a couple 
of places: __mptcp_update_rmem() and __mptcp_recvmsg_mskq(). Best to fix 
that too - seems like it's needed.

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
