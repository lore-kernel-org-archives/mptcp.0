Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F68933CEBB
	for <mptcp@lists.linux.dev>; Wed, 17 Jun 2026 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716692; cv=none; b=fV489+/U5XZTEE4W5tuuf0wC2CCzR5FOpUdMUuUxkCce5wuqOy6tuPH6F0QEfw4DTo8nTfS1IPhsSiPZOHwlB9y8TD+li1xrst+OlDhqqlkGjt9BwokJmhbxh3Qo7j2NbUTEUNOKRL1LOmh2IbZqtFyB2G9FGMA9P8+26R09R1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716692; c=relaxed/simple;
	bh=hV+a9DvSOe/2rGzFn5v5NqNqu0B6C4cNdtbj6Fuc8FY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wqd5iqZ/ExOZBPJiw3HOwyhbU5Nfz4eT3M7bmTfs2tOIneCxN/jI9PluidLGYMaVs2cusohUtFHYHoxDFEP0rREh5BcQxjyvjrqK88CirqMYTb8s1aL61ZPxNDmZxm3agHBRFL4XCDBYgLASEWyPSvSnftdegZxTh9VibDST3OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAxFUR9D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAxFUR9D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB47E1F000E9;
	Wed, 17 Jun 2026 17:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781716688;
	bh=Rh5m3N7v1icUWiZ8C48Nihip5baWyypXVzVREs3kG/g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XAxFUR9Dj82K2vMzjuElOc3xEH/EfqfZ4a3z8/gheJQ4cxvIEinpV23qH6tbgLopB
	 C9Jb7yLFwM5rVYHCgswjXcY+nsrin5zWbmfl92vXFzV0Thi8s9l03Ui7QLwruRm6wO
	 9dXPwyZ8f1YXo2gojDzBwKZ1S3XDAerIoQjub8ghdU2d7a07gblF3keCGb7ofP9PnC
	 vzZsVXf9IsKSdE3TLGPmK3Lb9jQSPm1TU7sxM5tgr4hYSk9eyM8Ih13k1Mf+e+6f2h
	 mkLqGpGT/3XfprFucGUYTjwNF7uqgva5/yJEQ8Ea0kz02o8vuS0OSak6eUstCIDMpZ
	 vY2LXklPJzfFA==
Message-ID: <1c5c7f6c-8398-432a-9756-63eab3746016@kernel.org>
Date: Wed, 17 Jun 2026 19:18:04 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v3] mptcp: pm: fix memory leak from
 alloc-during-teardown race
Content-Language: fr
To: Shardul Bankar <shardul.b@mpiricsoftware.com>, mptcp@lists.linux.dev
Cc: martineau@kernel.org, geliang@kernel.org, pabeni@redhat.com,
 janak@mpiric.us, kalpan.jani@mpiricsoftware.com, shardulsb08@gmail.com
References: <20260611003613.3184956-1-shardul.b@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260611003613.3184956-1-shardul.b@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shardul,

On 11/06/2026 02:36, Shardul Bankar wrote:
> mptcp_pm_destroy() frees the entries on msk->pm.anno_list under
> msk->pm.lock and then, for the userspace PM, frees the entries on
> msk->pm.userspace_pm_local_addr_list under the same lock. The lock is
> dropped between the two.
> 
> A concurrent userspace PM genl ANNOUNCE on the same msk holds a sock
> reference via mptcp_token_get_sock() and, in
> mptcp_pm_nl_announce_doit(), calls
> mptcp_userspace_pm_append_new_local_addr() and
> mptcp_pm_alloc_anno_list(). Both take msk->pm.lock briefly to add to
> their respective lists. Because the genl handler holds a sock
> reference, mptcp_pm_destroy() may run on the same msk via
> mptcp_disconnect(), which invokes mptcp_destroy_common() without
> dropping the sock refcount, before the handler completes.
> 
> If the lock acquisitions interleave such that mptcp_pm_destroy() empties
> a list first, the later alloc adds its entry to a list head that nothing
> else iterates for this msk, and the entry leaks. kmemleak reports both
> 192-byte mptcp_pm_add_entry objects (from mptcp_pm_alloc_anno_list())
> and 64-byte mptcp_pm_addr_entry objects (from
> mptcp_userspace_pm_append_new_local_addr()) under sustained concurrent
> ANNOUNCE + close load against the userspace PM.
> 
> Add an MPTCP_PM_DESTROYING bit in msk->pm.status, set by
> mptcp_pm_destroy() under pm.lock before the lists are freed and checked
> under pm.lock by the alloc paths. Either the alloc takes pm.lock first,
> in which case its entry is on the list when mptcp_pm_destroy() frees it;
> or mptcp_pm_destroy() takes pm.lock first, in which case the later alloc
> observes the bit and refuses.
> 
> The bit lives in the pm data reset group, so mptcp_pm_data_reset()
> clears it. That is correct on the final-close path, where
> mptcp_pm_destroy() is not followed by mptcp_pm_data_reset(). On the
> mptcp_disconnect() reuse path, however, mptcp_pm_data_reset() runs after
> mptcp_pm_destroy() and clears the bit without pm.lock, so an append that
> takes pm.lock after the reset can still add an entry; and
> mptcp_pm_data_reset() may re-select a non-userspace path manager for the
> reused socket, whose mptcp_pm_destroy() would then not free
> userspace_pm_local_addr_list. Free that list unconditionally in
> mptcp_pm_destroy(), dropping the mptcp_pm_is_userspace() guard, so such
> an entry is always reclaimed; the list is empty for a kernel-PM socket,
> so this is a no-op there.
> 
> Found by an MPTCP protocol-flow harness extending BRF
> (arXiv:2305.08782). The userspace PM baseline of ~0.3 kmemleak
> reports/minute is removed by the fence; the rarer disconnect/reuse
> residual is reclaimed by the unconditional free above.

(...)

> @@ -1102,10 +1105,20 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
>  
>  void mptcp_pm_destroy(struct mptcp_sock *msk)
>  {
> +	spin_lock_bh(&msk->pm.lock);
> +	msk->pm.status |= BIT(MPTCP_PM_DESTROYING);
> +	spin_unlock_bh(&msk->pm.lock);
> +
>  	mptcp_pm_free_anno_list(msk);
>  
> -	if (mptcp_pm_is_userspace(msk))
> -		mptcp_userspace_pm_free_local_addr_list(msk);
> +	/* Always free the userspace local address list, not only when the
> +	 * socket currently uses the userspace PM: mptcp_pm_data_reset() (on
> +	 * the mptcp_disconnect() reuse path) re-selects the path manager from
> +	 * the netns default, so a userspace-PM socket can be reused as a
> +	 * kernel-PM one with entries still queued here. Freeing an empty
> +	 * list is a no-op.
> +	 */
> +	mptcp_userspace_pm_free_local_addr_list(msk);

Do you mind rebasing and re-sending this patch, please? There are some
conflicts here, because on the export branch, mptcp_pm_ops_release() is
called, which will call mptcp_userspace_pm_free_local_addr_list() only
with the userspace PM.

From the comment here above, I understand that mptcp_pm_data_reset() can
force a socket to switch to a different PM. I don't know if we should
avoid that instead. On the other hand, I see that the userspace pm
local_addr list is init in mptcp_pm_data_init, not in userspace_pm.c. So
it looks OK to me to come back to what we have on export-net, and keep
mptcp_userspace_pm_free_local_addr_list() in mptcp_pm_destroy() + now
call it unconditionally. WDYT?

(Note that the code introducing mptcp_pm_ops_release() is only on
netdev, so the related patch could be modified with a "squash-to" patch)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

