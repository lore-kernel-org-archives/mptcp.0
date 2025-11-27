Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179F02571A0
	for <mptcp@lists.linux.dev>; Thu, 27 Nov 2025 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764265541; cv=none; b=fKmko49i+hUtIaS/gE9KkMN9yR7RnTfV+EfTWTpSdQU3t6B8Wy+oLfh1ajARj18UHCy8Av/04EFGH9EUA9Xd90TthvqDiq6C8Y845w+61Maccih5dX7Yc/srXTWbWpVci2rh9cNRUsZME/+EyK5b7i/i8KiU/A+vHPXq/IoMAIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764265541; c=relaxed/simple;
	bh=lacYiH9ag3IQU9kcShlS2xbg56TQZdV8k8YNRkwK3tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Al//aQYX+SqJYz9JFPqQkgjHwqBnY0sIkQ4+nwSceg8l4niqC6Ir2fmYmhQANz5drSGHydM9MdJnv3CsFrz+Mb8qTfQTk1bI8BrcYwBSYkqbXOnZFg9ZjjreuxP4DE/rm23+HJgkqRt/WTtM3f9HseI8VPB5jhOog4G246xq71Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohsSoezG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohsSoezG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09958C4CEF8;
	Thu, 27 Nov 2025 17:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764265540;
	bh=lacYiH9ag3IQU9kcShlS2xbg56TQZdV8k8YNRkwK3tc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ohsSoezGGSYU4khqMvOfGpWglyHkI7ZDlSnz8ZZ79ZHZdv6a+SOIH5g0bqkCY7hEd
	 hdHfuyiICMVtdTnKOnqWvT7twM5p4dvT6FduzCa6uRzsZu9/r3b1Q8dv4QmF6UCQHP
	 Ovl3Wm524Pfsxfm/FyF+FUXmEUUpULywBe4xXdbXkL1K3m07IWqagmm3VB876kvsxD
	 /Cds3M1aq2o7FYf+/htl+a/8/8pU+rSXofqKINVZm2+IE+cUNHjI93k5eY8rWf8MHt
	 x8QCQXzaYoDCe5GUpeGYO1cOsv2sEhlomuQPTXHVBvBSfmvHWjBQ38DKSFbaqy2MWt
	 +iD4KAzjsVwdA==
Message-ID: <a09f705a-b42e-4ff7-b68c-9170dbb05f01@kernel.org>
Date: Thu, 27 Nov 2025 18:45:37 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH RFC mptcp-next] mptcp: support net.ipv4.tcp_rcvbuf_low_rtt
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, MPTCP Upstream <mptcp@lists.linux.dev>
References: <20251127-mptcp-tcp_rcvbuf_low_rtt-v1-1-fa080d67f2e5@kernel.org>
 <acd76564-d636-4fc5-9fdb-f39deb9be41d@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <acd76564-d636-4fc5-9fdb-f39deb9be41d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 27/11/2025 18:20, Paolo Abeni wrote:
> On 11/27/25 4:58 PM, Matthieu Baerts (NGI0) wrote:
>> This is a follow up of commit ecfea98b7d0d ("tcp: add
>> net.ipv4.tcp_rcvbuf_low_rtt"), but adapted to MPTCP.
>>
>> MPTCP has mptcp_rcvbuf_grow(), which is similar to tcp_rcvbuf_grow, but
>> adapted for the MPTCP-level socket.
>>
>> The idea here is similar to what has been done on TCP side: not let
>> mptcp_rcvbuf_grow() grow sk->sk_rcvbuf too fast for small RTT flows.
>> Quoting Eric: If sk->sk_rcvbuf is too big, this can force NIC driver to
>> not recycle pages from their page pool, and also can cause cache
>> evictions for DDIO enabled cpus/NIC, as receivers are usually slower
>> than senders.
>>
>> If RTT if smaller than the new net.ipv4.tcp_rcvbuf_low_rtt sysctl value,
>> use the RTT / tcp_rcvbuf_low_rtt ratio to control sk_rcvbuf inflation.
> 
> Instead of duplicating the TCP math, I suggest factoring it out in an
> helper and use it in both the TCP and MPTCP code.

Thank you for the review! Good idea!

I guess this patch can wait the next cycle, right? Or should I rush to
get this soon to stay in sync with TCP?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

