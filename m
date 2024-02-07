Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5001CD22
	for <mptcp@lists.linux.dev>; Wed,  7 Feb 2024 03:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707276823; cv=none; b=L/n85LQTp6KZz3JWCFbr4g64EIda5kaVqoN/TWpHkEFRGDKuLXYInx6b+RjXIQxsp0L9xFmAPuBCFx+1cJiOAOVoa5IWkWih8hS1U5PpUU+R138Fc9hWtaVCoMANU3+ZPcwUPrhUhTczyZ1cJWKVl35lQgp7uc3FHa1+Yeyh2qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707276823; c=relaxed/simple;
	bh=K3A4od8DPEQd+cVYZN64JurMJeWiYuwC5ppt9eKWCAA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=I5dDZlWAiofJwa+cws2bXNqjDlFOMFhDVddaYHDN6U/O35k6zvq8/bxnYwFOnQcYTzAssADh4lvp6b0XEqxbJZJeQ2r3KRocUZzVJNqyyoL5AVZFlbCDv9HNXIivBOl/VKlUFm2ucAiVZOqn8LRxfCKpIOGcDJtiVTGYwuXR40c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVYTTT1J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVYTTT1J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D46C433F1;
	Wed,  7 Feb 2024 03:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707276822;
	bh=K3A4od8DPEQd+cVYZN64JurMJeWiYuwC5ppt9eKWCAA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ZVYTTT1Jc87gN+4WOmKy67lYvVII6ERvqpsSEuP4D18dPbUCU+PdgoGt7Ab8FLwlJ
	 VsNUjV+gmZ1P8HyOrZ22Z4WSBFWVaScA2U+GShKSvyvTzKRP81TIAJ8zdNgDUb2/Q5
	 v88LgPdy7qjPLoh7lLtFAyrZdEDTgmB9eq7gIDyxgHh/VjShXtYiIxz9z2PBZriLTC
	 Euv25JB1PC4745cDPGH2sXf7we2+aR/oU0DnkUy68e4F7OqKZ4KVA7xp5s33PW59fl
	 ongHuhgU3kHqhtG0YawE8zo70fQeh8XoFgRwdxdo7dNGKZYjDgT+uP5lLfqzgMK4oK
	 pMWnvpbdaMi5Q==
Date: Tue, 6 Feb 2024 19:33:42 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 3/4] mptcp: fix data races on remote_id
In-Reply-To: <7487c3a37301428f088edb73cab6d01e55049353.1707144963.git.pabeni@redhat.com>
Message-ID: <a7c696cc-ae43-7bae-70ed-483954909ed4@kernel.org>
References: <cover.1707144963.git.pabeni@redhat.com> <7487c3a37301428f088edb73cab6d01e55049353.1707144963.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 5 Feb 2024, Paolo Abeni wrote:

> Similar to the previous patch, address the data race on
> remote_id, adding the suitable ONCE annotations.
>
> Fixes: bedee0b56113 ("mptcp: address lookup improvements")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/pm_netlink.c | 8 ++++----
> net/mptcp/subflow.c    | 6 +++---
> 2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index d1b984c9dc25..066bc855365c 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -443,7 +443,7 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
> 		mptcp_for_each_subflow(msk, subflow) {
> 			ssk = mptcp_subflow_tcp_sock(subflow);
> 			remote_address((struct sock_common *)ssk, &addrs[i]);
> -			addrs[i].id = subflow->remote_id;
> +			addrs[i].id = READ_ONCE(subflow->remote_id);
> 			if (deny_id0 && !addrs[i].id)
> 				continue;
>
> @@ -800,17 +800,17 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
> 		mptcp_for_each_subflow_safe(msk, subflow, tmp) {
> 			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
> +			u8 srm_id = READ_ONCE(subflow->remote_id);

Paolo -

"srm_id" reads oddly in statements like "srm_id != rm_id" since it creates 
some confusion between "remote" and "remove". Please rename to make the 
"remote" more obvious!

- Mat

> 			u8 id = subflow_get_local_id(subflow);
>
> -			if (rm_type == MPTCP_MIB_RMADDR && subflow->remote_id != rm_id)
> +			if (rm_type == MPTCP_MIB_RMADDR && srm_id != rm_id)
> 				continue;
> 			if (rm_type == MPTCP_MIB_RMSUBFLOW && !mptcp_local_id_match(msk, id, rm_id))
> 				continue;
>
> 			pr_debug(" -> %s rm_list_ids[%d]=%u local_id=%u remote_id=%u mpc_id=%u",
> 				 rm_type == MPTCP_MIB_RMADDR ? "address" : "subflow",
> -				 i, rm_id, id, subflow->remote_id,
> -				 msk->mpc_endpoint_id);
> +				 i, rm_id, id, srm_id, msk->mpc_endpoint_id);
> 			spin_unlock_bh(&msk->pm.lock);
> 			mptcp_subflow_shutdown(sk, ssk, how);
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 068784d3e748..6403c56f2902 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -536,7 +536,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
> 		subflow->backup = mp_opt.backup;
> 		subflow->thmac = mp_opt.thmac;
> 		subflow->remote_nonce = mp_opt.nonce;
> -		subflow->remote_id = mp_opt.join_id;
> +		WRITE_ONCE(subflow->remote_id, mp_opt.join_id);
> 		pr_debug("subflow=%p, thmac=%llu, remote_nonce=%u backup=%d",
> 			 subflow, subflow->thmac, subflow->remote_nonce,
> 			 subflow->backup);
> @@ -1569,7 +1569,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
> 	pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d", msk,
> 		 remote_token, local_id, remote_id);
> 	subflow->remote_token = remote_token;
> -	subflow->remote_id = remote_id;
> +	WRITE_ONCE(subflow->remote_id, remote_id);
> 	subflow->request_join = 1;
> 	subflow->request_bkup = !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
> 	subflow->subflow_id = msk->subflow_id++;
> @@ -1976,7 +1976,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
> 		new_ctx->fully_established = 1;
> 		new_ctx->remote_key_valid = 1;
> 		new_ctx->backup = subflow_req->backup;
> -		new_ctx->remote_id = subflow_req->remote_id;
> +		WRITE_ONCE(new_ctx->remote_id, subflow_req->remote_id);
> 		new_ctx->token = subflow_req->token;
> 		new_ctx->thmac = subflow_req->thmac;
>
> -- 
> 2.43.0
>
>
>
