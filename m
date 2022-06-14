Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F63110C
	for <mptcp@lists.linux.dev>; Tue, 14 Jun 2022 00:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655165483; x=1686701483;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TpKVtZVVWnb7ELGVsV813diQ56TQ1I/ODo1Ls6EjK6I=;
  b=YRlrz48qHQ4Bdpu9UoVqz6D73jLa7VZi+ZqMDpZtHSZDZk3o6Ca98+Iv
   Fzo8DY9JjCW1N9sQhVpCm1RYjMAeoZ7LIOVi+dbzJrscq/vmM3blrFlwK
   EW85pCxqnjZGtKI5aLbDbNqObNA7BrHWM8NDHtRJDqos/JTlnMMu3i3ge
   t4/U6ZNwuzl1vPd0tchwTqNKW3FYX2oUP9s1l+kSV0ZNQ/eKVEoEOUxAP
   X/b7DshETU07S1Rsz1wRBeF13TZlIVNIKyWuKNsg46VLPKyPjhwWzyPE5
   ofo/VIzDAPTYDj53Nk6RRLTz7hsd5viBWDDlETOyfKU0iq8qucaj8rvwL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="342419677"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="342419677"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 17:11:22 -0700
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="617726383"
Received: from jfgiesbe-mobl.amr.corp.intel.com ([10.209.95.28])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 17:11:22 -0700
Date: Mon, 13 Jun 2022 17:11:22 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v6 3/9] mptcp: redundant subflows push
 pending
In-Reply-To: <7918875de1a12ffcc6221da479cce24e4e556889.1654865847.git.geliang.tang@suse.com>
Message-ID: <84f655d-ff54-5796-4935-6c5d18cd169@linux.intel.com>
References: <cover.1654865847.git.geliang.tang@suse.com> <7918875de1a12ffcc6221da479cce24e4e556889.1654865847.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 10 Jun 2022, Geliang Tang wrote:

> This patch adds the redundant subflows support for __mptcp_push_pending().
> Use mptcp_sched_get_send() wrapper instead of mptcp_subflow_get_send()
> in it.
>
> Check the subflow scheduled flags to test which subflow or subflows are
> picked by the scheduler, use them to send data.
>
> Redundant subflows are not supported in __mptcp_subflow_push_pending()
> yet. This patch adds a placeholder in mptcp_sched_get_send() to pick the
> first subflow for the redundant subflows case.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 73 +++++++++++++++++++++++++++++++++++++++++---
> net/mptcp/subflow.c  |  1 -
> 2 files changed, 68 insertions(+), 6 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ab42059143fa..257b04315271 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1549,6 +1549,62 @@ void mptcp_check_and_set_pending(struct sock *sk)
> 		mptcp_sk(sk)->push_pending |= BIT(MPTCP_PUSH_PENDING);
> }
>
> +static int __mptcp_subflows_push_pending(struct sock *sk, struct mptcp_sendmsg_info *info)

This separate function is fine for experimenting with the transmit loop. I 
do think it will be easier to try some different approaches to handling 
the redundant transmissions, but before upstreaming I hope we can reduce 
the duplicate code.

I suggest renaming this to __mptcp_redundant_push_pending() for now.

> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> +	struct mptcp_data_frag *dfrag;
> +	int len, copied = 0, err = 0;
> +	struct sock *ssk = NULL;
> +
> +	while ((dfrag = mptcp_send_head(sk))) {
> +		info->sent = dfrag->already_sent;
> +		info->limit = dfrag->data_len;
> +		len = dfrag->data_len - dfrag->already_sent;
> +		while (len > 0) {
> +			int ret = 0, max = 0;
> +
> +			mptcp_sched_get_send(msk, &err);
> +			if (err)
> +				goto out;
> +
> +			mptcp_for_each_subflow(msk, subflow) {
> +				if (READ_ONCE(subflow->scheduled)) {
> +					ssk = mptcp_subflow_tcp_sock(subflow);
> +					if (!ssk)
> +						goto out;

Wouldn't it be better to 'continue'? Other subflows might not have errors.

> +
> +					lock_sock(ssk);
> +
> +					ret = mptcp_sendmsg_frag(sk, ssk, dfrag, info);
> +					if (ret <= 0) {
> +						mptcp_push_release(ssk, info);
> +						goto out;

Same here (to 'continue' instead), the transmit might succeed on other 
subflows.

> +					}
> +
> +					if (ret > max)
> +						max = ret;
> +
> +					mptcp_push_release(ssk, info);
> +
> +					msk->last_snd = ssk;
> +					mptcp_subflow_set_scheduled(subflow, false);
> +				}
> +			}
> +
> +			info->sent += max;
> +			copied += max;
> +			len -= max;
> +
> +			mptcp_update_post_push(msk, dfrag, max);
> +		}
> +		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> +	}
> +
> +out:
> +	return copied;
> +}
> +
> void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> {
> 	struct sock *prev_ssk = NULL, *ssk = NULL;
> @@ -1559,15 +1615,20 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 	struct mptcp_data_frag *dfrag;
> 	int len, copied = 0;
>
> +	if (unlikely(msk->sched && msk->sched->redundant)) {
> +		copied = __mptcp_subflows_push_pending(sk, &info);
> +		goto out;
> +	}
> +
> 	while ((dfrag = mptcp_send_head(sk))) {
> 		info.sent = dfrag->already_sent;
> 		info.limit = dfrag->data_len;
> 		len = dfrag->data_len - dfrag->already_sent;
> 		while (len > 0) {
> -			int ret = 0;
> +			int ret = 0, err = 0;
>
> 			prev_ssk = ssk;
> -			ssk = mptcp_subflow_get_send(msk);
> +			ssk = mptcp_sched_get_send(msk, &err);
>
> 			/* First check. If the ssk has changed since
> 			 * the last round, release prev_ssk
> @@ -1628,13 +1689,13 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
> 		info.limit = dfrag->data_len;
> 		len = dfrag->data_len - dfrag->already_sent;
> 		while (len > 0) {
> -			int ret = 0;
> +			int ret = 0, err = 0;
>
> 			/* the caller already invoked the packet scheduler,
> 			 * check for a different subflow usage only after
> 			 * spooling the first chunk of data
> 			 */
> -			xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
> +			xmit_ssk = first ? ssk : mptcp_sched_get_send(mptcp_sk(sk), &err);
> 			if (!xmit_ssk)
> 				goto out;
> 			if (xmit_ssk != ssk) {
> @@ -3093,11 +3154,13 @@ void __mptcp_data_acked(struct sock *sk)
>
> void __mptcp_check_push(struct sock *sk, struct sock *ssk)
> {
> +	int err = 0;
> +
> 	if (!mptcp_send_head(sk))
> 		return;
>
> 	if (!sock_owned_by_user(sk)) {
> -		struct sock *xmit_ssk = mptcp_subflow_get_send(mptcp_sk(sk));
> +		struct sock *xmit_ssk = mptcp_sched_get_send(mptcp_sk(sk), &err);
>
> 		if (xmit_ssk == ssk)
> 			__mptcp_subflow_push_pending(sk, ssk);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 5351d54e514a..021b454640a3 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -881,7 +881,6 @@ static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)
> 				  subflow->map_data_len))) {
> 		/* Mapping does covers past subflow data, invalid */
> 		dbg_bad_map(subflow, ssn);
> -		return false;

Is this change intended?

> 	}
> 	return true;
> }
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
