Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC4B14BF8F
	for <mptcp@lists.linux.dev>; Mon,  1 Jul 2024 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719857302; cv=none; b=aKJ0OI9KCrdua0inWX8UvFwOwIU9znmyfKYzYCGzz58yyprla9uitbvTLu46Hv2u6I0nFok78fKIgsFL8O8bQAVk8WVYkWIZEi9fupfEBUhqEFAVgX+KIyBC7kk9L7Sj8pf/ZlsdwRb/aMfKLZtP6kvNyMkEzV/YE/M5IuTvjH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719857302; c=relaxed/simple;
	bh=UoWMiY/Ep6dxA8A3NFNN7a8ZgdEDkxy3oZXrsjMr/KU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ePpPIIeEfItnQ8O4K8ZCp237KXn/ndtC50yEgbV04vq5O/YU04ZhyNZwtHhqGlfCVKLvJXuCvFI8fGbCx1KyvPnlp0lKd7fr0kgTT/23J1lS23gngA9/vAiZCav939r9qqtP9U6X5Hx0SnfNfwU68zhmtBb+4DIbGE480GBTCJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfJYkTTi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfJYkTTi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019D1C116B1;
	Mon,  1 Jul 2024 18:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719857302;
	bh=UoWMiY/Ep6dxA8A3NFNN7a8ZgdEDkxy3oZXrsjMr/KU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=HfJYkTTiicFIAprRCp5+VOvS8wjleee9HfBI3yFkgOMUp0+PGFJBFw5hDdK00TTPX
	 c7VxBSlD1ngO/hFlUI1uMVE4tyIA9sor2lLKa7G9DlxKR/RLJadRuDPTnlYOv4Lqoa
	 NDmHcGAupVNz59NxhwoXphx2YarTHBi4k7bP3jtAK0ibxsnMbz8OivcqRXp2wRW1YS
	 PFamNCLLDAVfGX7KqScpfCpK4zIDdZkgHiUpV/YD+rQpZ7AygnQA0M/GAPbME3jdM5
	 uwGU9p1kXWcz3hO90ybccykL+KgUfR8xVfN/wU8avxhmmOFH2uwaSRNv+H5OaaxkfY
	 ZnmyDoktN6Xbw==
Date: Mon, 1 Jul 2024 11:08:21 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 1/3] mptcp: fix announced address accounting
In-Reply-To: <4a8ac95282ec2b551a64134f24b2e2fd7d82973c.1719589916.git.pabeni@redhat.com>
Message-ID: <f5abcf0d-1ca3-5601-3159-2d553f3591c4@kernel.org>
References: <cover.1719589916.git.pabeni@redhat.com> <4a8ac95282ec2b551a64134f24b2e2fd7d82973c.1719589916.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 28 Jun 2024, Paolo Abeni wrote:

> Currently the per connection announced address counter is never
> decreased. As a consequence, after connection establishment, if
> the NL PM deletes an endpoint and adds a new/different one, no
> additional subflow is created for the new endpoint even if the
> current limits allow that.
>
> Address the issue properly updating the signaled address counter
> every time one of such address is removed.
>
> Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> slightly unrelated: is unclear to me why mptcp_pm_remove_addrs() does
> things slightly differently from mptcp_pm_remove_addrs_and_subflows(),
> with the latter IMHO doing the right thing (TM)

Hi Paolo -

I don't remember why mptcp_pm_remove_addrs() has the extra code to send 
the RM_ADDR for addresses that are in the conn_list but not the anno_list. 
Maybe to allow a way to sent RM_ADDR as a "request for the peer to 
initiate a disconnect" even on implicitly added address IDs (from outgoing 
subflow connections instead of ADD_ADDRs)?

> ---
> net/mptcp/pm_netlink.c | 27 +++++++++++++++++++--------
> 1 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index ea9e5817b9e9..624f9ea66aea 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1401,6 +1401,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
> 	ret = remove_anno_list_by_saddr(msk, addr);
> 	if (ret || force) {
> 		spin_lock_bh(&msk->pm.lock);
> +		msk->pm.add_addr_signaled--;

Looks like this only be decremented if ret is true, since that indicates a 
list element was removed and add_addr_signaled is supposed (?) to track 
the length of the anno_list.


- Mat

> 		mptcp_pm_remove_addr(msk, &list);
> 		spin_unlock_bh(&msk->pm.lock);
> 	}
> @@ -1534,16 +1535,25 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
> {
> 	struct mptcp_rm_list alist = { .nr = 0 };
> 	struct mptcp_pm_addr_entry *entry;
> +	int anno_nr = 0;
>
> 	list_for_each_entry(entry, rm_list, list) {
> -		if ((remove_anno_list_by_saddr(msk, &entry->addr) ||
> -		     lookup_subflow_by_saddr(&msk->conn_list, &entry->addr)) &&
> -		    alist.nr < MPTCP_RM_IDS_MAX)
> -			alist.ids[alist.nr++] = entry->addr.id;
> +		if (alist.nr >= MPTCP_RM_IDS_MAX)
> +			break;
> +
> +		/* only delete if either announced or matching a subflow */
> +		if (remove_anno_list_by_saddr(msk, &entry->addr))
> +			anno_nr++;
> +		else if (!lookup_subflow_by_saddr(&msk->conn_list,
> +						  &entry->addr))
> +			continue;
> +
> +		alist.ids[alist.nr++] = entry->addr.id;
> 	}
>
> 	if (alist.nr) {
> 		spin_lock_bh(&msk->pm.lock);
> +		msk->pm.add_addr_signaled -= anno_nr;
> 		mptcp_pm_remove_addr(msk, &alist);
> 		spin_unlock_bh(&msk->pm.lock);
> 	}
> @@ -1556,17 +1566,18 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
> 	struct mptcp_pm_addr_entry *entry;
>
> 	list_for_each_entry(entry, rm_list, list) {
> -		if (lookup_subflow_by_saddr(&msk->conn_list, &entry->addr) &&
> -		    slist.nr < MPTCP_RM_IDS_MAX)
> +		if (slist.nr < MPTCP_RM_IDS_MAX &&
> +		    lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
> 			slist.ids[slist.nr++] = entry->addr.id;
>
> -		if (remove_anno_list_by_saddr(msk, &entry->addr) &&
> -		    alist.nr < MPTCP_RM_IDS_MAX)
> +		if (alist.nr < MPTCP_RM_IDS_MAX &&
> +		    remove_anno_list_by_saddr(msk, &entry->addr))
> 			alist.ids[alist.nr++] = entry->addr.id;
> 	}
>
> 	if (alist.nr) {
> 		spin_lock_bh(&msk->pm.lock);
> +		msk->pm.add_addr_signaled -= alist.nr;
> 		mptcp_pm_remove_addr(msk, &alist);
> 		spin_unlock_bh(&msk->pm.lock);
> 	}
> -- 
> 2.45.1
>
>
>
