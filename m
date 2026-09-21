Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F261F42124A
	for <mptcp@lists.linux.dev>; Mon, 21 Sep 2026 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789987076; cv=none; b=BlU6hBfYiyNqNxhYvav2FCOAva2/z8wbiaOdRrMezu0yiQN6Fzbi0HX+BEUHbpx7gkY9IcleAqeDdNkDVVMgswy/F5mXsnIZ4NC5zw5vp2mLRRbPE9RPi9402TgAjCbr1Hj24ZhIbs/j0pAUC69FXLTSsizQaif3rbDO2+VoSvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789987076; c=relaxed/simple;
	bh=6eDmiPcuVOhymkVKHkVjo5bn+Pp1gTIpM8qGo5CVgnA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i7+b1XdeZcr8fHpeRNa93sbfOQ1UXkz8Hfbn3eipTX0WppS1j0qGOA70EeAupXWbf0SRzPppPQHcZYY37/r1omtDOO/ewDxXDxsc3W6TDtWZQQOCtn3V7gIfICEqGclNP4DGtfMqyGY7kydvJdMdesmw9OelvYF9cEq54fQno5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qkj/pzJG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qkj/pzJG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D37F1F00898;
	Mon, 21 Sep 2026 10:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789987064;
	bh=52OiUg1fhcWvPu5XoR5iwSZgPcW18lItRjiJI5It5Lo=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=Qkj/pzJG9Fw8ypPpp3t0PEfYaIiipLHpoB+5rgmsTvW8h3tdAGAZH5XmH+aCLYN/R
	 4rk58QmRXhz63QsbGTV17bLNnsdRO3ZaszwwCdh4wsqxBVOXSMULIykhwYVD24GcXU
	 SQoAJz1avxiUrbcOOdGT8hRUE9Uh5OsaBvY8Fy4K1UH8iggjG9q27I6uZCZ5q5SDfU
	 uf2wdYUjhQPqPWFJX/9m/9y2jbhFY2BfgDOIdX0lQXkCs4JzCNMrNuyiTDZwKA+Sed
	 pG1VzygG8PO6ttvgdDmaOqvN+zm6PeGCHOlvkOJe+8uSMzrpgRykMzqaXHxUhdDfuI
	 Vssu/Ug9ncv4Q==
Message-ID: <6c672ec640f12ec6d3e4592b89dd91a955ab0581.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v3 3/8] mptcp: pm: userspace: ID0 is not part
 of local_addr_used
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Linux
	 <mptcp@lists.linux.dev>
Date: Mon, 21 Sep 2026 18:37:41 +0800
In-Reply-To: <20260807-mptcp-pm-userspace-id0-case-v3-3-de9088549924@kernel.org>
References: 
	<20260807-mptcp-pm-userspace-id0-case-v3-0-de9088549924@kernel.org>
	 <20260807-mptcp-pm-userspace-id0-case-v3-3-de9088549924@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Fri, 2026-08-07 at 10:41 +0200, Matthieu Baerts (NGI0) wrote:
> The PM's local_addr_used counter doesn't take into account the ID0,
> similar to what is done with the in-kernel PM.
> 
> When deleting a local address, only decrement the counter if it is
> not
> linked to the (initial) ID0. Similarly, do not increment it when
> re-adding the exact same entry.
> 
> Fixes: 77e4b94a3de6 ("mptcp: update userspace pm infos")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> v3:
>  - split from patch 1.
>  - do the same check when incrementing it to avoid a "leak".
> (Sashiko)
>  - use a new dedicated helper, clearer.
> ---
>  net/mptcp/pm_userspace.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 3f1471ec3fc7..27fed3519d39 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -27,6 +27,12 @@ void
> mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk)
>  	}
>  }
>  
> +static bool
> +is_init_id0(struct mptcp_pm_addr_entry *entry)

nit: The function is quite short, so no line wrapping is needed.

Thanks,
-Geliang

> +{
> +	return entry->addr.id == 0 && entry->addr.port == 0;
> +}
> +
>  static struct mptcp_pm_addr_entry *
>  mptcp_userspace_pm_lookup_addr(struct mptcp_sock *msk,
>  			       const struct mptcp_addr_info *addr)
> @@ -95,7 +101,9 @@ static int
> mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
>  							MPTCP_PM_MAX
> _ADDR_ID + 1,
>  							1);
>  		list_add_tail_rcu(&e->list, &msk-
> >pm.userspace_pm_local_addr_list);
> -		msk->pm.local_addr_used++;
> +		/* Just to avoid this counter not to decrease when
> deleted */
> +		if (!is_init_id0(e))
> +			msk->pm.local_addr_used++;
>  		ret = e->addr.id;
>  	} else if (addr_match && id_match) {
>  		ret = entry->addr.id;
> @@ -121,12 +129,15 @@ static int
> mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
>  	if (!entry)
>  		return -EINVAL;
>  
> +	/* The initial address ID doesn't increment local_addr_used
> */
> +	if (!is_init_id0(entry))
> +		msk->pm.local_addr_used--;
> +
>  	/* TODO: a refcount is needed because the entry can
>  	 * be used multiple times (e.g. fullmesh mode).
>  	 */
>  	list_del_rcu(&entry->list);
>  	sock_kfree_s(sk, entry, sizeof(*entry));
> -	msk->pm.local_addr_used--;
>  	return 0;
>  }
>  
