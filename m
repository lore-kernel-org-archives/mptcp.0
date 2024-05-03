Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0D08F47
	for <mptcp@lists.linux.dev>; Fri,  3 May 2024 01:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714698263; cv=none; b=jVETdvWrD/NP/UWnEYpyYlmaKTsTcLh1R/4FmRMkDli2W+4VfFlQLhl+gFmnAvBeJlitoLBFgL1BD/xRCsRbuw917Clw7HkLGRz16PplNZDtvmcLPPO5KWyXc8VuAX4E5b92TGn9OweiFAw5/rNVmQNt0Z3o3TZe5aA6XYyfZxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714698263; c=relaxed/simple;
	bh=jZkdoJ3BUTNDWEAPjT+j5CgKGepY3UgY0LAub3yKHXk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZVLdHJUdx7fja1UH5KSpcawky3f8dsAd63wh55zpwcynw9ZcAm7KdiYl5E1uJqEydzFfTdUROpSppHSEZLNtAP8kl2LG8brF6wOHfuyKp6mpbSc6FKRlIiSLBsA3UtSlS8zsRYsJ/EEg7vX5UzVa8KhDrTYhtkQmmkiAx+ZlRDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4tYPc6i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4tYPc6i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2403AC113CC;
	Fri,  3 May 2024 01:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714698263;
	bh=jZkdoJ3BUTNDWEAPjT+j5CgKGepY3UgY0LAub3yKHXk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=W4tYPc6ia46itey65hmGF41WzGUEQ0pEONe9lPA3D31cp7XnJ1HKoeVPPMJy5OM62
	 DYWiLLp+dPdTI6CA3q4ZZbOOFD7hw/YVsOxlsSdHXd14FtDxZwml8PRVqA9osPpb2r
	 eBowccstQy8TAnhTr5awV0fo2ep/NTdHdXuGxzDHk1MyXkLzfAr/ECbSsqBW9OjIty
	 8nKCuEG1l/hAHbwr6Zfe9KuJno6UiDDOOf5bl0hAFvN59iH0oKFt1/M5d91WqvXfI2
	 HjbjhNFNGM9CBBdWNiH85WMeyU9wwUQvyj4jTZQQgQYQ3ZANowTy2MxICi6XfrGVV4
	 CHk9NUkt/6nbQ==
Date: Thu, 2 May 2024 18:04:22 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Gregory Detal <gregory.detal@gmail.com>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next 0/2] mptcp: fix net.mptcp.scheduler behavior
In-Reply-To: <20240430-sysctl_scheduler-v1-0-8187148850df@gmail.com>
Message-ID: <68e0b31b-7c29-433b-eda0-a31bca639031@kernel.org>
References: <20240430-sysctl_scheduler-v1-0-8187148850df@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 30 Apr 2024, Gregory Detal wrote:

> The sysctl is accepting any input. This patchset ensures only
> existing scheduler can be set.
>
> Moreover, this adds an helper sysctl to list the available scheduler
> similarly to tcp_available_congestion_control.
>
> The first patch of the series is a fix for mptcp-net.
>
> Signed-off-by: Gregory Detal <gregory.detal@gmail.com>

Series looks good to me as well (and Matthieu can remove that newline if 
he'd like). Thanks for the patches!

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> Gregory Detal (2):
>      mptcp: only allow set existing scheduler for net.mptcp.scheduler
>      mptcp: add net.mptcp.available_schedulers
>
> include/net/mptcp.h  |  3 +++
> net/mptcp/ctrl.c     | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++--
> net/mptcp/protocol.h |  1 +
> net/mptcp/sched.c    | 22 +++++++++++++++++
> 4 files changed, 91 insertions(+), 2 deletions(-)
> ---
> base-commit: dd741144c1d1e3bd1fed5eb0ded1934c9230b4ef
> change-id: 20240430-sysctl_scheduler-13367d5bf81a
>
> Best regards,
> -- 
> Gregory Detal <gregory.detal@gmail.com>
>
>
>
