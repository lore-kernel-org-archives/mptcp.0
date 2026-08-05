Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B789C42CAE4
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927564; cv=none; b=BxRGdOQnGd/kE8os+ApBetVFFvLnv1+Axbuzhu7VzLyvkFd15jgOfLR5wq8EgRBNyRb+BCTHrQQ93CdsQnu0ujTFZLWp7vNl8UhbF4+Q+8YThusp8hG6x1UMDSn/K9/Sl6Iji4CeGOcET81arYcEMsPIxQvt+YJ6l9pGPgJa6pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927564; c=relaxed/simple;
	bh=TW/JaYTXsmYOrBXQk7dkVPpBLt6irLnJmxKvh2XsQko=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=FU0tgf+hnIYtdQZdzR3wRxK6NvW7sHnf/EEOP9lcMxtQ4wBcdpZAoct9gDtq8HFXtAERDvayllLb5fL+L3ZjI6/AdOuiSHHvF5dyJXTU42E9w0JT7s1riAi+fhLkanUWC//hgxUzjI0DJRUJBtpJIj5wP/inL0YoRYMPeXwtYNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azn8Ve2g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azn8Ve2g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F29C1F000E9;
	Wed,  5 Aug 2026 10:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785927558;
	bh=4Fs742gZStzLLo+sv3NhKyveLt65cbKoogVVYbB4BIo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=azn8Ve2gVB+pD/HpR4zdm+7CSC3lpjhVbK6x8IZx75XnbO4aY2gxoJEXoMHtaWKN/
	 tsgG2fPibmT0ujPeclN3hBlcDm4A/yfVWQk0eGe1S+O5wVR51re76dzBZEI8BvMQE7
	 k26mWMeGpvGMTBqO5Yewjnh2ErfBHK8cyUu8eeTTDpukT8qR8Irx2Lcer2QaeM3c1x
	 +dg9xHcKil7+oE+LWXpmWPKQTgp2hJBkBk6wSSHUalv6SSQyqm0C5BQ+G3mT4Pwhgd
	 p70HM6w9L3hVVl0MeMgFZnanrzNXwLCwaC1WeT3uXVRRsLBksvFsCJvFhbncSLugKX
	 PMzdk69QetcpQ==
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH mptcp-net v3] mptcp: pm: fix userspace PM address ID
 overflow when all IDs are exhausted
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: luoqing <l1138897701@163.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260805070926.716768-1-l1138897701@163.com>
References: <20260805070926.716768-1-l1138897701@163.com>
Date: Wed, 05 Aug 2026 12:59:12 +0200
Message-Id: <178592755221.893374.4684461763598171085.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3496; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=TW/JaYTXsmYOrBXQk7dkVPpBLt6irLnJmxKvh2XsQko=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLKKxVufS39cKb7GPf1Y4fX7f89z3imIPBTtF7H4Yqzgu
 7y0DVM0O0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYS+4fhr+Tbg/3veKcI8hd5
 sH3jKzm6+t01zT189ef3bOWY0OK98zojw8c21eB15y6vDdyzz93P7ymft9X+sjSxHaGfRHsFDI9
 /YAUA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Hi luoqing,

> When all MPTCP address IDs (1-255) are exhausted in the userspace PM,
> find_next_zero_bit() returns MPTCP_PM_MAX_ADDR_ID + 1 (256). This value
> overflows when stored in the u8 field e->addr.id, resulting in ID 0
> being stored and the entry being incorrectly added to the list.
>
> ID 0 is reserved for the initial connection in MPTCP, so this overflow
> can cause address conflicts.
>
> Note: the in-kernel PM already has an 'endpoints == MPTCP_PM_MAX_ADDR_ID'
> check in mptcp_pm_nl_append_new_local_addr() that returns -ERANGE before
> reaching find_next_zero_bit(), preventing this overflow. So this fix only
> addresses the userspace PM path.
>
> Store the find_next_zero_bit() result in a temporary unsigned int, check
> against MPTCP_PM_MAX_ADDR_ID, and return -ENOSPC if all IDs are truly
> exhausted. Properly free the allocated entry with sock_kfree_s() on error.

Thank you for the new version.

> Fixes: 4638de5aefe5 ("mptcp: handle local addrs announced by userspace PMs")
> Assisted-by: LLM
> Signed-off-by: Qing Luo <luoqing@kylinos.cn>

(...)

> Based on your feedback, I will withdraw this patch submission. The core fix
> for the ID overflow is valid, but my patch became muddled with an unnecessary
> and potentially harmful behavioral change.
>
> If you believe the core fix (checking find_next_zero_bit's return value
> against MPTCP_PM_MAX_ADDR_ID) is still worth submitting on its own, I can
> prepare a clean v3 that only contains that fix and removes the needs_id logic
> change. Otherwise, I am happy to let this go.

I'm sorry, this is confusing: this is the v3 with only the (valid) fix,
no?

Do you have issues to send replies to my previous emails? Because
sending your replies here at the end of a patch is unusual, and these
comments are stripped when replying to an existing email.

>
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 945aa5afc2dd..7d0e343c35ed 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -74,10 +74,17 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
>  			goto append_err;
>  		}
>
> -		if (!e->addr.id && needs_id)
> -			e->addr.id = find_next_zero_bit(id_bitmap,
> -							MPTCP_PM_MAX_ADDR_ID + 1,
> -							1);
> +		if (!e->addr.id && needs_id) {
> +			unsigned int id = find_next_zero_bit(id_bitmap,
> +							     MPTCP_PM_MAX_ADDR_ID + 1,
> +							     1);
> +			if (id > MPTCP_PM_MAX_ADDR_ID) {
> +				sock_kfree_s(sk, e, sizeof(*e));
> +				ret = -ENOSPC;
> +				goto append_err;
> +			}
> +			e->addr.id = id;
> +		}

The fix looks good to me, but I wonder if it wouldn't make more sense to
check this before allocating 'e', no?

e.g.

	if (!addr_match && !id_match) {
		struct mptcp_pm_addr_entry *e;
		unsigned int id;

		if (!entry->addr.id && needs_id) {
			id = find_next_zero_bit(id_bitmap,
						MPTCP_PM_MAX_ADDR_ID + 1, 1);
			if (id > MPTCP_PM_MAX_ADDR_ID) {
				ret = -ENOSPC;
				goto append_err;
		  	}
		} else {
			id = entry->addr.id;
		}

		e = sock_kmemdup(sk, entry, sizeof(*entry), GFP_ATOMIC);
		if (!e) {
			ret = -ENOMEM;
			goto append_err;
		}

		e->addr.id = id;
		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
		msk->pm.local_addr_used++;
		ret = e->addr.id;

WDYT?

A bit more code, but we avoid having to handle the free.

-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>
