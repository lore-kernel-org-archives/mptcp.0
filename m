Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411E3152196
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 01:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736300960; cv=none; b=dZpHhTGkMK3CCrzA/9+qPRIkQZusm9IrDGXC0COF2CkvjFzyh7IbTYbMv7o2sx32gzMofTAC+smE9sm4UnVVClG+d33Cy4SdKPMnrgWKqNfEXINtzQpph4SEtTTVAK8JNiwUEC/AYe6zrt4AnVwDPBem3VbWHuyK0mgAIj1ZjQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736300960; c=relaxed/simple;
	bh=dIgR8froYhqD5QqOBAYwp6x4gQe0yJXzap7O9fCx2fA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=il0/kL0r/rlTR6n3y0TnSwGkMNDHOqT8WwDqkwmN0MQ2nB1xxZj5TZMs+/m+5ohwb44WqbemEBfR/FzSbnDptcyzIjgRILDxQCOECDmYbsG7R0xKFckJ0pbeHzfa3HwvP9+4Z0vJAWPha0ngaaMd894srq8UUX0jHtehS/k+9Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJhRDGx9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJhRDGx9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D4FC4CED6;
	Wed,  8 Jan 2025 01:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736300958;
	bh=dIgR8froYhqD5QqOBAYwp6x4gQe0yJXzap7O9fCx2fA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=DJhRDGx9caGuIcS9piBSCyo7dsMf3TuZ6d0gIAYJu/2gFlf3piFg2UO/do5Kx+GNh
	 i7wnSHhYogmkYS3CDei95UK/ksLiPeGXriNmyw0Et4jrU4YBJdU42vUyjPUmLCTWxn
	 Dp+5hpiJpWuotOqM9O3SEJ3BEb0u4FncUyQhrRC0pt5E2LHv0eClDIxJek9Olu7sMW
	 owmnJzoY/D3ECqnszwVb3MCP5Rku3gSLmQcfVmdn1fsOY22cdpRAYYRww42ztTRmuQ
	 g4HGYRpqRdF27M2w9ZAFyjpXXp0u2ySizr0LC6acyGF3r5JQVAUPZhQBxAsYB45y+K
	 SsKeTX86bWOaw==
Date: Tue, 7 Jan 2025 17:49:18 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 0/9] net: sysctl: avoid using
 current->nsproxy
In-Reply-To: <20250107-mptcp-sysfs-netns-v1-0-2fa7075d9970@kernel.org>
Message-ID: <d79d6baa-7215-a7f3-df35-c802fafb073e@kernel.org>
References: <20250107-mptcp-sysfs-netns-v1-0-2fa7075d9970@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 7 Jan 2025, Matthieu Baerts (NGI0) wrote:

> As pointed out by Al Viro and Eric Dumazet in [1], using the 'net'
> structure via 'current' is not recommended for different reasons:
>
> - Inconsistency: getting info from the reader's/writer's netns vs only
>  from the opener's netns.
>
> - current->nsproxy can be NULL in some cases, resulting in an 'Oops'
>  (null-ptr-deref), e.g. when the current task is exiting, as spotted by
>  syzbot [1] using acct(2).
>
> The 'net' or 'pernet' structure can be obtained from the table->data
> using container_of().
>
> Note that table->data could also be used directly in more places, but
> that would increase the size of this fix to replace all accesses via
> 'net'.
>
> Patches 2-9 remove access of net via current->nsproxy in sysfs handlers
> in MPTCP, SCTP and RDS. There are multiple patches to ease the
> backports.
>
> Patch 1 is not directly linked to this, but it is a small fix for MPTCP
> available_schedulers sysctl knob to explicitly mark it as read-only.
>
> Please note that this series does not address Al's comment [2]. In SCTP,
> some sysctl knobs set other sysfs-exposed variables for the min/max: two
> processes could then write two linked values at the same time, resulting
> in new values being outside the new boundaries.


Thanks Matthieu,

The mptcp patches (1-3) LGTM:

Reviewed-by: Mat Martineau <martineau@kernel.org>


The sctp and rds patches look fine as well.


- Mat


>
> Link: https://lore.kernel.org/67769ecb.050a0220.3a8527.003f.GAE@google.com [1]
> Link: https://lore.kernel.org/netdev/20250105211158.GL1977892@ZenIV/ [2]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Matthieu Baerts (NGI0) (9):
>      mptcp: sysctl: avail sched: remove write access
>      mptcp: sysctl: sched: avoid using current->nsproxy
>      mptcp: sysctl: blackhole timeout: avoid using current->nsproxy
>      sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy
>      sctp: sysctl: rto_min/max: avoid using current->nsproxy
>      sctp: sysctl: auth_enable: avoid using current->nsproxy
>      sctp: sysctl: udp_port: avoid using current->nsproxy
>      sctp: sysctl: plpmtud_probe_interval: avoid using current->nsproxy
>      rds: sysctl: rds_tcp_{rcv,snd}buf: avoid using current->nsproxy
>
> net/mptcp/ctrl.c  | 17 +++++++++--------
> net/rds/tcp.c     | 39 ++++++++++++++++++++++++++++++++-------
> net/sctp/sysctl.c | 14 ++++++++------
> 3 files changed, 49 insertions(+), 21 deletions(-)
> ---
> base-commit: 474ab61b2b3a9a0c31267efe807c4fed12d66d28
> change-id: 20250105-mptcp-sysfs-netns-23723ba85401
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
