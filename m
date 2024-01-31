Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3582DF63
	for <mptcp@lists.linux.dev>; Wed, 31 Jan 2024 02:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706668114; cv=none; b=qHjCvhPXhZnniocuzhvCrdcsdpaG+pb86+whJu7UxtRykZRbbh7WcCY8HrOeltHccAiHis+n/YV4ucoBQgxcRz9Xp7O7cpJ54d1NUvhEvDrZSP5ZkUWdVvbZwgvfEKIOw9+KrKKlFGbjhGKnSr58YU1aIxGAiAndJDS8IxHlxnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706668114; c=relaxed/simple;
	bh=ovT891XfOkanLOlBdUHN5AOP/bKElEfNdCpD3LhhS8U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ThS3EcxRzzZ7qhyHB01lHejL+4hKgrbdaW+46pNal8623hhAmQLB8yHN9lchieVj0wwuG8cXUeV62Txm/yvtc7R+QxoeET/Nn48ntsRbZAUWJw0v3p7fOat4NBMPCkhnA9CPMsfRedqmQ1P4QBSK8JQy31engGcL8C7WA2ddyYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qb3EoycW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qb3EoycW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B80C433C7;
	Wed, 31 Jan 2024 02:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706668114;
	bh=ovT891XfOkanLOlBdUHN5AOP/bKElEfNdCpD3LhhS8U=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Qb3EoycWlpSr5D7q8s7lg7qVJDtKglPVh8oqo+/kJ75ye963Q637TQISbtbqJpmgy
	 C6OGSriitGpB4WNYJ3POkskFADg3Cn7pfc3GzcoVU1SCMSZ4gblSnbGfeiMfWywLln
	 5uKJQNori4BkS362ZM7R8U3zXWFc5wA+fU9S25qRQxQ4uMDYRF4CmUeIxoltbzckEx
	 cgbzBlBo/r0GxMmPpomNFgdHrX2nAvIRcbcML6z83BrCEz1E7rFNEz3XAEknkiExtN
	 Xt/cAdLIGgufxU8u3sP08Ol+CS4YFLx6s1QNazN6l6CFPjzDooidWlptDbJedp+C4j
	 1GgCRjG+3balA==
Date: Tue, 30 Jan 2024 18:28:33 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v10 10/23] mptcp: check userspace pm subflow
 flag
In-Reply-To: <8df3db253cf4e880813e2b499b12887904474736.1705558030.git.tanggeliang@kylinos.cn>
Message-ID: <38c3cf2e-ba53-b30f-cf2c-e39d793851f2@kernel.org>
References: <cover.1705558030.git.tanggeliang@kylinos.cn> <8df3db253cf4e880813e2b499b12887904474736.1705558030.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 18 Jan 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Just like MPTCP_PM_ADDR_FLAG_SIGNAL flag is checked in userspace PM
> announce mptcp_pm_nl_announce_doit(), MPTCP_PM_ADDR_FLAG_SUBFLOW flag
> should be checked in mptcp_pm_nl_subflow_create_doit() too.
>
> If MPTCP_PM_ADDR_FLAG_SUBFLOW flag is not set, there's no flags field
> in the output of dump_addr. This looks a bit strange:
>
> 	id 10 flags  10.0.3.2
>
> This patch uses mptcp_pm_parse_entry() instead of mptcp_pm_parse_addr()
> to get the flags of the entry. Add MPTCP_PM_ADDR_FLAG_SUBFLOW flag check
> in mptcp_pm_nl_subflow_create_doit().
>

Hi Geliang -

Have you tested this change with mptcpd?

Is the addr flag (SUBFLOW or SIGNAL) relevant for userspace PM addresses? 
It doesn't seem like a useful distinction: the userspace PM is always 
creating a new subflow in this context, since address signaling is handled 
by mptcp_pm_nl_announce_doit().

Two options I see:
  * update the userspace tools to cleanly handle missing flags for 
userspace connections
or
  * have mptcp_pm_nl_subflow_create_doit() always set 
MPTCP_PM_ADDR_FLAG_SUBFLOW for the local addr even if it's missing from 
the netlink attribute (and maybe don't allow MPTCP_PM_ADDR_FLAG_SIGNAL?)

- Mat


> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> net/mptcp/pm_userspace.c | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index f1582f40f70e..ca0d6e1dfade 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -361,11 +361,18 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
> 		goto create_err;
> 	}
>
> -	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
> +	err = mptcp_pm_parse_entry(laddr, info, true, &local);
> 	if (err < 0) {
> 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
> 		goto create_err;
> 	}
> +	addr_l = local.addr;
> +
> +	if (!(local.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)) {
> +		GENL_SET_ERR_MSG(info, "invalid addr flags");
> +		err = -EINVAL;
> +		goto create_err;
> +	}
>
> 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
> 	if (err < 0) {
> @@ -379,7 +386,6 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
> 		goto create_err;
> 	}
>
> -	local.addr = addr_l;
> 	err = mptcp_userspace_pm_append_new_local_addr(msk, &local,
> 						       !mptcp_pm_has_addr_attr_id(laddr, info));
> 	if (err < 0) {
> -- 
> 2.40.1
>
>
>
