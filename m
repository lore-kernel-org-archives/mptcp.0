Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DABF25FA34
	for <mptcp@lists.linux.dev>; Wed, 17 Sep 2025 03:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758080374; cv=none; b=cmOsuGb/XGtS/hxObQ1Jm7/IPj/I/WG3WkfigeCKOP/r9GID1S9v3k2EynAB/tpGwtVuydfmreEYP2Ux5TfTmnrQ35V6EQWQQuPaOmcK/XGkcZTNY6+uFrZxSNgfVFDVEyRZY6gtlGXxgKriV2cvHiKuEogiJ5WuEt7c+I1i+HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758080374; c=relaxed/simple;
	bh=Nxw6pfBPjNsDpFVXKJ2HIG1trdgMe4AGl+tvAUqyPTI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LOuVEAc0A9nEIO7D4lb3a4rHCxMmLcqfRx9Ps7LEnmznijFwLqD0Q1zneLjFRizH6LSDGnxqh1RGmbVxycY+20QoXl68uTafpS06u59VJU4hHbWzqQ+gH6h0Mt4GY179f56c6sOhXb1/bj9vYaW2kiLj2qPTW6dknyMLeVu7fK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5aXiP3r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5aXiP3r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60CDC4CEEB;
	Wed, 17 Sep 2025 03:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758080373;
	bh=Nxw6pfBPjNsDpFVXKJ2HIG1trdgMe4AGl+tvAUqyPTI=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=g5aXiP3r4lh49T2P0PC9u+CyWxj6x3QoeKzLGCPtCljeXZVolS5JH+TOfUcBrXITr
	 6gLi4LzhPhlBiApy/uDk57v7wPwQZnuhOMRyz+pTySLZgk0D4AjbcfGX8ymEVlLBRJ
	 mmazqOiw7Kaqfn7IWTBkrRd5ip56U1FcubQj7xbnb/uNAckc4lp0CC37tXLvSIgkcP
	 B2ILDuNcdH2Z13ik/A71w6KOd4bqdNtfvoyAayLtO4/hBx3sJVWgZ+lMNG/kqaWHYd
	 WTAR30+DNEHr9mVuGZjmetH/ixJ5zVN31ydmzO+ZINv300A6NOqpGoF/6QGM2u4tvD
	 gO8nDXQJQhlVw==
Message-ID: <44782f5f4b2fabb1a3ebe476de6b671270671244.camel@kernel.org>
Subject: Re: [MPTCP next 10/12] mptcp: prevernt __mptcp_move_skbs()
 interferring with the fastpath
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Wed, 17 Sep 2025 11:39:26 +0800
In-Reply-To: <d5a0349baeeb725be8de01024dae64abc1a7499a.1758039775.git.pabeni@redhat.com>
References: <cover.1758039775.git.pabeni@redhat.com>
	 <d5a0349baeeb725be8de01024dae64abc1a7499a.1758039775.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

Thanks for this patch.

On Tue, 2025-09-16 at 18:27 +0200, Paolo Abeni wrote:
> skbs will be left waiting in the subflow only in exceptional cases,
> we want to avoid messing with the fast path by unintentionally
> processing in __mptcp_move_skbs() packets landed into the subflows
> after the last check.
> 
> Use a separate flag to mark delayed skbs and only process subflow
> with such flag set. Also add new mibs to track the exceptional
> events.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/mib.c      |  2 ++
>  net/mptcp/mib.h      |  4 ++++
>  net/mptcp/protocol.c | 40 ++++++++++++----------------------------
>  net/mptcp/protocol.h |  1 +
>  4 files changed, 19 insertions(+), 28 deletions(-)
> 
> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index cf879c188ca26..7af9d35cde884 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
> @@ -85,6 +85,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
>  	SNMP_MIB_ITEM("DssFallback", MPTCP_MIB_DSSFALLBACK),
>  	SNMP_MIB_ITEM("SimultConnectFallback",
> MPTCP_MIB_SIMULTCONNFALLBACK),
>  	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACKFAILED),
> +	SNMP_MIB_ITEM("RcvDelayed", MPTCP_MIB_RCVDELAYED),
> +	SNMP_MIB_ITEM("DelayedProcess", MPTCP_MIB_DELAYED_PROCESS),
>  	SNMP_MIB_SENTINEL

I guess this line was accidentally pasted, which prevents this patch
from being applied.

Thanks,
-Geliang

