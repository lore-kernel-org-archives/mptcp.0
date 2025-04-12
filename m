Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389663596D
	for <mptcp@lists.linux.dev>; Sat, 12 Apr 2025 00:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744417590; cv=none; b=oenaoEB/g+i4yUhtQnKGiOZQWPaUL3GRUQJZN8lEX44AisTbaMvosnNe86MfcSa2bNoAw3aCspX+lbizvchOr/jsSI6m3HloIFLEixokCJdNqvnr2KdDj16DMLmslV1W9YFHAZu696xzlEznrBWYLTn5RLY+wR1/N0Sk0/6w+vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744417590; c=relaxed/simple;
	bh=6fM1NO04acJJxVrNmvXUcfqz9eOyOjQUns6xRXhXM6k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BQf7eDl/lz1V8qel/NY/WjAjLkNNq6qcGdShs9AThw7kOlW6D9q7jJFWhyj2FnmmxGlLcdj75CQgjRFJWczReJnju9nIYNXNTpehAuSLLcC0I3++ejK3oWGjZvJCb7q4rcOmOG5gWK2b8gS4Agb/+/+tw3J4UVGjTq9NDR1/3q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wc/UTQJc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wc/UTQJc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E53BC4CEE2;
	Sat, 12 Apr 2025 00:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744417589;
	bh=6fM1NO04acJJxVrNmvXUcfqz9eOyOjQUns6xRXhXM6k=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Wc/UTQJcDAwBlG/JX6Vh5iDZn6Jkq7wHnOD/R08wTQrUT4OYxL9boFsi867H6ORGl
	 k8Wf1evDqDgop0v49U2tJG5I9EkapdyT+COFlLdw+0kdrcOlW/NFiUWwtwtvf8UBTg
	 3qQYQkV0nX+9QDJh7kaWnsBN9ypd0yRg+mY1ppGmCLPbscBzgLFGmbAPgSh4P7QKxH
	 RL2AG0A+Jq0CoNJ9X128hiQSsSjRwwUkgBO3aGhTN26owBUTkhYDNe3Ki2HzBgKPH5
	 IProvCJKLQBJOEu2vJmM3NMmogI4JtVBU+/Re50BciWFfeMMLmVdBojkwcGPHI/vet
	 Sxiw6XKWZkVDw==
Date: Fri, 11 Apr 2025 17:26:28 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 1/2] mptcp: pm: userspace: drop delete_local_addr
 helper
In-Reply-To: <2b140a3cefd7d5766a79e8c55b73cf2d38c710d0.1744257362.git.tanggeliang@kylinos.cn>
Message-ID: <ebdb4b2d-19fe-29ef-65df-d201b201b151@kernel.org>
References: <cover.1744257362.git.tanggeliang@kylinos.cn> <2b140a3cefd7d5766a79e8c55b73cf2d38c710d0.1744257362.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 10 Apr 2025, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Address entries should not be removed from local_addr_list when a subflow
> is deleted by the userspace PM, should only be removed when sending a
> REMOVE_ADDR.
>
> So mptcp_userspace_pm_delete_local_addr() helper shouldn't be called in
> mptcp_pm_nl_subflow_create_doit() and mptcp_pm_nl_subflow_destroy_doit().
>
> Since this helper is open-coding in mptcp_pm_nl_remove_doit(), it can be
> dropped now.
>
> Address entries are removed from local_addr_list when sending a REMOVE_ADDR
> by the userspace PM, the local_addr_used counter of PM should also be
> decremented accordingly.
>

Hi Geliang -

Have you tried this patch with mptcpd? Does it affect any tests there?


- Mat


> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> net/mptcp/pm_userspace.c | 37 +++++--------------------------------
> 1 file changed, 5 insertions(+), 32 deletions(-)
>
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 7fc19b844384..3824b4165421 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -90,30 +90,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
> 	return ret;
> }
>
> -/* If the subflow is closed from the other peer (not via a
> - * subflow destroy command then), we want to keep the entry
> - * not to assign the same ID to another address and to be
> - * able to send RM_ADDR after the removal of the subflow.
> - */
> -static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
> -						struct mptcp_pm_addr_entry *addr)
> -{
> -	struct sock *sk = (struct sock *)msk;
> -	struct mptcp_pm_addr_entry *entry;
> -
> -	entry = mptcp_userspace_pm_lookup_addr(msk, &addr->addr);
> -	if (!entry)
> -		return -EINVAL;
> -
> -	/* TODO: a refcount is needed because the entry can
> -	 * be used multiple times (e.g. fullmesh mode).
> -	 */
> -	list_del_rcu(&entry->list);
> -	sock_kfree_s(sk, entry, sizeof(*entry));
> -	msk->pm.local_addr_used--;
> -	return 0;
> -}
> -
> static struct mptcp_pm_addr_entry *
> mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
> {
> @@ -331,6 +307,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
> 	}
>
> 	list_del_rcu(&match->list);
> +	msk->pm.local_addr_used--;
> 	spin_unlock_bh(&msk->pm.lock);
>
> 	mptcp_pm_remove_addr_entry(msk, match);
> @@ -408,14 +385,13 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
> 	err = __mptcp_subflow_connect(sk, &local, &addr_r);
> 	release_sock(sk);
>
> -	if (err)
> +	if (err) {
> 		GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);
> +		goto create_err;
> +	}
>
> 	spin_lock_bh(&msk->pm.lock);
> -	if (err)
> -		mptcp_userspace_pm_delete_local_addr(msk, &entry);
> -	else
> -		msk->pm.subflows++;
> +	msk->pm.subflows++;
> 	spin_unlock_bh(&msk->pm.lock);
>
>  create_err:
> @@ -534,9 +510,6 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
> 		goto release_sock;
> 	}
>
> -	spin_lock_bh(&msk->pm.lock);
> -	mptcp_userspace_pm_delete_local_addr(msk, &addr_l);
> -	spin_unlock_bh(&msk->pm.lock);
> 	mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
> 	mptcp_close_ssk(sk, ssk, mptcp_subflow_ctx(ssk));
> 	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
> -- 
> 2.43.0
>
>
>
