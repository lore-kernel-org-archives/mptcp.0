Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC6A72
	for <mptcp@lists.linux.dev>; Sat,  8 May 2021 00:28:38 +0000 (UTC)
IronPort-SDR: eWr0nG2ujY3q7VC90nKI8jNzt9XVfboPdyKl86uMtTBdcZKnidRGPv+4+mAIyRhtGkZcTITKJZ
 OI/c6AAqfvWg==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="195731199"
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="195731199"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 17:28:18 -0700
IronPort-SDR: 19tiphC13zXVWwKD2NwI/qeoVMGuxjPB4wUNW4zaIOAl7PC/E4IMElmq1psEN0N4SDu4CXxGRs
 1Wpq1bN39j3Q==
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="431730698"
Received: from magalleg-mobl.amr.corp.intel.com ([10.209.84.24])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 17:28:17 -0700
Date: Fri, 7 May 2021 17:28:17 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev, Florian Westphal <fw@strlen.de>
Subject: Re: [MPTCP][PATCH v4 mptcp-next 3/4] mptcp: add deny_join_id0 in
 mptcp_options_received
In-Reply-To: <2b2c8a35b85111f472e735f29166e1f88ecc3909.1620275759.git.geliangtang@gmail.com>
Message-ID: <af3f5ef4-d3a2-a989-32df-8f23bfec5674@linux.intel.com>
References: <cover.1620275759.git.geliangtang@gmail.com> <025c3e92286c1c425b6ce65b4feac7e416947e54.1620275759.git.geliangtang@gmail.com> <75cdf44b996264eeacf424f60fecd873ebc47d39.1620275759.git.geliangtang@gmail.com>
 <2b2c8a35b85111f472e735f29166e1f88ecc3909.1620275759.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 6 May 2021, Geliang Tang wrote:

> This patch added a new flag named deny_join_id0 in struct
> mptcp_options_received. Set it when MP_CAPABLE with the flag
> MPTCP_CAP_DENYJOIN_ID0 is received.
>
> Also add a new flag remote_deny_join_id0 in struct mptcp_pm_data. When the
> flag deny_join_id0 is set, set this remote_deny_join_id0 flag.
>
> In mptcp_pm_create_subflow_or_signal_addr, if the remote_deny_join_id0 flag
> is set, and the remote address id is zero, stop this connection.
>
> Suggested-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> net/mptcp/options.c    | 6 ++++++
> net/mptcp/pm.c         | 1 +
> net/mptcp/pm_netlink.c | 4 +++-
> net/mptcp/protocol.h   | 4 +++-
> net/mptcp/subflow.c    | 2 ++
> 5 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 630c87c62a87..4179287bd647 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -87,6 +87,9 @@ static void mptcp_parse_option(const struct sock *sk,
> 		if (flags & MPTCP_CAP_CHECKSUM_REQD)
> 			mp_opt->csum_reqd = 1;
>
> +		if (flags & MPTCP_CAP_DENY_JOIN_ID0)
> +			mp_opt->deny_join_id0 = 1;
> +
> 		mp_opt->mp_capable = 1;
> 		if (opsize >= TCPOLEN_MPTCP_MPC_SYNACK) {
> 			mp_opt->sndr_key = get_unaligned_be64(ptr);
> @@ -363,6 +366,7 @@ void mptcp_get_options(const struct sock *sk,
> 	mp_opt->mp_prio = 0;
> 	mp_opt->reset = 0;
> 	mp_opt->csum_reqd = 0;
> +	mp_opt->deny_join_id0 = 0;
>
> 	length = (th->doff * 4) - sizeof(struct tcphdr);
> 	ptr = (const unsigned char *)(th + 1);
> @@ -1055,6 +1059,8 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
> 	}
>
> 	mptcp_get_options(sk, skb, &mp_opt);
> +	if (mp_opt.deny_join_id0)
> +		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
> 	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
> 		return;
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 9d00fa6d22e9..639271e09604 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -320,6 +320,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
> 	WRITE_ONCE(msk->pm.addr_signal, 0);
> 	WRITE_ONCE(msk->pm.accept_addr, false);
> 	WRITE_ONCE(msk->pm.accept_subflow, false);
> +	WRITE_ONCE(msk->pm.remote_deny_join_id0, false);
> 	msk->pm.status = 0;
>
> 	spin_lock_init(&msk->pm.lock);
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index d094588afad8..58161510feef 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -456,10 +456,12 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
> 		if (local) {
> 			struct mptcp_addr_info remote = { 0 };
>
> +			remote_address((struct sock_common *)sk, &remote);
> +			if (!remote.id && READ_ONCE(msk->pm.remote_deny_join_id0))

remote_address() doesn't set remote.id, so it will always be 0 here and no 
subflows can ever be initiated by this block of code if the peer sent the 
C flag.

The in-kernel PM should have a better way to select a remote address for 
this subflow connection, but that might be beyond the scope of this patch 
set. For the C flag patch set, I do think it makes sense to check to see 
if we have received any ADD_ADDRs from the remote and use that remote 
address in the remote_deny_join_id0 case.

-Mat


> +				return;
> 			msk->pm.local_addr_used++;
> 			msk->pm.subflows++;
> 			check_work_pending(msk);
> -			remote_address((struct sock_common *)sk, &remote);
> 			spin_unlock_bh(&msk->pm.lock);
> 			__mptcp_subflow_connect(sk, &local->addr, &remote,
> 						local->flags, local->ifindex);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index fd6fe3176e08..41baa2ffc9a9 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -138,7 +138,8 @@ struct mptcp_options_received {
> 		mp_prio : 1,
> 		echo : 1,
> 		csum_reqd : 1,
> -		backup : 1;
> +		backup : 1,
> +		deny_join_id0 : 1;
> 	u32	token;
> 	u32	nonce;
> 	u64	thmac;
> @@ -193,6 +194,7 @@ struct mptcp_pm_data {
> 	bool		work_pending;
> 	bool		accept_addr;
> 	bool		accept_subflow;
> +	bool		remote_deny_join_id0;
> 	u8		add_addr_signaled;
> 	u8		add_addr_accepted;
> 	u8		local_addr_used;
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 324aff0b2f16..659b8842ae3b 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -408,6 +408,8 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
>
> 		if (mp_opt.csum_reqd)
> 			WRITE_ONCE(mptcp_sk(parent)->csum_enabled, true);
> +		if (mp_opt.deny_join_id0)
> +			WRITE_ONCE(mptcp_sk(parent)->pm.remote_deny_join_id0, true);
> 		subflow->mp_capable = 1;
> 		subflow->can_ack = 1;
> 		subflow->remote_key = mp_opt.sndr_key;
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
