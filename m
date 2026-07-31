Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC52B444712
	for <mptcp@lists.linux.dev>; Fri, 31 Jul 2026 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512987; cv=none; b=LlgpUboFWo7lk+5u04wL/IVgnZ/HlK/XMGLVnsSQb9h6S8VydvMGhLuYpVw8IHklHu3BIj8tzKVFfhpQ/DKGJlxPyIuyTeebOik9ZOb+r349MkucuqnCXc6KMW7dKtJNu1qg7QkN7Vsl6dvMQFD90Ct4ukmTR/p3XTpLGuWUcdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512987; c=relaxed/simple;
	bh=NqsqXZHSEMPTag77GloLNp3MwclQNoCTKx4V4d/zZEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HS2GM5xDQV3VTaVN88VWUv6SpGxB0Ww0zNYQAdeqhV4E+2Zjp1EyuJsorZiBy+E3eXXD0Xens6rCfpXqd92FvClfH2ZiBtAQ037hp/UYMEzu7IoqwJ48bmlqh7eO4wqjsTcEd0YXpWh+L4H2qe9dlEhN1CjVa4wtbr4aTdhgozI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehuCSEsm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehuCSEsm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70641F000E9;
	Fri, 31 Jul 2026 15:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785512986;
	bh=3/DpHdM38dowTxEFz+n4yQ6oULtLoAadW1bjECJwhHo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ehuCSEsmAee34/qF8g0uZEpOsSFPacb+ACMbQNNs3fG3Z+qsnVv8/wamhdx/2lyea
	 BlV5CHXW2+aazJ8tVKpEnE+sVQlpVUaVNWRso4YzK1Ij5YmSU6xni1nJAu39W/II8g
	 JPHbHnGonkR25tjY3z/191IMnPTlZGW1S5QoRpfr9vYz0vi7rfXaHUQ+ztonEIseTM
	 iCjag7WqWIhGcliAVLiAE7fFDmsWlPJP42bCe2kgpmXwj7B+LC0A28i5zKOfrHaGRv
	 5rG3Dur5q6p+akweadp6jSxD4O3CHdCK+wzKsfNVf9epf3rImQoBCEoypnZBcHQMUa
	 HKEbKOccGy2Dw==
Message-ID: <a303c170-7290-406b-ad63-69af313877ad@kernel.org>
Date: Fri, 31 Jul 2026 17:49:42 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 0/2] mptcp: pm: net-next port of the
 alloc-during-teardown leak fix
Content-Language: fr
To: Shardul Bankar <shardul.b@mpiricsoftware.com>, mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 pabeni@redhat.com, kalpan.jani@mpiricsoftware.com, janak@mpiric.us,
 shardulsb08@gmail.com
References: <20260620084424.3072634-1-shardul.b@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260620084424.3072634-1-shardul.b@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shardul,

On 20/06/2026 10:44, Shardul Bankar wrote:
> This is the net-next counterpart of the net fix "mptcp: pm: fix memory
> leak from alloc-during-teardown race" (v3):
> https://lore.kernel.org/all/20260611003613.3184956-1-shardul.b@mpiricsoftware.com/
> 
> v3 remains the canonical fix for net; it applies as-is on export-net. It
> does not apply on export, because the userspace local address list free
> moved into the userspace path manager .release callback in "mptcp: pm:
> init and release mptcp_pm_ops". This series ports the fix to net-next:
> 
>   1/2 squashes the unconditional free into that refactor commit (covering
>       the disconnect/reuse path).
>   2/2 is the MPTCP_PM_DESTROYING fence (the alloc-during-teardown race),
>       rebased onto the renamed mptcp_pm_announced_alloc() /
>       mptcp_pm_destroy().
> 
> The net fix was validated with an MPTCP protocol-flow harness (BRF) over
> multi-hour runs with zero kmemleak reports (reported on the v3 thread).
> This port is structurally equivalent and is sent so the CI can exercise
> it on net-next.
Thank you for the v3, the reply to Sashiko's comment, and sorry for the
delay.

Note that I applied the patch from the v2 on top of net, and used the
message that was on the v3. I also reduced the comments in the code.

I got a bunch of conflicts, but that was expected.

Now in our tree:

New patches for t/upstream-net and t/upstream:
- 2b2f15275853: mptcp: pm: fix memory leak from alloc-during-teardown race
- f53bd07233a6: conflict in t/mptcp-pm-init-and-release-mptcp_pm_ops
- 919a44ee381d: "squashed" (with conflicts) in "mptcp: pm: init and
release mptcp_pm_ops"
- c7d92e52241a: conflict in t/mptcp-pm-add-get_local_id-interface
- 58c196b64826: conflict in t/mptcp-pm-add-get_priority-interface
- Results: 8fa2ab05d71f..a811f9685bfd (export-net)
- Results: 588708fb07a7..4cc6862c4795 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/a1feb73d0d2bb6aa9873ac55926f920e6d1209ba/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/ca43dbbb8a8abda8ead4866bfd62b06bdf1c7d08/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

