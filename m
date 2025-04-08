Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2372063FA
	for <mptcp@lists.linux.dev>; Tue,  8 Apr 2025 23:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744156273; cv=none; b=gAJ5OQm0pIGbNfgkhNjKlLTVAEmJk0totY7/0d/tiSLlr46z1u7pBEvPKuMOI0K1ovqMQZb6PyMBSbDizHlvzcEgzekVvcYzH3DTF6zTTKNRDnDMUGE5heNVIcSTs1ufx83oQtv2KO1tqiWyLQW/8Plqo2YkAcVITo8smD2kjFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744156273; c=relaxed/simple;
	bh=lHH0VGHkIhdi1niys9in9LmEgK2GTzLI3IYhj8lXfcg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WqQkzGBQDdKI4qZpjwU5SNNN5WadMW17ZTROkwhlxjrvymQP5CqmQj8kT5TA6Y94vyuzA+VguP/oRyv6lacWvSXLru4wiA5YUkAG0Xe4OAuCQ5H/v//Mn+TvKu04RzXtj5pZUQawIavj235tVj2de2diknxz470iFpJ+xtZNgts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGEpVJo4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGEpVJo4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEBFC4CEE5;
	Tue,  8 Apr 2025 23:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744156272;
	bh=lHH0VGHkIhdi1niys9in9LmEgK2GTzLI3IYhj8lXfcg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=WGEpVJo4UhXwMUPP9vYnTZy3h+qEaffBpTgDJilYsSJe+dPhcCPOt4EjVRJ0LUuBc
	 Bv6tWd7YaFEBHdPlwumPmoboJO9z7fAJ49QuFMByhi6jxnF9mvmMI7tMXxqhtwTspU
	 qjJJPHunPXlQ02zxwNpmHBBJOkqLYpZUxI8PZhY5aev3tUNkNfNZjzDfKRN2KfleaG
	 xKeybUGL8nnN7fGyFIT9vm5fDvNbCcr63G1J89Z8vDtrrtwhzziJ1GT7L8eTBz0m4u
	 5eyq8u/s8/eS8RAQr04pBLFGygR0GubzWhi0tfXCeTNuOlllAJv1GyftGjspd0aZg4
	 gFVRO/oH23NNA==
Date: Tue, 8 Apr 2025 16:51:11 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 1/3] mptcp: pm: userspace: local_addr_used--
 after sending REMOVE_ADDR
In-Reply-To: <4f0b16c622b2714069acf8607de0d4e7f0c013ea.1743562290.git.tanggeliang@kylinos.cn>
Message-ID: <aabfdca3-0f10-08d5-98db-d322bab7c87a@kernel.org>
References: <cover.1743562290.git.tanggeliang@kylinos.cn> <4f0b16c622b2714069acf8607de0d4e7f0c013ea.1743562290.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 2 Apr 2025, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Address entries are removed from local_addr_list when sending a REMOVE_ADDR
> by the userspace PM, the local_addr_used counter of PM should also be
> decremented accordingly.
>
> Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> net/mptcp/pm_userspace.c | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 7fc19b844384..db471eb836b3 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -331,6 +331,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
> 	}
>
> 	list_del_rcu(&match->list);
> +	msk->pm.local_addr_used--;
> 	spin_unlock_bh(&msk->pm.lock);
>
> 	mptcp_pm_remove_addr_entry(msk, match);


Hi Geliang -

This should be squashed with patch 2, since it's not bisectable (wouldn't 
want this patch to get cherry-picked without the other, and have the 
variable decremented twice).



- Mat
