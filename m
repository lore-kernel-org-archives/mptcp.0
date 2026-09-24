Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CD4438484
	for <mptcp@lists.linux.dev>; Thu, 24 Sep 2026 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790236411; cv=none; b=czYasa2oH8uHm64pSnYObRozzTGFoSeizJOUfR/mQAf2AqwO68bq1HYqqc6nekDfkrRDDwZVXQDXsgeKqrLd5IiwKahfygaX+qSfKef6LQLcZQFcdpm5k0z3d4H2keSmty3CFy54v5nj0/NaEvcF6JH0iASSsfWQ3KyabpFHLIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790236411; c=relaxed/simple;
	bh=P/4DbA34LJ+yuxuIZUvZkl5YifQBjdWhnHLd+rL7WMc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QLwEM54ZUPDLjDzaP1ce9KuqSchw59s4xwYULQRif4NTkLK0zh6HEvcsDfwNG1hXLqFEG/rJEdecPQXJlqZdwzZIurjrkKUUI46mnjJ84m6DSxUZDO2bPYDVXDCqFgWjYEh6JLVe3vNl+BqUAkWhA1kL+AWanKSWTijuIP3Hbkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ii6akT1Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ii6akT1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A891F000FF;
	Thu, 24 Sep 2026 07:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790236409;
	bh=YKYFmQC506eBUeqGJKcV97qX9bWz/36ANY5GQ+X8NZo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ii6akT1Qbe8A1qBqmjSn0PgvqYeRCzdvvD3HdwtcHj9R2Sj85MKHg79WTTUL96xmU
	 zMG8L8hl2LuJGA6ed5XC5hSzIefiSeNJdwInwcGa1/j30lmX6iz/6K0GI6F9qHHReM
	 TS0Bbld7AZQKrcoJG5h8Dl+Ibk9bY7xB4eOeqtOQgYQfYnImUKaE18SDUcRMtq7pNw
	 Ixe/rLcbiwaYVHhi8FE9jCcSJByMIUUKIpFqsqYBBhCBmXQcaiRtmPUdVI9dQ9zInp
	 631aVRJ61OeaDiV4kyYnAFBX/mbUGgmjCXGzul+9KrxRQHH7qRTPrPkznD4hmAIuoA
	 dNhMCrp8Xt7Yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC -next 1/5] net: charge socket memory budget to memcg
 upfront
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: mptcp@lists.linux.dev, mkoutny@suse.com, hannes@cmpxchg.org, tj@kernel.org
In-Reply-To: <20260924080219.1036588-2-caixinchen1@huawei.com>
References: <20260924080219.1036588-1-caixinchen1@huawei.com>
 <20260924080219.1036588-2-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 07:53:29 +0000
Message-Id: <20260924075329.97A891F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] net: signed integer overflow in sk_memcg_budget_pages() causes=
 page_counter underflow
- [High] memcg: socket memory limit bypass via failed upfront budget charges
- [High] net: severe performance regression due to unconditional spinlock i=
n sk_memcg_budget_shrink
--

commit 65e9a0129c5179019bbc18d067e00520728a605c
Author: Cai Xinchen <caixinchen1@huawei.com>
Subject: net: charge socket memory budget to memcg upfront

This commit changes the socket memory accounting model to charge the entire
socket memory budget to the memcg upfront, rather than per allocation. It
adds a tracking field to the socket struct to record this budget and issues
refunds when the budget shrinks or the socket is destroyed. The goal is to
avoid racy read-modify-write refunds that previously caused memcg page
counter underflows.

> diff --git a/include/net/sock.h b/include/net/sock.h
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
[ ... ]
> @@ -1622,6 +1634,12 @@ static inline void sk_mem_reclaim(struct sock *sk)
>  	if (!sk_has_account(sk))
>  		return;
> =20
> +	/* Return the part of the memcg budget charge that a budget
> +	 * shrink (by any writer) no longer backs. Never charges, so
> +	 * it is safe to call locklessly from skb destructors.
> +	 */
> +	sk_memcg_budget_shrink(sk);
> +

[Severity: High]
Is it safe to invoke this lock-heavy function on the hot path? During SKB
frees in tcp_wmem_free_skb(), this is called extremely frequently.

