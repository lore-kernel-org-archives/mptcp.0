Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D061F30BB
	for <mptcp@lists.linux.dev>; Fri, 19 Jun 2026 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781885975; cv=none; b=APh/zdg5TIV7rLgIrDIdkIxvuHXqLSKhzJatjvdRZGbjgj8NcZ4u0AzU50g8Z3SVsYr1P3PCLWk753W/JIxcSNK1MVkjIWqDdOpwnNdpcBND07oSzsN4PExzpMdHFQ1tx/kmclD3tRe/tPdgAiS+oV2y4L8qGtVs54ljoTAD7Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781885975; c=relaxed/simple;
	bh=6nNyv6dAyFQ2HkIAnBJY/zPsmF3CFUIXeiMg+FvCauM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4nkvCaA9WYJCeoK5U/qpI42NBTcnarqXZ5gno55t+Gx30ko9sWNhzOyxzPAAmOXYVBEYvc5VLk98i1APzE9i+HADZQDxWQ/dquaml1dv6txbmu+HwX+1GYjIUrfzbD0a5lSnJS9kYJhA9YdL2G7pcQS8HiiQ1Ef/51XIz8icXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQ6A1xaI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQ6A1xaI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AA91F000E9;
	Fri, 19 Jun 2026 16:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781885974;
	bh=gclLfyTF0eOtzQ1n/S9JceRrQdey23pSAgJkS3X4Nz8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SQ6A1xaIyiwh9bttbSKBildEt3fb/0W82LYEVbbc+RlkeIfColoUA2c2iLhP+9sZj
	 EJpz8p3Ycb3gRkUKh6CJn1Nk1NyfUlRibPN3SRExNPAx2KnqZprQkw1Jkp1foXALoA
	 lgOqEx8jhIL5eRI0krVPYq3P/2TIXvub8Zzna679iU8276VujBLTagVVies3ASBHed
	 KFGXDUW3MKvAn0GojRxZMPHlHO29jauMj9D03U1tl8S0r/4rqaC6doWlAe18xDXcAI
	 oQcscom0dMceqeUHJLyFzHemft2qxtmD8+jWZWubgK5InX7wbj0SgBs87nWsOLT8xE
	 CWw3lihoN4Aig==
Message-ID: <7e7b0a41-6d79-4a1e-a625-77c975161639@kernel.org>
Date: Fri, 19 Jun 2026 18:19:30 +0200
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
 janak@mpiric.us, kalpan.jani@mpiricsoftware.com
References: <20260611003613.3184956-1-shardul.b@mpiricsoftware.com>
 <1c5c7f6c-8398-432a-9756-63eab3746016@kernel.org>
 <4fb51400e35eb791254d8614595ffe8329fc8bd8.camel@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <4fb51400e35eb791254d8614595ffe8329fc8bd8.camel@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shardul,

On 19/06/2026 18:07, Shardul Bankar wrote:
> Hi Matt,
> 
> Thanks for the review.
> 
> On Wed, 2026-06-17 at 19:18 +0200, Matthieu Baerts wrote:
>> Hi Shardul,
>>
>>
>> Do you mind rebasing and re-sending this patch, please? There are
>> some
>> conflicts here, because on the export branch, mptcp_pm_ops_release()
>> is
>> called, which will call mptcp_userspace_pm_free_local_addr_list()
>> only
>> with the userspace PM.
>>
>> From the comment here above, I understand that mptcp_pm_data_reset()
>> can
>> force a socket to switch to a different PM. I don't know if we should
>> avoid that instead. On the other hand, I see that the userspace pm
>> local_addr list is init in mptcp_pm_data_init, not in userspace_pm.c.
>> So
>> it looks OK to me to come back to what we have on export-net, and
>> keep
>> mptcp_userspace_pm_free_local_addr_list() in mptcp_pm_destroy() + now
>> call it unconditionally. WDYT?
>>
> 
> Agreed. So v3 stands as-is for net; I won't send a new version there
> (it still applies cleanly on the current export-net), keeping the
> unconditional free in mptcp_pm_destroy().
> 
>> (Note that the code introducing mptcp_pm_ops_release() is only on
>> netdev, so the related patch could be modified with a "squash-to"
>> patch)
>>
> 
> For the export branch the patch does not apply, because as you noted
> the userspace free moved into pm_ops->release in "mptcp: pm: init and
> release mptcp_pm_ops". I will send the fix ported to export so the CI
> can exercise it, as two [PATCH mptcp-next] patches:
> 
> 1. Squash to "mptcp: pm: init and release mptcp_pm_ops": free
> userspace_pm_local_addr_list unconditionally in mptcp_pm_destroy() and
> drop the now-redundant userspace .release.
> 2. The MPTCP_PM_DESTROYING fence, rebased onto the renamed
> mptcp_pm_announced_alloc() / mptcp_pm_destroy().
> 
> v3 remains the canonical net fix; please pick whichever you prefer for
> export (take the port, or rebase v3 and resolve the small conflicts). I
> will report the CI result once it runs.

I will wait for your new version to apply the patches, that will be
easier to propagate the modifications, and the CI will do a last check,
just in case.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

