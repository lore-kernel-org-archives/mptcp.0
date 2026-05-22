Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9BE2D3739
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 02:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779415591; cv=none; b=s8KPC99l8FaiO6J2YnBDkBy3BUL44dfDlGaynbYxRNoFnkSnr6DOJVQnSkclWXvqyqTnXlwbMSOLNiGR66a9Gqk7612rHv2AGmq2KT9aWBrS1rNbEc6U9zEx0vsOxu87GDS6sTHu3iLOyIbVQU2QTj9WjJEZFArQHqd99fhMcJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779415591; c=relaxed/simple;
	bh=epuUcqzbcPaFLy9PDc4CpTrwqvIaMS41dEaHzLzNqaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXh/HygBdly+/nSRu/tr465ANCLA2kOlsNKIxbSSIQruSguSTZ2Lh2vouJlLYa+3O0fsfDgSNA9Y79TwZ9weBOKCCFTBJvc1HTZlhpn6ibDvGkrvhkYWoXPCrha8ukWR7ribv+xFMqhlKoW1ldmZvLSAXivM/4rWAGJWbMjKJy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHBXTP8r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHBXTP8r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7393C1F00A3D;
	Fri, 22 May 2026 02:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779415590;
	bh=01Xz+dEHgOs3vpJiYBHorTScB1R4VUarSVJK805QohE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dHBXTP8r5LqIc8IjUft/iR/GRT73i+Ev4eR8IzsxI7/znhaatsFQZbeUv0MAajCpd
	 jPYF8FDJUmSleQ0gVApQivQVBejKGaJVKSDZx95rPCZHFQ449k6XzEipWgMU7C48Ed
	 Nbc8Vwl0hrqTiybEVJLwY0hssIJOqLVqR6IMqoApkkc//cvj+fe92uQIzbbJuTiFRv
	 vucyN8X1UJ5Duz7D8CkMk6KIJ8PAl/hQTiRFxfER4qoYS5zdPwSbvhmnKYCFQs/rR1
	 76Tk+4oI6yNlt3InB2ZHofQoGjCrsP7PFJDtOuFXDV1TRNT8Vtcw0XxtwbnvkuSPk7
	 PE0bLlxQ3PILQ==
Message-ID: <ab0a071a-719d-4099-bbd4-8f5aa19aaa70@kernel.org>
Date: Fri, 22 May 2026 12:06:20 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net] mptcp: pm: fix memory leak from alloc-during-teardown
 race
Content-Language: fr
To: Shardul Bankar <shardul.b@mpiricsoftware.com>, mptcp@lists.linux.dev,
 pabeni@redhat.com
Cc: martineau@kernel.org, geliang@kernel.org, janak@mpiric.us,
 kalpan.jani@mpiricsoftware.com, shardulsb08@gmail.com
References: <20260519191207.1110003-1-shardul.b@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260519191207.1110003-1-shardul.b@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shardul,

