Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE5E10E3
	for <mptcp@lists.linux.dev>; Sat,  6 Jan 2024 00:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnkFd4fc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1CDC433C7;
	Sat,  6 Jan 2024 00:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704502161;
	bh=a+8HbKr7hEJNwxv5U1f+NM1bnhuH5IHA+8yfuSSVNds=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=AnkFd4fcF63Lwlfshv9szi/23XkU9JI/6DvJg7k87vyScVv2KfNC6NJyyAVyTBQja
	 XTA6rW6onSdUlmdlKSzl8hCrLm2xpkCs19+MQ+ePRYn6zGgj6jFDJl8Ry4879YmOAM
	 n9NcExrCps/EwdzD7uYj7B8n+uX12jt5RxPHCNZBNBSqoLE1UriwhTbxbNFUKwkyj8
	 dlArfRF6iXL56RLIoA3CDUZYrYMU02u3y0mGqL2E4jM0jfCw9UY05vOwxaiRw0A4e+
	 7xa5X6AO89mPwSNdB0VlVleR67dfMvzATTDmXPeKAIS5+PmcXQlKTkMemm5n+/7d1i
	 In2jCd/ItOEdw==
Date: Fri, 5 Jan 2024 16:49:21 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@linux.dev>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v7 04/24] mptcp: check addrs list in
 userspace_pm_get_local_id
In-Reply-To: <cabcff63b79e67ee6ea7aca30e6f7bbba38383fe.1703904325.git.geliang.tang@linux.dev>
Message-ID: <c4dbd8a2-3ad3-1104-ef9c-adea4d1d62bd@kernel.org>
References: <cover.1703904325.git.geliang.tang@linux.dev> <cabcff63b79e67ee6ea7aca30e6f7bbba38383fe.1703904325.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sat, 30 Dec 2023, Geliang Tang wrote:

> Before adding a new entry in mptcp_userspace_pm_get_local_id(), it's
> better to check whether this address is already in userspace pm local
> address list. If it's in the list, no need to add a new entry, just
> return it's address ID and use this address.
>

Good idea!

Reviewed-by: Mat Martineau <martineau@kernel.org>

> Fixes: 8b20137012d9 ("mptcp: read attributes of addr entries managed by userspace PMs")
> Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
> ---
> net/mptcp/pm_userspace.c | 13 ++++++++++++-
> 1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index ce8ae7aa5aad..c592536b9889 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -135,10 +135,21 @@ int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
> int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
> 				    struct mptcp_addr_info *skc)
> {
> -	struct mptcp_pm_addr_entry new_entry;
> +	struct mptcp_pm_addr_entry *entry = NULL, *e, new_entry;
> 	__be16 msk_sport =  ((struct inet_sock *)
> 			     inet_sk((struct sock *)msk))->inet_sport;
>
> +	spin_lock_bh(&msk->pm.lock);
> +	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
> +		if (mptcp_addresses_equal(&e->addr, skc, false)) {
> +			entry = e;
> +			break;
> +		}
> +	}
> +	spin_unlock_bh(&msk->pm.lock);
> +	if (entry)
> +		return entry->addr.id;
> +
> 	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
> 	new_entry.addr = *skc;
> 	new_entry.addr.id = 0;
> -- 
> 2.39.2
>
>
>
