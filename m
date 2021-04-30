Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8518F71
	for <mptcp@lists.linux.dev>; Fri, 30 Apr 2021 01:35:27 +0000 (UTC)
IronPort-SDR: laQMFp4TLgv5oUV/wW+15SGxFRyf1GxOSHXi3cOw5prb3/S7mAkp2fMwIOH9xiX7YnJqB6mG1D
 J/oJvcoO9vJw==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="258450548"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="258450548"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 18:35:27 -0700
IronPort-SDR: XxE+h6/J1Stb3kCdDguoUuyMT1u9HWtDCUjssXg+6VzOitD29MChXZhRnOqdx9HNGoHkelw4jx
 Zp2kCI9Dsh0A==
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="404392011"
Received: from rbidari-mobl1.amr.corp.intel.com ([10.254.72.16])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 18:35:27 -0700
Date: Thu, 29 Apr 2021 18:35:27 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH v3 mptcp-next 3/4] mptcp: add deny_join_id0 in
 mptcp_options_received
In-Reply-To: <45fac7966d2bfeae3027a9105ba9a6a2f35d6029.1619623735.git.geliangtang@gmail.com>
Message-ID: <1c4b71e-c69d-1f22-1e4b-2a98f9dc49c@linux.intel.com>
References: <cover.1619623735.git.geliangtang@gmail.com> <952b920c38ab98adfdb77a0e941ff43c05461a0d.1619623735.git.geliangtang@gmail.com> <972a77ea8b999cd2e0f8e32912156d5ac4b9a17e.1619623735.git.geliangtang@gmail.com>
 <45fac7966d2bfeae3027a9105ba9a6a2f35d6029.1619623735.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 28 Apr 2021, Geliang Tang wrote:

> This patch added a new flag named deny_join_id0 in struct
> mptcp_options_received. Set it when MP_CAPABLE with the flag
> MPTCP_CAP_DENYJOIN_ID0 is received.
>
> Also add a new flag deny_join_id0 in struct mptcp_pm_data. When the flag
> mp_opt.deny_join_id0 is set, set this pm->deny_join_id0 flag.
>
> In mptcp_pm_create_subflow_or_signal_addr, if the pm->deny_join_id0 flag
> is set, and the remote address id is zero, stop this connection.
>
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
> index 58ea22bf3d3d..4b6c58a13864 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -77,6 +77,9 @@ static void mptcp_parse_option(const struct sk_buff *skb,
> 		if (flags & MPTCP_CAP_CHECKSUM_REQD)
> 			break;
>
> +		if (flags & MPTCP_CAP_DENY_JOIN_ID0)
> +			mp_opt->deny_join_id0 = 1;
> +
> 		mp_opt->mp_capable = 1;
> 		if (opsize >= TCPOLEN_MPTCP_MPC_SYNACK) {
> 			mp_opt->sndr_key = get_unaligned_be64(ptr);
> @@ -342,6 +345,7 @@ void mptcp_get_options(const struct sk_buff *skb,
> 	mp_opt->dss = 0;
> 	mp_opt->mp_prio = 0;
> 	mp_opt->reset = 0;
> +	mp_opt->deny_join_id0 = 0;
>
> 	length = (th->doff * 4) - sizeof(struct tcphdr);
> 	ptr = (const unsigned char *)(th + 1);
> @@ -1012,6 +1016,8 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
> 	}
>
> 	mptcp_get_options(skb, &mp_opt);
> +	if (mp_opt.deny_join_id0)
> +		WRITE_ONCE(msk->pm.deny_join_id0, true);
> 	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
> 		return;
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 9d00fa6d22e9..d79f015af525 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -320,6 +320,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
> 	WRITE_ONCE(msk->pm.addr_signal, 0);
> 	WRITE_ONCE(msk->pm.accept_addr, false);
> 	WRITE_ONCE(msk->pm.accept_subflow, false);
> +	WRITE_ONCE(msk->pm.deny_join_id0, false);
> 	msk->pm.status = 0;
>
> 	spin_lock_init(&msk->pm.lock);
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index d094588afad8..1491a759a04a 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -456,10 +456,12 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
> 		if (local) {
> 			struct mptcp_addr_info remote = { 0 };
>
> +			remote_address((struct sock_common *)sk, &remote);
> +			if (!remote.id && READ_ONCE(msk->pm.deny_join_id0))
> +				return;
> 			msk->pm.local_addr_used++;
> 			msk->pm.subflows++;
> 			check_work_pending(msk);
> -			remote_address((struct sock_common *)sk, &remote);
> 			spin_unlock_bh(&msk->pm.lock);
> 			__mptcp_subflow_connect(sk, &local->addr, &remote,
> 						local->flags, local->ifindex);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index fcbaf47ce3bc..baf21c53fb42 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -134,7 +134,8 @@ struct mptcp_options_received {
> 		rm_addr : 1,
> 		mp_prio : 1,
> 		echo : 1,
> -		backup : 1;
> +		backup : 1,
> +		deny_join_id0 : 1;
> 	u32	token;
> 	u32	nonce;
> 	u64	thmac;
> @@ -189,6 +190,7 @@ struct mptcp_pm_data {
> 	bool		work_pending;
> 	bool		accept_addr;
> 	bool		accept_subflow;
> +	bool		deny_join_id0;

I suggest "remote_deny_join_id0" here to clarify that this means "the peer 
will deny id0 joins" not "this PM will deny id0 joins". The naming in 
mptcp_options_received does not need to change, it is just referring to 
the flag.

> 	u8		add_addr_signaled;
> 	u8		add_addr_accepted;
> 	u8		local_addr_used;
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index fb5b6eb5bec9..2de3b91d1626 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -405,6 +405,8 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
> 			goto fallback;
> 		}
>
> +		if (mp_opt.deny_join_id0)
> +			WRITE_ONCE(mptcp_sk(parent)->pm.deny_join_id0, true);
> 		subflow->mp_capable = 1;
> 		subflow->can_ack = 1;
> 		subflow->remote_key = mp_opt.sndr_key;
> -- 
> 2.30.2
>
>
>

--
Mat Martineau
Intel
