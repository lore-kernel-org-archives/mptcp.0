Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2409818BC3B
	for <mptcp@lists.linux.dev>; Mon,  8 Sep 2025 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352173; cv=none; b=Ra01c41guj3h7mkXYkU5RSdavoaXNX/MGRds7pGwXjFx3bGWlUpPFqyjR3vk2oEPTFPjTbZ742QDTLpDfxOGdnd7T+a3zUagmMaUdH/vA71mEop2Eg8cepGmRxE9dZxtsxiHghfDpfDG3ZS9OshVIvnrrvl9MLZ1TTjEvPfPwmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352173; c=relaxed/simple;
	bh=s22dBdLBa5LGCSr3B9n2t9WBTj8xZAZ8FH+BO604cKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qz0N12GOa+DriZ8o8/dkDwAgaSPzE0ya+XoSRvH2K9pfZTun4vagUIH/w20aVdVn7qBWVzVskfO7uJvewC41jUsWD+qX27E6p9xHmxRbhxze/EkRVpTotZsd5VU6BdFSSYzFAtilct7XKjT+1+9H+FpZ3QozG1C/9fVygEam1As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=demjOcoz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="demjOcoz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FF3C4CEF1
	for <mptcp@lists.linux.dev>; Mon,  8 Sep 2025 17:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757352173;
	bh=s22dBdLBa5LGCSr3B9n2t9WBTj8xZAZ8FH+BO604cKc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=demjOcozT7h8zZVJ59+nMDX2m0tdeeRg8vloHfztHqsEnvpxioYFizVt/7zNYzS1V
	 Pm6OYjItmHmnbL4MfT6arXE+BT2FYX0cvirYsXfHN1WxOcR2ndvbKPMKridfnCO3HO
	 GALVxLywjO7Mp4/olv19+d90KWjfwdYlSD4OW4GdB5DrKyB+0W90HQ58j/g9TTmDHm
	 5lDJQ6YlqwdlogEJL+Wn3xXutAminCBu8247p1LfZ5VuIF9vnIKN0u2eh67/RoSjl3
	 ZnkMg17Xi9d/3dfdjfFcMAJtAqZsM4HKf6bcjPYyyFznKK5U2hfhFg9QFSOtGIY+8v
	 hI+oHdKGfp3Kw==
Message-ID: <7a3a1796-5375-4f31-aa76-4a194ee13eab@kernel.org>
Date: Mon, 8 Sep 2025 19:22:50 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 0/7] mptcp: pm: nl: announce deny-join-id0
 attribute
Content-Language: en-GB, fr-BE
To: MPTCP Linux <mptcp@lists.linux.dev>
References: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 29/08/2025 22:33, Matthieu Baerts (NGI0) wrote:
> During the connection establishment, a peer can tell the other that it
> cannot establish new subflows to the initial IP address and port by
> setting the 'C' flag [1]. Doing so makes sense when the sender is behind
> a strict NAT, operating behind a legacy Layer 4 load balancer, or using
> anycast IP address for example.
> 
> When this 'C' flag is set, the path-managers must then not try to
> establish new subflow to the other peer's initial IP address and port.
> The in-kernel PM has access to this info, but the userspace PM didn't.
> 
> The last patch is adding the new attribute in the Netlink events. Please
> see the note with a question about how to add this new attribute.
> 
> But before that, a few fixes have been added:
> 
> - Patch 1: add remote_deny_join_id0 info on passive connections. A fix
>   for v5.14.
> 
> - Patch 2: respect the deny_join_id0 attribute by blocking the creation
>   of new subflows to the initial IP address and port if set. A fix for
>   v5.19.
> 
> - Patch 3: record the deny_join_id0 info when TFO is used. A fix for
>   v6.2.
> 
> - Patch 4: fix a wrong attribute type in the Netlink MPTCP specs. A fix
>   for v6.7.
> 
> - Patch 5: stop mentioning net.mptcp.pm_type in the doc as it is
>   deprecated. A fix for v6.15.
> 
> - Patch 6: support Shellcheck v0.11.0 in the MPTCP selftests.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Matthieu Baerts (NGI0) (7):
>       mptcp: set remote_deny_join_id0 on SYN recv
>       mptcp: pm: userspace: respect deny_join_id0 attr
>       mptcp: tfo: record 'deny join id0' info

>       netlink: specs: mptcp: fix if-idx attribute type
>       doc: mptcp: net.mptcp.pm_type is deprecated
>       selftests: mptcp: shellcheck: support v0.11.0

I just applied these last 3 patches, reviewed by Geliang (Thanks)

New patches for t/upstream-net and t/upstream:
- 7dae247dbfe1: netlink: specs: mptcp: fix if-idx attribute type
- ef0f22271156: doc: mptcp: net.mptcp.pm_type is deprecated
- f44e77b81e04: selftests: mptcp: shellcheck: support v0.11.0
- Results: 64d8ee7c00d0..d449a1cf7863 (export-net)
- Results: 64f95ae49169..f6a1bd069542 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/bdfdb385586b1310d7789298f64a9a4075d879c5/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/9c5417b6ec48952bda958c08960c129f69f0314a/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

