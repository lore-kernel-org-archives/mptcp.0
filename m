Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA7C46C4CD
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786098327; cv=none; b=p8IYKB1h1DlwZ/SDBQSFB9HC5IEDOw00cSGI6CRu3TewmyJEuVTEsteIdgYmXH85rFEeLFNZmXK1wcvF1hC1FEBIi54Mqm2KxcICCsjnNmbOXPHuv8vBE09llhL7nK3quy264fnkKPM4FM2ZNnOA48FWxY5Pzix92goCIqu79do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786098327; c=relaxed/simple;
	bh=LeZIPxJqT0YvPkkgYvR2UAZQXlbD+hktRvDZfXxzWSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/OZl7YGxsGxXKnb/J1dMjnAPrnyF9LpS8ZjS4IjWkEuyaUXGPru7pizGcJUtlEU0Om/3Jj9sAaV3t5lUwfRpcYtKQ1ULqTJ9jVeolgKdOZiJUN5Stg4rS2TNetZgpP7Gtt/Ib7l8SGYr/lfP65zumjd0ZLIqcLxBWd97RrEBnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZk4vzaT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZk4vzaT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63B41F000E9;
	Fri,  7 Aug 2026 10:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786098324;
	bh=Y3OZ0pLcqiVrW5UXkxSp86hBedZKkiovlF+8H51N/pQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cZk4vzaT8kLs0EPmWftMrUg7z8dA7rPFicYiOzub5pOUYAH0rMsEEXnTQZ8xvBEMO
	 270e/QQ/hHZzUcLljF7rMaztD20qWRNJ13DuhfECk6kpmjB9W4WaT8cNbzi6/6x6S7
	 +V9sxemhCvP0t2M2Zoxj4o0BwDweEJISO+y4zO5ayh7IHFj54HmqJiV1YuDvD4w1FS
	 0cjFjfH85PLtA1AdA+RAJ+LZKaTQnYmJEytuVRJD3SEq6d0JwDjDLUo4QsL5I8e5KD
	 fO2eZ4EiNGOWYPJtQt/+qbqoFF4KySHUPfeM7v4YMg5hb0LyNtmLtbT3MaH9o02ILB
	 9NX/GevllsNzw==
Message-ID: <4ba63d3b-ac2f-4035-8a7a-0c856ba46c42@kernel.org>
Date: Fri, 7 Aug 2026 12:25:21 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v4] mptcp: pm: fix userspace PM address ID
 overflow when all IDs are exhausted
Content-Language: fr
To: luoqing <l1138897701@163.com>
Cc: mptcp@lists.linux.dev
References: <20260805070926.716768-1-l1138897701@163.com>
 <20260807074110.566170-1-l1138897701@163.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260807074110.566170-1-l1138897701@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi luoqing,

On 07/08/2026 09:41, luoqing wrote:
> From: Qing Luo <luoqing@kylinos.cn>
> 
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
> Check the find_next_zero_bit() result against MPTCP_PM_MAX_ADDR_ID and
> return -ENOSPC if all IDs are truly exhausted. Move the ID allocation
> check before the memory allocation so that the error path does not need
> to free the allocated entry.
> 
> Fixes: 4638de5aefe5 ("mptcp: handle local addrs announced by userspace PMs")
> Assisted-by: LLM
> Signed-off-by: Qing Luo <luoqing@kylinos.cn>
> ---
> v4: Move the ID allocation check before the memory allocation so that the error path 
>     does not need to free the allocated entry
Thanks, now in our tree:

New patches for t/upstream-net and t/upstream:
- b57c0c6fddb3: mptcp: pm: fix userspace PM address ID overflow when all
IDs are exhausted
- Results: 4439056e6ccd..d0562342cb80 (export-net)
- Results: e8891858656d..f393de6a43c3 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/1f6dc25f039e11595558280af68c916da4e86f71/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/3601198557ef7a1d08e411ac4ca4aa5e636d4e3e/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

