Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB44F30506E
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758277230; cv=none; b=ppn8jvJ3mmH412A3Skouh2pFCqPHWBvUp7H9r4DWXdv49ZrxXVoo/OjCJ4t0KDFCY9nP3d5U+e+yox46aVep2H3ahiO5AOWB9ZXV/qFiiwJDyCDUA6HoiTXUTIgaSehBSKPDRW2nZ7Nr8tm8BpLlY7XvcVeyEy8bcvbknkO8buY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758277230; c=relaxed/simple;
	bh=vSCPIN+bt59li7BHiT1N69aV0lBUSJDFyXiyDFFwUQ0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fH2HB9vFOXK2h53QbRpDhkA4WryRYEpATysFsshrkxuR7LvsOPOpkexE018sKjU9dzFDTmw4CCVmpXlAsTvktIypJYuidooZ02I+cwByIIt6n00nQnpB8OLJTvZtdiNL4IhSMXQPlA1SsMJyC3XzTK1jy396S6K4gq4a26YERfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoiU2KKa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoiU2KKa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B3AC4CEF0;
	Fri, 19 Sep 2025 10:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758277230;
	bh=vSCPIN+bt59li7BHiT1N69aV0lBUSJDFyXiyDFFwUQ0=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=LoiU2KKaiTDNV1Pu2EXquJl6FKqdjnqk6HKgSrpcXx5uXH40mcw7crZK3mWSvZ2cN
	 nSNjvfs6LZdvh9exlxx3U7x57sTSfAEExiTsKZWCEnntkLvBLgLp0C1YTCZz0z9eNX
	 25pu7LtiXpgcxq14+K67I5r7jjQvojuINQyooR9YqUjaMrLx2VKrwGH+CVOLGCXG4l
	 8ty2Q87Y1an+VotbwyQF0vyuaHOIMEC6asKPW93Mw/MCYc+MhfxczaksRaVfb6FytZ
	 z1+qF/3AV8SU0dDTCpYEshTOnodow8sX5Ffp9R3u1aGYn4wXWM3b337MXjmcFKa53I
	 HjUjsDKYV/W+Q==
Message-ID: <0e2481ae141ae8a13ae3d2c34f94e37e8e6fd1a7.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 00/10] mptcp: pm: a few cleanups
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Fri, 19 Sep 2025 18:20:27 +0800
In-Reply-To: <20250919-pm-kern-endp-add_addr-v2-0-1f8f04f01914@kernel.org>
References: <20250919-pm-kern-endp-add_addr-v2-0-1f8f04f01914@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for this v2.

On Fri, 2025-09-19 at 11:08 +0200, Matthieu Baerts (NGI0) wrote:
> I'm currently looking at adding ADD-ADDR endpoint type, see [1].
> 
> When working on this, I decided to do something we should have done
> from
> a long time: renaming some variables with confusing names, and split
> some functions.
> 
> Flushing this now, just to ease the reviews: this should be pure
> refactoring, no functional changes intended in all these commits.
> 
> Based-on:
> <20250916-pm-c-flag-client-default-v2-0-3be2c5bc4d6a@kernel.org>
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/503
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Apart from a small comment in patch 1, the whole patch set looks good
to me.

Reviewed-by: Geliang Tang <geliang@kernel.org>

-Geliang

> ---
> Changes in v2:
> - patch 1: move protocol.h modif from patch 2 (Geliang)
> - patch 3: 'Reverse X-Mas Tree' order, and comments (Geliang)
> - patches 4 & 7: avoid one line above 80 chars
> - Link to v1:
> https://lore.kernel.org/r/20250918-pm-kern-endp-add_addr-v1-0-e12e58770a11@kernel.org
> 
> ---
> Matthieu Baerts (NGI0) (10):
>       Squash to "mptcp: pm: in-kernel: usable client side with C-
> flag"
>       mptcp: pm: in-kernel: refactor fill_local_addresses_vec
>       mptcp: pm: in-kernel: refactor fill_remote_addresses_vec
>       mptcp: pm: rename 'subflows' to 'extra_subflows'
>       mptcp: pm: in-kernel: rename 'subflows_max' to
> 'limit_extra_subflows'
>       mptcp: pm: in-kernel: rename 'add_addr_signal_max' to
> 'endp_signal_max'
>       mptcp: pm: in-kernel: rename 'add_addr_accept_max' to
> 'limit_add_addr_accepted'
>       mptcp: pm: in-kernel: rename 'local_addr_max' to
> 'endp_subflow_max'
>       mptcp: pm: in-kernel: rename 'local_addr_list' to 'endp_list'
>       mptcp: pm: in-kernel: rename 'addrs' to 'endpoints'
> 
>  include/uapi/linux/mptcp.h                        |   5 +
>  net/mptcp/pm.c                                    |  17 +-
>  net/mptcp/pm_kernel.c                             | 458
> ++++++++++++----------
>  net/mptcp/pm_userspace.c                          |   2 +-
>  net/mptcp/protocol.h                              |  15 +-
>  net/mptcp/sockopt.c                               |  20 +-
>  tools/testing/selftests/bpf/progs/mptcp_subflow.c |   2 +-
>  7 files changed, 292 insertions(+), 227 deletions(-)
> ---
> base-commit: 32778f6dc930afb30f995997c12cd8b829ac1600
> change-id: 20250916-pm-kern-endp-add_addr-95cfceaef3fc
> 
> Best regards,
