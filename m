Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A0441C6A
	for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 06:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787898081; cv=none; b=azEpKoBp/HY/l/jkWV7N7Ez+b/y3ECEfDHN+kb3OuVAS6hM0s6tyJAhQd1besU9OusX8D2h8FwUZNkx+UB68WvP35W3gp4OX36xqdP7f4FHshs57PynS5D/wI3l8T0EPaCvYPzE2u/8GfW/vyDtCho2CBRdJu9+OBcfBHgYNn7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787898081; c=relaxed/simple;
	bh=JvvJo/URGk+GScyuLSrPKaFg3MUFIQDr/fp/N7gYrKc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ODq+xOxvMBW8p3p73pHyEJnEBt75I4x0KEkPZafh63XhC05BbidRE7iYhIqOi9gAdvF9qSeolbG2681z4HuvT91kcNSz/0YzNXgiPjeP457Y3ZlNlQ110Q3ftAat7uCrA/H53gwgbYVDBKuDOIpoNjfGMJ/HHO9VGnsyN8f+h+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaemMOAf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaemMOAf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A421F000E9;
	Fri, 28 Aug 2026 06:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787898079;
	bh=hY/kT08c+Zkl1RpGcrN+rNe060cUjUTISIVzGmUO4Ds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KaemMOAfedYptryUE+H1IQYQPLSj93SF40ZsBZAC+M56I9uQlw8P6hrXupL2p+wK1
	 uqPsoNWl6hKUtz0LqHCB55CAci1qoQmzbc7e9kH9M74nw0oM3tcs8NZ760J9CDCfoG
	 YS1QOWBLWVVhNlHCsi/wthxtoG2hhOcdTC906Ip04C7m1mcTudaw7g9El1lJC2IuH7
	 ws+xc4M6bK9yBQBlUdb5TGooiIqOuJUCXg7khPEdTwp/zV/P3T7ZOj+AcU9TuyYqXW
	 00Q4GIHz8l1luEGvN9yw317EHy3jCHq8o8iIbcL/qQriHbBX3wcYmkAEfxgxg0D4NE
	 HlLgEqhaRcmuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v5 6/6] Squash to previous one
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gang Yan" <gang.yan@linux.dev>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260828060643.14397-7-gang.yan@linux.dev>
References: <20260828060643.14397-1-gang.yan@linux.dev>
 <20260828060643.14397-7-gang.yan@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 06:21:19 +0000
Message-Id: <20260828062119.B2A421F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] BPF Path Manager per-socket resources leak on socket disconnect or=
 PM swap due to omitted `release()` callback.
--

commit 2b82d535eb907aa1641a5d2cebbd47571b430146
Author: Gang Yan <yangang@kylinos.cn>
Subject: Squash to previous one

This commit updates the MPTCP Path Manager operations to use RCU
protection for the pm.ops pointer. It modifies the assignment,
dereferencing, and cleanup paths to follow RCU reader/writer disciplines
and handle concurrent socket operations.

Link: https://sashiko.dev/#/patchset/20260819125629.49823-1-gang.yan@linux.=
dev?part=3D5

> Note also that the swap path does not call old->release() and that
> init() runs again when the ops is unchanged: the per-socket PM
> resources are already freed by mptcp_pm_destroy() before the reset
> swaps the ops, and mptcp_pm_kernel_init() only re-sets flags from
> the current sysctl, it does not allocate.

[Severity: High]
Does this assumption hold true for custom BPF-based path managers?

While mptcp_pm_destroy() cleans up the in-tree kernel PM resources, it
would not free custom BPF map allocations if the PM's release() callback is
skipped.

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c

[ ... ]

> @@ -1158,23 +1166,41 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
>  static void mptcp_pm_ops_init(struct mptcp_sock *msk,
>  			      struct mptcp_pm_ops *pm_ops)
>  {

[ ... ]

> +	if (need_sync)
> +		synchronize_rcu();
> +	if (old)
> +		bpf_module_put(old, old->owner);
> +
> +	if (pm_ops->init)
> +		pm_ops->init(msk);

[Severity: High]
Since the swap path skips calling old->release(), can this cause an
unbounded memory leak if a socket is repeatedly disconnected and
reconnected?

An unprivileged local user can repeatedly call connect(AF_UNSPEC) followed
by connect() on an MPTCP socket. This triggers mptcp_pm_data_reset() which
calls mptcp_pm_ops_init() again. If a custom BPF PM allocates resources in
its init() callback, those resources will leak each time the socket is
disconnected and reinitialized.

>  	pr_debug("pm %s initialized\n", pm_ops->name);
>  }

[ ... ]

> @@ -1195,8 +1221,6 @@ void mptcp_pm_destroy(struct mptcp_sock *msk)
>  	 * can be reused (mptcp_disconnect()) and re-selected to a different PM
>  	 */
>  	mptcp_userspace_pm_free_local_addr_list(msk);
> -
> -	mptcp_pm_ops_release(msk);
>  }

[Severity: High]
By removing the mptcp_pm_ops_release() call from mptcp_pm_destroy() in
net/mptcp/pm.c, does this prevent custom BPF path managers from freeing
their per-socket resources when an MPTCP socket is disconnected?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828060643.1439=
7-1-gang.yan@linux.dev?part=3D6
