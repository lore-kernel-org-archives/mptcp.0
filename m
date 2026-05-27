Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BB812F585
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 05:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779858164; cv=none; b=kbmmrFMese5czq+CqNs5h7hv3l3BVE3DRLouEie8ABP6NLK0MK8Rhm6aoYrBTdnFAs4He8Za9FShBmxVUCISkBXuU8T9h84EsxCAxfD0Xl1kmGhleE9Eozg2lLkWi7ljofMkBohVJb+v/cb+kpV6tOFca+u+Y7mo+EKC4j8JQsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779858164; c=relaxed/simple;
	bh=s6DVj4vdbL1gsBNFdWPOIxPaHP73r1qsCWKQ0xoY4MQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0i8BvvfWk0EY5JFgGtUpLe3agd7OmEmpnVwbyI3hazOdNPEtjXKC59RQbcvFHRsnY1KV2IYmh7ls3Xy/vctQXkJR0FwScjAofWkYxKKHDSSKJjBweyZb11eYgRySaGW5Lfy8DFQExX5CnKxOeryUAJxo6Lf6jVk/5OSIjvscXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SViQa7K7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SViQa7K7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8551F000E9;
	Wed, 27 May 2026 05:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779858162;
	bh=cwStwD0J5LngTQvEbjv2rT8atfRfGlXaBFZB2GtAyNk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SViQa7K74jAqRgMmr8xVggtGCAkZuAkhs+pXn4PdcweedpQV/kqD6DIEz1z1eW35k
	 kxu/8Ldm+N2kbeZtdYjVcwEBc2EVO0TiyOZitAG+E7wP9ugsY2FBlwfxSJY1dRaNQR
	 Pw6zdfObUR+Xfzuw44O4E8FzjlLcodkqitSUMZOJwrn/FqUQ8aIn7sx8fdXqQAOyUA
	 Negxx57EJuy/lXFUu9wxIw9huUgg5HeaPbpY+lDylKKIFIrKgFQ04n4coob6HKQkAw
	 7mt+9G1VKfJjGQMDsq5WpFH/DrdoRLAryUbVmgsfeX8W0G/p6gFLUdaqKsqc52kxaE
	 9rK9ucYnHB1sw==
Message-ID: <6046a321-9f73-46d9-93d5-5bfe62416cc8@kernel.org>
Date: Wed, 27 May 2026 15:02:37 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v2] mptcp: pm: fix memory leak from
 alloc-during-teardown race
Content-Language: fr
To: Shardul Bankar <shardul.b@mpiricsoftware.com>, mptcp@lists.linux.dev
Cc: martineau@kernel.org, geliang@kernel.org, pabeni@redhat.com,
 janak@mpiric.us, kalpan.jani@mpiricsoftware.com, shardulsb08@gmail.com
References: <20260523212930.2957096-1-shardul.b@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260523212930.2957096-1-shardul.b@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shardul,

Thank you for the v2!

On 24/05/2026 07:29, Shardul Bankar wrote:
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
> Add an MPTCP_PM_DESTROYING bit in msk->pm.status, set by
> mptcp_pm_destroy() under pm.lock before the splice and checked
> under pm.lock by the alloc paths. Either the alloc takes pm.lock
> first, in which case its entry will be on the list when destroy's
> splice runs and will be freed normally; or destroy takes pm.lock
> first, in which case the subsequent alloc observes the bit and
> refuses. Either ordering is correct, and the race that orphans
> an entry is precluded. The bit lives in the pm data reset group,
> so mptcp_pm_data_reset() clears it on the disconnect/reuse path
> as well as on fresh socket init.
> 
> Found by an MPTCP protocol-flow harness extending BRF
> (arXiv:2305.08782). Baseline ~0.3 kmemleak reports/minute on the
> userspace PM reduces to zero across multi-hour runs with this
> patch applied.

I guess you also validated the v2 against your reproducer, right?

I'm asking, because sashiko thinks there is still a way to hit the issue
if the userspace does a shutdown() (mptcp_disconnect()):

https://sashiko.dev/#/patchset/20260523212930.2957096-1-shardul.b@mpiricsoftware.com

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

