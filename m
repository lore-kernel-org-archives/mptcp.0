Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CF71990CD
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730283740; cv=none; b=ZroijUif0tpH/Ufr5nbmqf/GtI7dgGIH0Lq32vDOusJZJvd3FcvfUAiNgJQsuSYWt7YqKH/R/5/cfvDhefQfpbmFsrSlVkYDkBa6i/DpJ/f9TvCN3CHORAMo1p+0RocSNEI9WrsKAqFkh165PCTUzaxSqXj3gToUQpPTTpGlyZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730283740; c=relaxed/simple;
	bh=B2UwtXzSfGMIE75WsAG7j3MS/JOvTicHCxHL8wLRpHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AwWOjJ+VJpyDtzE9KANlcuzF1snk35liRLxaGIOtaaYG/ue2K1LGnYwT58PciXRZvSZXVYaOe8b6QmxF+9llS9KTHEvnkxHnACJK4JWaqU2RbcM+ANBNw5p1X9t8Yza+3gVK7Uu9XGtZCbZ4l4wtqxondk61sdWD7DZ3taOEKso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOmuOXd4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOmuOXd4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398EDC4CEE3;
	Wed, 30 Oct 2024 10:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730283739;
	bh=B2UwtXzSfGMIE75WsAG7j3MS/JOvTicHCxHL8wLRpHI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oOmuOXd4WihZDvrpYsfJYikMksPxf0VLvYm+uN+q49ccJesantdSyyTV6AWkcxP9g
	 ICwf7sOVD4Rw8mGOX/YhQ3OmCosjNfxxhziVwH2ShaK6dbS0KB40E/1Lkl5VDFSK79
	 o8cseYAEIoTubo5qXeV6GANMB5//hjDt+3EjIQvCz1yttdhXD76opYXL1EySqbfe2l
	 sd1HTjc4r4oRD/zT1arQ+ZEixgtXpdYl8aTE514bvNoBN3iwdTzCg3EZLaiChRSRr5
	 +0Vlzc9GglDC0fj/CgNfmc243TD++bQx3FNLyY8mEKNkl2lLGb3BN3IIwJZqEKY5x3
	 Le+AOdfwGmg3A==
Message-ID: <f509af58-2394-4cd4-99c1-736fe38951a7@kernel.org>
Date: Wed, 30 Oct 2024 11:22:16 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Drop netns helpers in mptcp
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
References: <70c1f95bae8ec4884be50e08053364c1d152170c.1730262704.git.tanggeliang@kylinos.cn>
 <1b2079c54c089a4d0e55dcb3814f0bdfee7d37faf43a24627fa65b496b21ecf4@mail.kernel.org>
 <83561ed71dd7dd44571bb71c6dc5ac634fb1d9a8.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Organization: NGI0 Core
In-Reply-To: <83561ed71dd7dd44571bb71c6dc5ac634fb1d9a8.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 30/10/2024 10:37, Geliang Tang wrote:
> Hi Matt,
> 
> I need some help.
> 
> On Wed, 2024-10-30 at 05:50 +0000, bot+bpf-ci@kernel.org wrote:
>> Dear patch submitter,
>>
>> CI has tested the following submission:
>> Status:     CONFLICT
>> Name:       [bpf-next,v2] selftests/bpf: Drop netns helpers in mptcp
>> Patchwork: 
>> https://patchwork.kernel.org/project/netdevbpf/list/?series=904505&state=*
>> PR:         https://github.com/kernel-patches/bpf/pull/7982
>>
>> Please rebase your submission onto the most recent upstream change
>> and resubmit
>> the patch to get it tested again.
> 
> BPF CI complains that this patch cannot be merged.
> 
> This patch needs to be merged into "for-next" branch of bpf-next, not
> "master" branch. But CI defaults to merging into "master" branch, so
> the merge cannot succeed. Do you know how I should handle this?

I guess what you need is to specify 'bpf-next/net' in the subject:

  [PATCH bpf-next/net v3] (...)

And rebase your patch on top of bpf/bpf-next.git, but the 'net' branch.

That's because they did some changes in their BPF trees:


https://lore.kernel.org/netdev/CAADnVQJgwGh+Jf=DUFuX28R2bpWVezigQYObNoKJT8UbqekOHA@mail.gmail.com/

In short, in bpf/bpf-next.git you have 3 branches:

- master: that will be use to send PR to Linus directly, and not netdev

- net: new: this was still depend on net-next, PR will be sent to netdev

- for-next: this one should be a merge of the two ↑, for linux-next

For all modifications linked to BPF and MPTCP, I guess they will need to
be tagged "bpf-next/net" (or "bpf" for the fixes).

I guess you should not use the 'for-next' branch.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

