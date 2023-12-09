Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0577F8
	for <mptcp@lists.linux.dev>; Sat,  9 Dec 2023 01:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIx1xpBw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93BAC433C8;
	Sat,  9 Dec 2023 01:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702084678;
	bh=sy+Do6fn/WhxVmD1IYxwtYK9lUzPvt+HwEKiCL/wv4I=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=YIx1xpBw9zghQqYpvYri8szFdwAVbHWcHBIXM3K6fFLUr6zpQ4eXrtXiR7J731NH4
	 RKewmwCZJAjYW75dcrbMnPxYjl1Y3r9yrOqDffng7D9YWbnDuZE6APtAeUPVO4E0se
	 WqVqA8yrED+WpZaaTdECVeRko9um54gXtwHm2wtz/KWseeQz158cHAZeNlYqTzhQYW
	 IqQDRyCWC6F0D+RywFrl4fSQ1UiLo50HjbqHt9Za3WP9G2NHSdnk1lOg60JsII0DUJ
	 iiNR7TF23EwW0+Ap1p6+vTq8/7tdlDsYtnNWyhWSoYYo/IwdV6ZmobqWiVGT0V06L1
	 flAjxozDO6bQw==
Date: Fri, 8 Dec 2023 17:17:58 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@linux.dev>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v14 03/25] mptcp: use pernet id_bitmap in
 userspace pm
In-Reply-To: <0a089c38b045c6bed01d4a7f53d9a14aa960ea34.1702029538.git.geliang.tang@linux.dev>
Message-ID: <54a15ecd-2d4d-dc54-bb4c-d46eb3402bef@kernel.org>
References: <cover.1702029538.git.geliang.tang@linux.dev> <0a089c38b045c6bed01d4a7f53d9a14aa960ea34.1702029538.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 8 Dec 2023, Geliang Tang wrote:

> This patch uses pm_nl_get_pernet_from_msk() to get the pernet id_bitmap
> instead of using a local bitmap when appending a new local address into
> the userspace PM local address list.
>

Please drop this patch.

The pernet bitmap is relevant for the netlink PM, as it shares address IDs 
across the namespace. Userspace PMs may have different local address IDs 
for each MPTCP connection.

- Mat

> Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
> ---
> net/mptcp/pm_userspace.c | 8 +++-----
> 1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index efecbe3cf415..b3a606a5e182 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -28,7 +28,7 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
> static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
> 						    struct mptcp_pm_addr_entry *entry)
> {
> -	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
> +	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
> 	struct mptcp_pm_addr_entry *match = NULL;
> 	struct sock *sk = (struct sock *)msk;
> 	struct mptcp_pm_addr_entry *e;
> @@ -36,8 +36,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
> 	bool id_match = false;
> 	int ret = -EINVAL;
>
> -	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
> -
> 	spin_lock_bh(&msk->pm.lock);
> 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
> 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
> @@ -50,7 +48,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
> 		} else if (addr_match || id_match) {
> 			break;
> 		}
> -		__set_bit(e->addr.id, id_bitmap);
> 	}
>
> 	if (!match && !addr_match && !id_match) {
> @@ -65,9 +62,10 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
>
> 		*e = *entry;
> 		if (!e->addr.id)
> -			e->addr.id = find_next_zero_bit(id_bitmap,
> +			e->addr.id = find_next_zero_bit(pernet->id_bitmap,
> 							MPTCP_PM_MAX_ADDR_ID + 1,
> 							1);
> +		__set_bit(e->addr.id, pernet->id_bitmap);
> 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
> 		msk->pm.local_addr_used++;
> 		ret = e->addr.id;
> -- 
> 2.35.3
>
>
>
