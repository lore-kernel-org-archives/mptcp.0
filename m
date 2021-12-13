Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A992C80
	for <mptcp@lists.linux.dev>; Mon, 13 Dec 2021 23:10:20 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="302232330"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="302232330"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 15:10:20 -0800
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="661045545"
Received: from luisdsan-mobl.amr.corp.intel.com ([10.209.68.26])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 15:10:19 -0800
Date: Mon, 13 Dec 2021 15:10:19 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v5 4/5] mptcp: do not block subflows creation
 on errors
In-Reply-To: <9b71adc2d81f4eff820862dfcd3ba32d31ac520b.1639070864.git.pabeni@redhat.com>
Message-ID: <85360ad-80da-1bfc-6d68-31f8407467c0@linux.intel.com>
References: <cover.1639070864.git.pabeni@redhat.com> <9b71adc2d81f4eff820862dfcd3ba32d31ac520b.1639070864.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 9 Dec 2021, Paolo Abeni wrote:

> If the MPTCP configuration allows for multiple subflows
> creation, and the first additional subflows never reach
> the fully established status - e.g. due to packets drop or
> reset - the in kernel path manager do not move to the
> next subflow.
>
> This patch introduces a new PM helper to cope with MPJ
> subflow creation failure and delay and hook it where appropriate.
>
> Such helper triggers additional subflow creation, as needed
> and updates the PM subflow counter, if the current one is
> closing.
>
> Note that we don't need an additional timer to catch timeout
> and/or long delay in connection completion: we just need to
> measure the time elapsed since the subflow creation every
> time we emit an MPJ sub-option.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v3 -> v4:
> - fix 'subflows' underflow
>
> v2 -> v3:
> - fix compile warning (CI)
>
> v1 -> v2:
> - explicitly hook on subflow close instead of error notification
> - fix checkpatch issue (Mat)
> - introduce and use a new pm helper to cope with subflow close
> - update pm subflow counters on close
> ---
> net/mptcp/options.c    | 21 ++++++++++++++++++---
> net/mptcp/pm.c         | 23 +++++++++++++++++++++--
> net/mptcp/pm_netlink.c | 20 ++++++++++++--------
> net/mptcp/protocol.c   |  6 ++++++
> net/mptcp/protocol.h   |  5 ++++-
> net/mptcp/subflow.c    |  5 ++++-
> 6 files changed, 65 insertions(+), 15 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 7a6a39b71633..00a8697addcd 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1257,10 +1257,10 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
> void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> 			 struct mptcp_out_options *opts)
> {
> -	if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
> -		const struct sock *ssk = (const struct sock *)tp;
> -		struct mptcp_subflow_context *subflow;
> +	const struct sock *ssk = (const struct sock *)tp;
> +	struct mptcp_subflow_context *subflow;
>
> +	if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
> 		subflow = mptcp_subflow_ctx(ssk);
> 		subflow->send_mp_fail = 0;
>
> @@ -1382,6 +1382,21 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> 		/* MPC is additionally mutually exclusive with MP_PRIO */
> 		goto mp_capable_done;
> 	} else if (OPTIONS_MPTCP_MPJ & opts->suboptions) {
> +		if (ssk) {
> +			/* we are still in the MPJ handshake and "a lot" of time passed
> +			 * e.g. due to syn retranmissions. We can attempt next
> +			 * subflow creation
> +			 */
> +			subflow = mptcp_subflow_ctx(ssk);
> +			if (subflow->start_stamp &&
> +			    unlikely(after(tcp_jiffies32, subflow->start_stamp + HZ / 10))) {
> +				mptcp_pm_subflow_check_next(mptcp_sk(subflow->conn), ssk, subflow);
> +
> +				/* avoid triggering the PM multiple times due to timeout */
> +				subflow->start_stamp = 0;
> +			}
> +		}
> +

tcp_options_write() and the various helpers it calls are (so far) free 
from side effects and locking, and I don't think we want to introduce 
those now (__tcp_transmit_skb() seems like a sensitive code path to tinker 
with, even if it is only in this narrow case for packets with MPJ 
suboptions).

The msk sk_timer seems well-suited for this? I think we're only using it 
at disconnect time so there shouldn't be conflicts. What do you think?


Mat


> 		if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
> 			*ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
> 					      TCPOLEN_MPTCP_MPJ_SYN,
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index d6d22f18c418..7e2c76924492 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -172,9 +172,28 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk)
> 	spin_unlock_bh(&pm->lock);
> }
>
> -void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id)
> +void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
> +				 const struct mptcp_subflow_context *subflow)
> {
> -	pr_debug("msk=%p", msk);
> +	struct mptcp_pm_data *pm = &msk->pm;
> +	bool update_subflows;
> +
> +	update_subflows = (ssk->sk_state == TCP_CLOSE) &&
> +			  (subflow->request_join || subflow->mp_join);
> +	if (!READ_ONCE(pm->work_pending) && !update_subflows)
> +		return;
> +
> +	spin_lock_bh(&pm->lock);
> +	if (update_subflows)
> +		pm->subflows--;
> +
> +	/* Even if this subflow is not really established, tell the PM to try
> +	 * to pick the next one, if possible.
> +	 */
> +	if (mptcp_pm_nl_check_work_pending(msk))
> +		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
> +
> +	spin_unlock_bh(&pm->lock);
> }
>
> void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 1be7f92e9fc8..d908c0a0477b 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -251,14 +251,17 @@ unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk)
> }
> EXPORT_SYMBOL_GPL(mptcp_pm_get_local_addr_max);
>
> -static void check_work_pending(struct mptcp_sock *msk)
> +bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
> {
> 	struct pm_nl_pernet *pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
>
> 	if (msk->pm.subflows == mptcp_pm_get_subflows_max(msk) ||
> 	    (find_next_and_bit(pernet->id_bitmap, msk->pm.id_avail_bitmap, MAX_ADDR_ID + 1, 0) ==
> -	     MAX_ADDR_ID + 1))
> +	     MAX_ADDR_ID + 1)) {
> 		WRITE_ONCE(msk->pm.work_pending, false);
> +		return false;
> +	}
> +	return true;
> }
>
> struct mptcp_pm_add_entry *
> @@ -503,12 +506,12 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
>
> 	/* do lazy endpoint usage accounting for the MPC subflows */
> 	if (unlikely(!(msk->pm.status & BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED))) && msk->first) {
> -		struct mptcp_addr_info local;
> +		struct mptcp_addr_info mpc_addr;
> 		int mpc_id;
>
> -		local_address((struct sock_common *)msk->first, &local);
> -		mpc_id = lookup_id_by_addr(pernet, &local);
> -		if (mpc_id < 0)
> +		local_address((struct sock_common *)msk->first, &mpc_addr);
> +		mpc_id = lookup_id_by_addr(pernet, &mpc_addr);
> +		if (mpc_id >= 0)
> 			__clear_bit(mpc_id, msk->pm.id_avail_bitmap);
>
> 		msk->pm.status |= BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED);
> @@ -553,7 +556,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
> 			spin_lock_bh(&msk->pm.lock);
> 		}
> 	}
> -	check_work_pending(msk);
> +	mptcp_pm_nl_check_work_pending(msk);
> }
>
> static void mptcp_pm_nl_fully_established(struct mptcp_sock *msk)
> @@ -760,11 +763,12 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
> 				 i, rm_list->ids[i], subflow->local_id, subflow->remote_id);
> 			spin_unlock_bh(&msk->pm.lock);
> 			mptcp_subflow_shutdown(sk, ssk, how);
> +
> +			/* the following takes care of updating the subflows counter */
> 			mptcp_close_ssk(sk, ssk, subflow);
> 			spin_lock_bh(&msk->pm.lock);
>
> 			removed = true;
> -			msk->pm.subflows--;
> 			__MPTCP_INC_STATS(sock_net(sk), rm_type);
> 		}
> 		__set_bit(rm_list->ids[1], msk->pm.id_avail_bitmap);
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 63602c68f03d..aa0a1fe749d9 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2351,6 +2351,12 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> {
> 	if (sk->sk_state == TCP_ESTABLISHED)
> 		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
> +
> +	/* subflow aborted before reaching the fully_established status
> +	 * attempt the creation of the next subflow
> +	 */
> +	mptcp_pm_subflow_check_next(mptcp_sk(sk), ssk, subflow);
> +
> 	__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_PUSH);
> }
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index e63fe60f70b8..bd1165189233 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -443,6 +443,7 @@ struct mptcp_subflow_context {
> 		stale : 1;	    /* unable to snd/rcv data, do not use for xmit */
> 	enum mptcp_data_avail data_avail;
> 	u32	remote_nonce;
> +	u32	start_stamp;
> 	u64	thmac;
> 	u32	local_nonce;
> 	u32	remote_token;
> @@ -744,7 +745,9 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk,
> bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);
> void mptcp_pm_connection_closed(struct mptcp_sock *msk);
> void mptcp_pm_subflow_established(struct mptcp_sock *msk);
> -void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id);
> +bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk);
> +void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
> +				 const struct mptcp_subflow_context *subflow);
> void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
> 				const struct mptcp_addr_info *addr);
> void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 0f90bd61de01..76556743e952 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1273,7 +1273,8 @@ void __mptcp_error_report(struct sock *sk)
>
> static void subflow_error_report(struct sock *ssk)
> {
> -	struct sock *sk = mptcp_subflow_ctx(ssk)->conn;
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> +	struct sock *sk = subflow->conn;
>
> 	mptcp_data_lock(sk);
> 	if (!sock_owned_by_user(sk))
> @@ -1444,6 +1445,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
> 	subflow->remote_id = remote_id;
> 	subflow->request_join = 1;
> 	subflow->request_bkup = !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
> +	subflow->start_stamp = tcp_jiffies32;
> 	mptcp_info2sockaddr(remote, &addr, ssk->sk_family);
>
> 	mptcp_add_pending_subflow(msk, subflow);
> @@ -1461,6 +1463,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
> 	spin_lock_bh(&msk->join_list_lock);
> 	list_del(&subflow->node);
> 	spin_unlock_bh(&msk->join_list_lock);
> +	mptcp_pm_subflow_check_next(msk, ssk, subflow);
> 	sock_put(mptcp_subflow_tcp_sock(subflow));
>
> failed:
> -- 
> 2.33.1
>
>
>

--
Mat Martineau
Intel