On 20/05/2026 05:12, Shardul Bankar wrote:
> mptcp_pm_destroy() drains msk->pm.anno_list via list_splice_init()
> under msk->pm.lock and then, for the userspace PM, drains
> msk->pm.userspace_pm_local_addr_list under the same lock. Between
> the two splices, msk->pm.lock is released.
> 
> A concurrent userspace PM genl ANNOUNCE on the same msk holds a
> sock reference via mptcp_token_get_sock() and, in
> mptcp_pm_nl_announce_doit(), calls
> mptcp_userspace_pm_append_new_local_addr() and
> mptcp_pm_alloc_anno_list(). Both take msk->pm.lock briefly to
> add to their respective lists. Because the genl handler holds a
> sock reference, mptcp_pm_destroy() may run on the same msk via
> mptcp_disconnect(), which invokes mptcp_destroy_common() without
> dropping the sock refcount, before the handler completes.
> 
> If the lock acquisitions interleave such that mptcp_pm_destroy()'s
> splice runs first, the subsequent alloc paths land on a list head
> pointing to itself. Nothing else iterates that list for this msk,
> and the added entry leaks. kmemleak reports both 192-byte
> mptcp_pm_add_entry objects (from mptcp_pm_alloc_anno_list()) and
> 64-byte mptcp_pm_addr_entry objects (from
> mptcp_userspace_pm_append_new_local_addr()) under sustained
> concurrent ANNOUNCE + close load against the userspace PM.
> 
> Add a teardown flag set by mptcp_pm_destroy() before its
> pm.lock-held splice and checked under pm.lock by the alloc paths.
> Either the alloc takes pm.lock first, in which case its entry
> will be on the list when destroy's splice runs and will be freed
> normally; or destroy takes pm.lock first, in which case the
> subsequent alloc observes the flag and refuses. Either ordering
> is correct, and the race that orphans an entry is precluded. The
> flag is cleared in mptcp_pm_data_init() so the state is correct
> on slab reuse.
> 
> Found by an MPTCP protocol-flow harness extending BRF
> (arXiv:2305.08782). Baseline ~0.3 kmemleak reports/minute on the
> userspace PM reduces to zero across multi-hour runs with this
> patch applied.

Nice, thank you for executing these tests, and fixing issues!

I'm travelling, and I'm not able to do a full detailed review, but here
is already a quick one.

> Assisted-by: Claude:claude-opus-4-7

Thank you for adding this tag. Can you also add a Fixes tag, pleases?

> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
> ---
>  net/mptcp/pm.c           | 6 ++++++
>  net/mptcp/pm_userspace.c | 4 ++++
>  net/mptcp/protocol.h     | 7 +++++++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 3e770c7407e1f..5b5c5e0c38583 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -440,6 +440,9 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
>  
>  	lockdep_assert_held(&msk->pm.lock);
>  
> +	if (READ_ONCE(msk->pm.destroying))
> +		return false;
> +
>  	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
>  
>  	if (add_entry) {
> @@ -1109,6 +1112,8 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
>  
>  void mptcp_pm_destroy(struct mptcp_sock *msk)
>  {
> +	WRITE_ONCE(msk->pm.destroying, true);
> +
>  	mptcp_pm_free_anno_list(msk);
>  
>  	if (mptcp_pm_is_userspace(msk))
> @@ -1149,6 +1154,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
>  	spin_lock_init(&msk->pm.lock);
>  	INIT_LIST_HEAD(&msk->pm.anno_list);
>  	INIT_LIST_HEAD(&msk->pm.userspace_pm_local_addr_list);
> +	msk->pm.destroying = false;
>  	mptcp_pm_data_reset(msk);

I guess this field should be reset in mptcp_pm_data_reset(): to be able
to re-use the socket after a disconnection (see mptcp_disconnect()).

>  }
>  
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 8cbc1920afb49..bf53db7307302 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -54,6 +54,10 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
>  	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
>  
>  	spin_lock_bh(&msk->pm.lock);
> +	if (READ_ONCE(msk->pm.destroying)) {
> +		ret = -EINVAL;
> +		goto append_err;
> +	}
>  	mptcp_for_each_userspace_pm_addr(msk, e) {
>  		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
>  		if (addr_match && entry->addr.id == 0 && needs_id)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index e4f5aba24da7d..c7a068ea71324 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -222,6 +222,13 @@ struct mptcp_pm_data {
>  
>  	spinlock_t	lock;		/*protects the whole PM data */
>  
> +	/* set by mptcp_pm_destroy() before its pm.lock-held splice;
> +	 * checked under pm.lock by alloc paths to refuse adds that would
> +	 * be orphaned by destroy's splice.  Cleared in mptcp_pm_data_init()
> +	 * so the field is correct after slab reuse.
> +	 */
> +	bool		destroying;

Would it work to use a new bit in 'status' instead?
You can add a *short* comment next to declaration of the new bit.

> +
>  	struct_group(reset,
>  
>  	u8		addr_signal;

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