>  };
>  
> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> index 309bac6fea325..f6d0eaea463e5 100644
> --- a/net/mptcp/mib.h
> +++ b/net/mptcp/mib.h
> @@ -88,6 +88,10 @@ enum linux_mptcp_mib_field {
>  	MPTCP_MIB_DSSFALLBACK,		/* Bad or missing DSS */
>  	MPTCP_MIB_SIMULTCONNFALLBACK,	/* Simultaneous connect */
>  	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback due to msk
> status */
> +	MPTCP_MIB_RCVDELAYED,		/* Data move from subflow is
> delayed due to msk
> +					 * receive buffer full
> +					 */
> +	MPTCP_MIB_DELAYED_PROCESS,	/* Delayed data moved in
> slowpath */
>  	__MPTCP_MIB_MAX
>  };
>  
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 9c3baed948d1d..f211a939daf39 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -665,13 +665,17 @@ static bool
> __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>  	tp = tcp_sk(ssk);
>  	do {
>  		int mem = own_msk ? sk_rmem_alloc_get(sk) : sk-
> >sk_backlog.len;
> +		bool over_limit = mem > READ_ONCE(sk->sk_rcvbuf);
>  		u32 map_remaining, offset;
>  		u32 seq = tp->copied_seq;
>  		struct sk_buff *skb;
>  		bool fin;
>  
> -		if (mem > READ_ONCE(sk->sk_rcvbuf))
> +		WRITE_ONCE(subflow->data_delayed, over_limit);
> +		if (subflow->data_delayed) {
> +			MPTCP_INC_STATS(sock_net(sk),
> MPTCP_MIB_RCVDELAYED);
>  			break;
> +		}
>  
>  		/* try to move as much data as available */
>  		map_remaining = subflow->map_data_len -
> @@ -2081,32 +2085,13 @@ static void mptcp_rcv_space_adjust(struct
> mptcp_sock *msk, int copied)
>  	msk->rcvq_space.time = mstamp;
>  }
>  
> -static struct mptcp_subflow_context *
> -__mptcp_first_ready_from(struct mptcp_sock *msk,
> -			 struct mptcp_subflow_context *subflow)
> -{
> -	struct mptcp_subflow_context *start_subflow = subflow;
> -
> -	while (!READ_ONCE(subflow->data_avail)) {
> -		subflow = mptcp_next_subflow(msk, subflow);
> -		if (subflow == start_subflow)
> -			return NULL;
> -	}
> -	return subflow;
> -}
> -
>  static bool __mptcp_move_skbs(struct sock *sk)
>  {
>  	struct mptcp_subflow_context *subflow;
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  	bool ret = false;
>  
> -	if (list_empty(&msk->conn_list))
> -		return false;
> -
> -	subflow = list_first_entry(&msk->conn_list,
> -				   struct mptcp_subflow_context,
> node);
> -	for (;;) {
> +	mptcp_for_each_subflow(msk, subflow) {
>  		struct sock *ssk;
>  		bool slowpath;
>  
> @@ -2117,23 +2102,22 @@ static bool __mptcp_move_skbs(struct sock
> *sk)
>  		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
>  			break;
>  
> -		subflow = __mptcp_first_ready_from(msk, subflow);
> -		if (!subflow)
> -			break;
> +		if (!subflow->data_delayed)
> +			continue;
>  
>  		ssk = mptcp_subflow_tcp_sock(subflow);
>  		slowpath = lock_sock_fast(ssk);
> -		ret = __mptcp_move_skbs_from_subflow(msk, ssk, true)
> || ret;
> +		ret |= __mptcp_move_skbs_from_subflow(msk, ssk,
> true);
>  		if (unlikely(ssk->sk_err))
>  			__mptcp_error_report(sk);
>  		unlock_sock_fast(ssk, slowpath);
> -
> -		subflow = mptcp_next_subflow(msk, subflow);
>  	}
>  
>  	__mptcp_ofo_queue(msk);
> -	if (ret)
> +	if (ret) {
> +		MPTCP_INC_STATS(sock_net(sk),
> MPTCP_MIB_DELAYED_PROCESS);
>  		mptcp_check_data_fin((struct sock *)msk);
> +	}
>  	return ret;
>  }
>  
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index a6e775d6412e5..2905e4b250070 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -559,6 +559,7 @@ struct mptcp_subflow_context {
>  	u8	reset_transient:1;
>  	u8	reset_reason:4;
>  	u8	stale_count;
> +	bool	data_delayed;
>  
>  	u32	subflow_id;
>  
