Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E437134AA
	for <mptcp@lists.linux.dev>; Wed,  7 Feb 2024 03:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707276612; cv=none; b=ti4UN01H0GejxP0XhWI1haQbb1+++l8qlDEnJy+lT3xHJCZNgD/X7OF3wfSx5MNs+35R2coHbdOcrjhwpNa4U23kxCEZSU65C2iX4TWk/6XUAVcotefaBqie1M5b4ai6CBIXrYi1IHXeSZzuFZSn7oayeMeM7MtPwLQCQLwjU1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707276612; c=relaxed/simple;
	bh=UoqYbjBmgmaR1917vGWB6GcOZzg1HINcRGzl0LR2rBA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AosHCvsgBUR4odnEEu8eMiDxRkYEZSBNadBhR90FeHTTSrJFdnihgfu/OWImDGbDsJDpMsAhqF8A39ZgdOae847lrc8buRORLwK3aGwxV/8AUwjvTjwPz8+SEg0E8OdU4A/vBqLmEZNGjuJKBqkz2KNPAsPjOWMnWh5L3kmRQFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUfY0gZA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUfY0gZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A6FC433F1;
	Wed,  7 Feb 2024 03:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707276611;
	bh=UoqYbjBmgmaR1917vGWB6GcOZzg1HINcRGzl0LR2rBA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=FUfY0gZAjwbLK90cIYmtS/tL2GIBcLG8IgeE24izfhewC+5ews8kbnYho7FM/hOSy
	 /5b6dcqqggo6KhMQZC4vs7Bah0TuvJkMt9UdBr1ZKL83cFLZjsQmBFru2McVGwfTWD
	 35x+yXjAGF6yX0AgC0zKIUArkLp2LLOpvkZuTvzovEiCp8aGyTTo6v77NU15VPao97
	 /9li4regKMxtBN5MAcsVbExMjCt2Cwipome+TnxpVOOL3tRWMfjDnY8irKnDIxG/cW
	 xqYprAo91M9DCnblM9KLA2dZRA07RX9Wh4e4SU3+R6bFQZGJgEjVIDl2/efjjVHoUq
	 KT+VvQ/wOfSNg==
Date: Tue, 6 Feb 2024 19:30:11 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 2/4] mptcp: fix data races on local_id
In-Reply-To: <34c617cdc777aa32b1fa4ecc5c23784255f5fa56.1707144963.git.pabeni@redhat.com>
Message-ID: <87972ef7-9966-279f-4b66-25e8adaeff2d@kernel.org>
References: <cover.1707144963.git.pabeni@redhat.com> <34c617cdc777aa32b1fa4ecc5c23784255f5fa56.1707144963.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 5 Feb 2024, Paolo Abeni wrote:

