Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8233170851
	for <mptcp@lists.linux.dev>; Thu,  9 May 2024 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715271947; cv=none; b=ICKmLRheSEdRJdmgnApixi1h2geytoxJz1Oo3m308bsFCQsajri2M8Jzg1Kbb7UXTbKJg2i2WG9gPSaAHMnj2d0W8P5xPRSh7Q4fPxeUBgdC60O3Y95qQ21uJdLsLfJ24VXTxnfZJ1HOaGO8vEr7vPNqEfjFicIEsdgO1OpDQj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715271947; c=relaxed/simple;
	bh=FvGALMLkozcbDDeb9PmheMD2dfDCelNtl9Cb7gY7e2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cqxpYFq44gjIrLnLGb+aGwCXSRb+9x1pDcG3Gi/acwmtZZUTRjL4Rt85llazJteY3XNF4Q6ZkMUmVTUZowwkgeQ94kpXYwqUafQy9FfZ0KXj6E/ix69r3mVURj15Q79MvoPYzUYjAA1ZNC/G58mqII14HFbu2tio3aEYvN3Jj7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EngCHV6i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EngCHV6i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BB8C116B1;
	Thu,  9 May 2024 16:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715271946;
	bh=FvGALMLkozcbDDeb9PmheMD2dfDCelNtl9Cb7gY7e2w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EngCHV6i7dxPFeCqI4XjTevxz4saZ3kHODrq/cSCJyEkC4wTYBqz8mDZCfEtolRaY
	 nQ9eG4F57ukmgEFo2q3wXgqfjuyx6hdqP65xvYaSiyYoZg64F/Q7mO7g1xvwX5SzeQ
	 LtHoAXefw70Ipmbt+ECmjFiqFRr/M6mL+FbmuiMDJJFQx3Ws5BaWcqQWWnWp8RGxz9
	 iRAUiV8WAi3cK1ZI/aixQv2N6suPH17r+lHZSJIm/Lv+Odw4jygcfPziz5sijtGdbE
	 s9MkxReWETpe5lssmGPtRo0dcyfzENZUEbngkiE9JZKy1Z/cZL13L09C6fmavquE9d
	 tA7Sk4U9KXbQw==
Message-ID: <019d3bfe-90c7-472f-96fc-79e76461c10d@kernel.org>
Date: Thu, 9 May 2024 18:25:44 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next RFC] mptcp: socket option to check for fallback
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20240506-getsockopt-tcp_is_mptcp-v1-1-4f044660f7c3@kernel.org>
 <764b2d9f-8600-a3fd-9312-64b43e78162f@kernel.org>
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <764b2d9f-8600-a3fd-9312-64b43e78162f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 07/05/2024 03:09, Mat Martineau wrote:
> On Mon, 6 May 2024, Matthieu Baerts (NGI0) wrote:
> 
>> A way for an application to know if the connection fell back to TCP is
>> to use getsockopt(MPTCP_INFO) and look for errors. The issue with this
>> technique is that the same errors -- EOPNOTSUPP (IPv4) and ENOPROTOOPT
>> (IPv6) -- are returned if there was a fallback, or if the kernel doesn't
>> support this socket option. The userspace then has to look at the kernel
>> version to know what to expect.
>>
>> It is not clean, and it doesn't take into account older kernels where
>> the socket option has been backported. A cleaner way would be to expose
>> this info to the TCP socket level. In case of MPTCP socket where no
>> fallback happened, the socket options for the TCP level will be handled
>> in MPTCP code, in mptcp_getsockopt_sol_tcp(). If not, that will be in
>> TCP code, in do_tcp_getsockopt(). So one simply has to return 1, while
>> the other can return 0.
>>
>> If the socket option is not supported, an error will be reported:
>> EOPNOTSUPP (95 - Operation not supported) for MPTCP sockets, ENOPROTOOPT
>> (92 - Protocol not available) for TCP sockets.
>>
> 
> Hi Matthieu -
> 
> I like this approach as it's much simpler to check than MPTCP_INFO, and
> gives a clear answer to both "Is this kernel new enough to tell me the
> fallback status?" and "If it is new enough, is it currently a TCP or
> MPTCP socket?".

Thank you for your feedback!

As discussed yesterday, I just applied this patch in our tree, and I
will send it alone to netdev for review.

New patches for t/upstream:
- d035042ea2b4: mptcp: socket option to check for fallback
- Results: 5bc872cb274e..6d5ca2a78a70 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/689430a018a9111229371ebb6167604e8dd6a7ae/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

