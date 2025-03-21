Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689831EFFB6
	for <mptcp@lists.linux.dev>; Fri, 21 Mar 2025 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742548770; cv=none; b=h9JzPFZlQSJ0VteE0J74pO4+CvjpN0JJ8Pw/LOki46Ct3T7PpOin7DMUM2a7rcM5204geuPmWlJ5JgWp6U7DEqWrQTxG8M6ur82ze1WkJDSXI5CTdU/bIFRfhDHJM9wu2cFUzQhHxGkmp0Z9kxN7pMh152FYrqWl19AlvnuDE7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742548770; c=relaxed/simple;
	bh=RY8/cZSq0a/F8vJ2soiCsgcwkAs3ZmInOy6yCIZ5QOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxSMuxkidS9QKtaP1rSnt95zCgJacfmnMMGvFmkpJ+4BvMlx1tP9zRpd7QtxQlglRTLdLDfJYnFgEpybICB1u6BPQbFvw4rSnsbD25DP2J25+wJXBGEDRFTp8PdTblxucGyZkZWxDaTebXZsijbycSYh0xYI891tHiRZUukJCc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M076+7TT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M076+7TT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88CCC4CEE8;
	Fri, 21 Mar 2025 09:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742548769;
	bh=RY8/cZSq0a/F8vJ2soiCsgcwkAs3ZmInOy6yCIZ5QOo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M076+7TTRzyjv9qgINY23tZ649SgG31fHO8hgSMGZZfx1TxJhykBvdubcZYTZbZ+B
	 DnMmkDze6+5C1ZtiM0d2Ds1ouFOGC8/+SoKLXbvCvjSj23M7brxGmwCoLg7jad22JP
	 SfxLdZ2zmFZSpt1E++9+HwXrodM9V4ayEv0/E/xd5zUZm8zRdOgMx5t88S/WBjXHRN
	 WtSzVS0bm3nkm5cT+dHrSrmhT70HSuB2DoBcEJ9lWVqDqPMDnkar94v7/cAjcXkQkf
	 U2mS3c2V28UImXjbpmpvznaQsy8Ov8UTaHjsBduYWcvOCZ9HDvIJJ8yD22htC0jWAF
	 iZggKL3hA00yQ==
Message-ID: <fac4638e-9e00-4762-99d9-90826187fcf6@kernel.org>
Date: Fri, 21 Mar 2025 10:19:26 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 1/2] mptcp: add bpf_iter_task for mptcp_sock
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, mptcp@lists.linux.dev
References: <cover.1741577149.git.tanggeliang@kylinos.cn>
 <e04cc2fa5f500097ac7d95afb94f68d0d8dc0057.1741577149.git.tanggeliang@kylinos.cn>
 <c151a68a659659a2bc8632b63cb04cb59275ec83.camel@kernel.org>
 <a92d50cf-2eb3-4c56-91cd-0dfa3eb43f7f@kernel.org>
 <2b680d20eb5873f14f35d9d23aa78b2f5a9d5bfd.camel@kernel.org>
 <459fd93c-d99d-4733-9194-3f62467854c6@kernel.org>
 <05be0df71bcac1bf0f24a7637ba1652aebb8a312.camel@kernel.org>
 <bf2ad4ed-bf4a-47c7-a7d5-eb23c0825198@kernel.org>
 <e26c30144a91e8452ae2bf6dc1c0cea91becdf58.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <e26c30144a91e8452ae2bf6dc1c0cea91becdf58.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 21/03/2025 05:14, Geliang Tang wrote:
> On Tue, 2025-03-18 at 12:26 +0100, Matthieu Baerts wrote:

(...)

>> Mmh, all 8 callbacks from add_addr to here seem to be linked to
>> Netlink
>> commands, right? If yes, they should not be here: they don't make
>> sense
>> for a BPF PM, no? BPF PMs should be configured with BPF, and not via
>
> Do you have any idea how we can pass commands like ADD_ADDR and
> addresses from user space to BPF?

The userspace can inject any kind of BPF program. Additional addresses
can then be hardcoded in this program, or it can load them from eBPF
maps, or read skel->bss->(...), etc.

Netlink is then not needed.

> What I can think of is passing through sockopt, the user space passes
> the command and the address through setsockopt, and the BPF program
> handles it through the custom "cgroup/setsockopt". I would like to hear
> your opinions. If you also agree to use sockopt to implement it, I can
> write a test program for this.
That's a good idea for userspace apps which want to control how the
MPTCP PM is acting. I guess MPTCP BPF PM will generally not be linked to
network apps: a separate application dedicated to inject and configure
the BPF PM, no?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

