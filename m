Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015A6AD24
	for <mptcp@lists.linux.dev>; Wed, 11 Sep 2024 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726043134; cv=none; b=Ln2GOqAY+JF+ycr42C4gypBStpn3M945Z3SMMNcRYlfZygpXTpsN/mNVstDDssRB1uNH7jy2Jhf2FDH1pYUHAsTV8bskfSo1vrtpifGs+gA3uw00p5Q3/hOOMGjpMGq8adI3xZKJGlg+xyxCwlmQWVUVHPaX/ugcwPRbv5NqSi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726043134; c=relaxed/simple;
	bh=1eMm0683JOAXoLqXx2ETU47Z4cfqGUnFu+iE37ACNao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CtjEEigTob9SPRxevoI57XOgKeRH3qQbnEIKRP8d9R+lKqDqtEE6rW3soQ+tUV9y94a4YBe5kWd2+l20QGx9oFXYCrSYe456r1MDCaV+pTCNjgdXpno9q+EhjTdy3i8XpahHSdIlZNPrknbf2XmZ0WwEX6v7IDc+YV8O6EM24Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhzF7oZE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhzF7oZE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14078C4CEC6;
	Wed, 11 Sep 2024 08:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726043133;
	bh=1eMm0683JOAXoLqXx2ETU47Z4cfqGUnFu+iE37ACNao=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GhzF7oZEhKhAEyfKSkwleSoq29Mdiftv9zl6HTRfBe6nYpAexWnXUETLD84FkjVRs
	 W74LZc30KlfcbwsbWJb4EgBz3EPwbJN6dmz+YHQ0zkv+T6WZOLs1WCZ3X8w8Am7YGw
	 grjN5tEnqyAIsYKZb1MJwx+Mcp6GDCTytLIqhJzwF7ZivAdUHvWx/lYhQm9L3eXFG3
	 NVXMswH18bQlIhs2eZfi9vi840QlIV67GcbKPzgC/l/FswHP/QzFHRw0ivPRKEC15Q
	 Hq+PCG2ImEtC0lf99O29l2n7Qn4ao7MvsukZtpNuho3sllF7keQ18zrTwLipg1VuuE
	 X/NLQfXzOXq6g==
Message-ID: <81746edb-cf37-4c36-b23a-3aee2a6bd995@kernel.org>
Date: Wed, 11 Sep 2024 10:25:30 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [Patch net v2] mptcp: initialize sock lock with its own lockdep
 keys
Content-Language: en-GB
To: Cong Wang <xiyou.wangcong@gmail.com>, mptcp@lists.linux.dev
Cc: Cong Wang <cong.wang@bytedance.com>,
 syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
References: <20240911042425.978665-1-xiyou.wangcong@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240911042425.978665-1-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Cong Wang,

On 11/09/2024 06:24, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> In mptcp_pm_nl_create_listen_socket(), we already initialize mptcp sock
> lock with mptcp_slock_keys and mptcp_keys. But that is not sufficient,
> at least mptcp_init_sock() and mptcp_sk_clone_init() still miss it.
> 
> As reported by syzbot, mptcp_sk_clone_init() is challenging due to that
> sk_clone_lock() immediately locks the new sock after preliminary
> initialization. To amend that, introduce ->init_clone() for struct proto
> and call it right after the sock_lock_init(), so now mptcp sock could
> initialize the sock lock again with its own lockdep keys.
> 
> This patch does not fix any real deadlock, it only makes lockdep happy.
> 
> Fixes: 58b09919626b ("mptcp: create msk early")
> Reported-by: syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f4aacdfef2c6a6529c3e
> Cc: Matthieu Baerts <matttbe@kernel.org>
> Cc: Mat Martineau <martineau@kernel.org>
> Cc: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---
> v2: Address Matthieu's comments

Thank you for the v2!

(...)

> diff --git a/net/core/sock.c b/net/core/sock.c
> index 9abc4fe25953..747d7e479d69 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2325,6 +2325,8 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
>  	}
>  	sk_node_init(&newsk->sk_node);
>  	sock_lock_init(newsk);
> +	if (prot->init_clone)
> +		prot->init_clone(newsk);
As mentioned on the v1, if the idea is to introduce a new hook here,
maybe it can replace the call to sock_lock_init() when this new function
pointer is defined. In this case, it could be renamed 'lock_init' or
'init_lock'. But no need to send a new version for the moment, please
see below.

I suggest the following plan if that OK: because the initial report was
a false positive, there are modification of the core, and because we are
a bit in the middle of other things, I suggest not rushing up with this
patch. We can look at it in more details when the other things will calm
down, very likely in ~2 weeks, after LPC.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

