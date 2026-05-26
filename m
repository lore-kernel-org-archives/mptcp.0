Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED512C181
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779784773; cv=none; b=XXLL7eJZqfFogzCOSR0WyO19IG4HrgJUoi6tkLH39+MsZGizp2vDyIKcxctvg5u0wD2N0MljBLKmvgASOgosHxJmVc4Aw5wVIfC0/t8mqJoYEBWkGQWVFgvms1f6eaEQxbRkRwVubceduvZAGwd6IpDgrQlxQ/DgfnUh4qoFNIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779784773; c=relaxed/simple;
	bh=gjJCeE5ZoHl9mWuglj5zDpq6uvzDqpIrZWpNyprf+Jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fLD9nuBepH8mMB3Y/zbU4WN/DZRoOXCapEQHXa6hLWrhVkSLNExBgPGL3CD3Q/OvKfamt71W9cCtwxkToUotwgePlo53DzZh+82PPtrFzkSy78L4K2ECWnTT83VNskNnCneh6Ym9wxQT7wjXQqEVx2yuWMlgyISO9JmXbcNXFXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8qzL3JP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8qzL3JP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB181F000E9;
	Tue, 26 May 2026 08:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779784772;
	bh=l0fribLA3ITytQFqCr/JcMelKMA66SkRlZ2VuNAhvK4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=L8qzL3JP0fayXd9FeoCyuD1CXWrrAC9Vzc9xykGN52UqciFhWdxd9h87KzhgaEtZm
	 a1xwlFTWglFE0LfdVCdklObfhq0HmxO5mJWAZarFLyETEUWWB5F/VMzMjB3BqlQaaT
	 4SbiF0glG3ucHA6h1xeEmU+zV3+G98AFUsknKmupkOsnaE/NNBpBvHtZT/bFfCm8dK
	 Kq4bWM5NWxD1T0qseHJcNsZWRAXoT0uFETjLz+WydsBZw/hhYMcO0gFt3fnFshDnaB
	 nyy8ZXzv9/WY99+oMqrQ61hXnRYT5QWCg7vc/iK13ZOGWyOok32HrIo9uMYONe627z
	 0KPkh07KNl5Jw==
Message-ID: <07bf06c0-20dd-4e31-960a-b79f6fffcecc@kernel.org>
Date: Tue, 26 May 2026 18:39:26 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] mptcp: pm: don't WARN on re-announced addr in kernel PM
Content-Language: fr
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>, mptcp@lists.linux.dev
Cc: martineau@kernel.org, pabeni@redhat.com, janak@mpiric.us,
 shardul.b@mpiricsoftware.com, kalpanjani009@gmail.com, shardulsb08@gmail.com
References: <20260525121911.2410171-1-kalpan.jani@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260525121911.2410171-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kalpan,

On 25/05/2026 22:19, Kalpan Jani wrote:
> syzkaller hit the WARN_ON_ONCE() in mptcp_pm_alloc_anno_list() with
> the in-kernel path manager, reached via
> mptcp_pm_create_subflow_or_signal_addr().
> 
> The WARN assumes the kernel PM can never reselect an address that is
> still in msk->pm.anno_list. That is not true: when an endpoint is
> removed and re-added while a previously sent ADD_ADDR is still
> awaiting its echo, the endpoint id becomes available again in
> id_avail_bitmap, but the matching anno_list entry (with its
> retransmit timer) is still alive. The in-progress guard in
> mptcp_pm_create_subflow_or_signal_addr() only checks
> BIT(MPTCP_ADD_ADDR_SIGNAL), which is already cleared once the option
> has been transmitted, so the address gets reselected and reaches
> mptcp_pm_alloc_anno_list() a second time.

From what I understand, it means that if a "signal" MPTCP endpoint is
removed the echo got received, the in-kernel PM will continue
retransmitting the ADD_ADDR. That doesn't seem correct. I didn't check
in the code, but I thought that the retransmit timer was at least
stopped, but maybe the entry was not removed from the list?

Does it also mean that if an ADD_ADDR echo is never received, the entry
is never removed, even after having reached the max retransmissions?
> This is a benign transient state, so drop the WARN. For the kernel
> PM, just bail out: the ADD_ADDR is already in flight, and the PM will
> be rescheduled once it completes (or once the stale entry's timer
> expires).

If I understand correctly, the transient state is not benign, and the
WARN should not be dropped.


Also, it would be nice to add a new test to validate that. Here, it
might be easier with a packetdrill test [1]: start with one sending an
ADD_ADDR [2], but don't send the echo, and instead, remove and re-add
the endpoint.

[1] https://github.com/multipath-tcp/packetdrill
[2]
https://github.com/multipath-tcp/packetdrill/blob/mptcp-net-next/gtests/net/mptcp/add_addr/add_addr4_server.pkt

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