> The local address id is accessed lockless by the NL PM, add
> all the required ONCE annotation. There is a caveat: the local
> id can be initialized late in the subflow life-cycle, and its
> validity is controlled by the local_id_valid flag.
>
> Remove such flag and encode the validity in the local_id field
> itself with negative value before initialization. That allows
> accessing the field consistently with a single read operation.
>
> Fixes: 0ee4261a3681 ("mptcp: implement mptcp_pm_remove_subflow")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/pm_netlink.c |  4 ++--
> net/mptcp/protocol.c   |  2 +-
> net/mptcp/protocol.h   | 15 ++++++++++++---
> net/mptcp/subflow.c    |  9 +++++----
> 4 files changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index d9ad45959219..d1b984c9dc25 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -800,7 +800,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
> 		mptcp_for_each_subflow_safe(msk, subflow, tmp) {
> 			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
> -			u8 id = subflow->local_id;
> +			u8 id = subflow_get_local_id(subflow);
>
> 			if (rm_type == MPTCP_MIB_RMADDR && subflow->remote_id != rm_id)
> 				continue;
> @@ -809,7 +809,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
>
> 			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u mpc_id=%u",
> 				 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow",
> -				 i, rm_id, subflow->local_id, subflow->remote_id,
> +				 i, rm_id, id, subflow->remote_id,
> 				 msk->mpc_endpoint_id);
> 			spin_unlock_bh(&msk->pm.lock);
> 			mptcp_subflow_shutdown(sk, ssk, how);
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index a8a94b34a51e..626fb4907381 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -85,7 +85,7 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
> 	subflow->subflow_id = msk->subflow_id++;
>
> 	/* This is the first subflow, always with id 0 */
> -	subflow->local_id_valid = 1;
> +	WRITE_ONCE(subflow->local_id, 0);
> 	mptcp_sock_graft(msk->first, sk->sk_socket);
> 	iput(SOCK_INODE(ssock));
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index de04b97e8dd1..9813de82bab8 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -493,10 +493,9 @@ struct mptcp_subflow_context {
> 		remote_key_valid : 1,        /* received the peer key from */
> 		disposable : 1,	    /* ctx can be free at ulp release time */
> 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
> -		local_id_valid : 1, /* local_id is correctly initialized */
> 		valid_csum_seen : 1,        /* at least one csum validated */
> 		is_mptfo : 1,	    /* subflow is doing TFO */
> -		__unused : 9;
> +		__unused : 10;
> 	bool	data_avail;
> 	bool	scheduled;
> 	u32	remote_nonce;
> @@ -507,7 +506,7 @@ struct mptcp_subflow_context {
> 		u8	hmac[MPTCPOPT_HMAC_LEN]; /* MPJ subflow only */
> 		u64	iasn;	    /* initial ack sequence number, MPC subflows only */
> 	};
> -	u8	local_id;
> +	s16	local_id;	    /* if negative not initialized yet */
> 	u8	remote_id;
> 	u8	reset_seen:1;
> 	u8	reset_transient:1;
> @@ -558,6 +557,7 @@ mptcp_subflow_ctx_reset(struct mptcp_subflow_context *subflow)
> {
> 	memset(&subflow->reset, 0, sizeof(subflow->reset));
> 	subflow->request_mptcp = 1;
> +	WRITE_ONCE(subflow->local_id, -1);
> }
>
> static inline u64
> @@ -1064,6 +1064,15 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
> int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
> int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
>
> +static inline int subflow_get_local_id(struct mptcp_subflow_context *subflow)

Hi Paolo -

Better to return a u8?

> +{
> +	int local_id = READ_ONCE(subflow->local_id);
> +
> +	if (local_id < 0)
> +		return 0;
> +	return local_id;
> +}

Looking around at code that still directly reads local_id from subflow 
contexts:

Should this also be used at line 236 in pm_userspace.c?

What about the places where local_id is passed in to nla_put_u8? 
(diag.c:68 and pm_netlink.c:1986?)


- Mat

> +
> void __init mptcp_pm_nl_init(void);
> void mptcp_pm_nl_work(struct mptcp_sock *msk);
> void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 02dab0669cfc..068784d3e748 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -578,8 +578,8 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
>
> static void subflow_set_local_id(struct mptcp_subflow_context *subflow, int local_id)
> {
> -	subflow->local_id = local_id;
> -	subflow->local_id_valid = 1;
> +	WARN_ON_ONCE(local_id < 0 || local_id > 255);
> +	WRITE_ONCE(subflow->local_id, local_id);
> }
>
> static int subflow_chk_local_id(struct sock *sk)
> @@ -588,7 +588,7 @@ static int subflow_chk_local_id(struct sock *sk)
> 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
> 	int err;
>
> -	if (likely(subflow->local_id_valid))
> +	if (likely(subflow->local_id >= 0))
> 		return 0;
>
> 	err = mptcp_pm_get_local_id(msk, (struct sock_common *)sk);
> @@ -1733,6 +1733,7 @@ static struct mptcp_subflow_context *subflow_create_ctx(struct sock *sk,
> 	pr_debug("subflow=%p", ctx);
>
> 	ctx->tcp_sock = sk;
> +	WRITE_ONCE(ctx->local_id, -1);
>
> 	return ctx;
> }
> @@ -1968,7 +1969,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
> 		new_ctx->idsn = subflow_req->idsn;
>
> 		/* this is the first subflow, id is always 0 */
> -		new_ctx->local_id_valid = 1;
> +		subflow_set_local_id(new_ctx, 0);
> 	} else if (subflow_req->mp_join) {
> 		new_ctx->ssn_offset = subflow_req->ssn_offset;
> 		new_ctx->mp_join = 1;
> -- 
> 2.43.0
>
>
>