>  	reclaimable =3D sk->sk_forward_alloc - sk_unused_reserved_mem(sk);
> =20
>  	if (reclaimable >=3D (int)PAGE_SIZE)
> diff --git a/net/core/sock.c b/net/core/sock.c
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
[ ... ]
> @@ -1349,6 +1360,10 @@ int sk_setsockopt(struct sock *sk, int level, int =
optname,
>  		sk->sk_userlocks |=3D SOCK_SNDBUF_LOCK;
>  		WRITE_ONCE(sk->sk_sndbuf,
>  			   max_t(int, val * 2, SOCK_MIN_SNDBUF));
> +		/* Charge the new budget to the memcg (or refund the
> +		 * released one).
> +		 */
> +		sk_memcg_budget_sync(sk, gfp_memcg_charge());
>  		/* Wake up sending tasks if we upped the value. */
>  		sk->sk_write_space(sk);
>  		break;

[Severity: High]
Does ignoring the return value of sk_memcg_budget_sync() allow the socket
buffer to expand even if the memcg charge fails?

[ ... ]
> @@ -3334,15 +3362,12 @@ EXPORT_SYMBOL(sk_wait_data);
>   *
>   *	Similar to __sk_mem_schedule(), but does not update sk_forward_alloc.
>   *
> - *	Unlike the globally shared limits among the sockets under same protoc=
ol,
> - *	consuming the budget of a memcg won't have direct effect on other one=
s.
> - *	So be optimistic about memcg's tolerance, and leave the callers to de=
cide
> - *	whether or not to raise allocated through sk_under_memory_pressure() =
or
> - *	its variants.
> + *	Charges the global protocol counter only. The memcg is charged for
> + *	the socket's full memory budget when that budget is established or
> + *	resized (see sk_memcg_budget_sync()), not per allocation.
>   */
>  int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kin=
d)
>  {
> -	bool memcg_enabled =3D false, charged =3D false;
>  	struct proto *prot =3D sk->sk_prot;
>  	long allocated =3D 0;
> =20
> @@ -3351,13 +3376,6 @@ int __sk_mem_raise_allocated(struct sock *sk, int =
size, int amt, int kind)
>  		allocated =3D sk_memory_allocated(sk);
>  	}
> =20
> -	if (mem_cgroup_sk_enabled(sk)) {
> -		memcg_enabled =3D true;
> -		charged =3D mem_cgroup_sk_charge(sk, amt, gfp_memcg_charge());
> -		if (!charged)
> -			goto suppress_allocation;
> -	}
> -
>  	if (!allocated)
>  		return 1;

[Severity: High]
Since the dynamic per-page memcg charging is completely removed here, if
the upfront charge in sk_setsockopt() fails, is there any fallback memcg
limit enforcement? It seems a container could bypass its memory cgroup
limits and consume unbounded amounts of host memory if this is the case.

[ ... ]
> @@ -3505,20 +3514,150 @@ void __sk_mem_reclaim(struct sock *sk, int amoun=
t)
>  }
>  EXPORT_SYMBOL(__sk_mem_reclaim);
> =20
> -void __sk_charge(struct sock *sk, gfp_t gfp)
> +/* Pages of the socket's currently established memory budget: the send
> + * and receive buffers plus the SO_RESERVE_MEM reservation.
> + */
> +static int sk_memcg_budget_pages(const struct sock *sk)
>  {
> -	int amt;
> +	long budget =3D READ_ONCE(sk->sk_sndbuf) + READ_ONCE(sk->sk_rcvbuf) +
> +		      READ_ONCE(sk->sk_reserved_mem);
> =20

[Severity: Critical]
Can this addition of 32-bit signed integers overflow before the assignment
to long? If a user increases the socket's send and receive buffers to large
values, their sum could overflow 32-bit arithmetic, resulting in a negative
value being sign-extended to long budget.

> -	gfp |=3D __GFP_NOFAIL;
> -	if (mem_cgroup_from_sk(sk)) {
[ ... ]
> +void sk_memcg_budget_shrink(struct sock *sk)
> +{
> +	int want, refund =3D 0;
> +
> +	if (!mem_cgroup_sk_enabled(sk) || !sk_has_account(sk))
> +		return;
> +
> +	/* Claim the excess under the lock, then refund it outside:
> +	 * the memcg uncharge may sleep, and the claim guarantees each
> +	 * tracker page is refunded exactly once. @want follows the
> +	 * socket buffers, which are protected by the socket lock, not
> +	 * the budget lock; a claim made stale by a concurrent budget
> +	 * update is corrected by the next sync.
> +	 */
> +	spin_lock_bh(&sk->sk_memcg_budget_lock);
> +	want =3D sk_memcg_budget_pages(sk);

[Severity: High]
This unconditionally takes the spinlock before checking if a budget shrink
is actually necessary. Given that this is called from sk_mem_reclaim() for
every ACKed TCP packet processed, could this add massive overhead and
drastically reduce TCP throughput?

> +	if (want < sk->sk_memcg_budget) {
> +		refund =3D sk->sk_memcg_budget - want;
> +		WRITE_ONCE(sk->sk_memcg_budget, want);
>  	}
> +	spin_unlock_bh(&sk->sk_memcg_budget_lock);
> +
> +	if (refund)
> +		mem_cgroup_sk_uncharge(sk, refund);
> +}

[Severity: Critical]
If the budget computation in sk_memcg_budget_pages() overflows to a
negative value, won't want < sk->sk_memcg_budget evaluate to true and
produce a massive positive refund here? This massive refund could then be
uncharged from the memcg, causing an underflow in the memcg page counter.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924080219.1036=
588-1-caixinchen1@huawei.com?part=3D1
