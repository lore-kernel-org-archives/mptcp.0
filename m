Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A82315A4
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 01:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXnnGVQv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC453C433C7;
	Tue,  7 Nov 2023 01:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699319266;
	bh=3PQ4ACUm7bzebKtZHGiqrUL0eIuUyiLoknz3mTvgzXs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=WXnnGVQvw7LwswNvjvAF0mLfj6N7NLw/uhc1Fs+bl2uef3XZd6QfW2mbTQF2C88Uf
	 gx+uHT4imSbBjNWmViQ4uNgYh851kF61xLnIobfYsqe7rnhQSfQBdUTtp3VZZ4i7B+
	 +NrE18ykhhKHZ/joW71P4MlEVpyVflduyz9wJ11m5NSDfrSEH4MTrIloexmL6AC0Fd
	 JWTxG1U8ysESw9EmhiFSQ2rqQG2AJrPD0eV7LbtgPpgRk4uV8Q5GMdl9AU6R6m7l88
	 NMQaqlIi1YfrPddvy9JPLGXPSSOjRcT0bC+b1SecSg8bjasNQyaOuQdZ2HOBwxubFF
	 PEysJEfUQ28DQ==
Date: Mon, 6 Nov 2023 17:07:45 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: add validity check for sending
 RM_ADDR
In-Reply-To: <02d38d6b7a98765bf516c90541d4f2a911f428ce.1699014584.git.geliang.tang@suse.com>
Message-ID: <aced43b2-0ece-264f-a314-698ccb2299da@kernel.org>
References: <02d38d6b7a98765bf516c90541d4f2a911f428ce.1699014584.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 3 Nov 2023, Geliang Tang wrote:

> This patch adds the validity check for sending RM_ADDRs for userspace PM
> in mptcp_pm_remove_addrs(), only send a RM_ADDR when the address is in the
> anno_list or conn_list.
>
> Fixes: 8b1c94da1e48 ("mptcp: only send RM_ADDR in nl_cmd_remove")
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/pm_netlink.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 1529ec358815..bf4d96f6f99a 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1515,8 +1515,9 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
> 	struct mptcp_pm_addr_entry *entry;
>
> 	list_for_each_entry(entry, rm_list, list) {
> -		remove_anno_list_by_saddr(msk, &entry->addr);
> -		if (alist.nr < MPTCP_RM_IDS_MAX)
> +		if ((remove_anno_list_by_saddr(msk, &entry->addr) ||
> +		     lookup_subflow_by_saddr(&msk->conn_list, &entry->addr)) &&
> +		    alist.nr < MPTCP_RM_IDS_MAX)
> 			alist.ids[alist.nr++] = entry->addr.id;
> 	}

Looks good to me, thanks Geliang.

Reviewed-by: Mat Martineau <martineau@kernel.org>

