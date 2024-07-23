Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE411422CC
	for <mptcp@lists.linux.dev>; Tue, 23 Jul 2024 22:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721772242; cv=none; b=OqQE2BEI08e+6nYgQYILwKbdYUnvqSZ4V+mykE7ITBQVIPdtxzS5YXfITCgIVaRAV/2Ri+rDxprJBMlbZzCS328qESm6InfBgL2Lgi25dicY0JAi8W8TzKZ/Iv169ai86PMFSV9kB/FMLOhQwQskJFbI/uDReyCyv0L+HxTFETI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721772242; c=relaxed/simple;
	bh=d6hbWRNisy/C6tMQezPV5QPZPVcJGy9I3eJBRdmInOQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mGR6qcvYrivQFJCJHWMy3vN6Dex0w9TTlJc7pfHrVbypRW7vME5Quvwh+W4DuLUck+cYecxqdhb/dKyLORIzHJiKEUc5sfxUjrY6M94pa49S/lPgui+u/PorlL1JLyxq9fgIoRXkSJsUhSKkEIu2q8lPB+G1mcD088s/lZJBRMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBJ5Gxuf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBJ5Gxuf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A423FC4AF0E;
	Tue, 23 Jul 2024 22:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721772241;
	bh=d6hbWRNisy/C6tMQezPV5QPZPVcJGy9I3eJBRdmInOQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=VBJ5GxufH5IDa/1b6c/MecZryZiY024k0kGpQPE8REd/jkaO00BwR0nQ/da7offDI
	 GEJiXKHAjKl1CpwZW/CBEqEMBw+twZz8VHxherj/leXj0OHmxSNpZ3ZK63kevz/HoZ
	 dhCheb/fO0mYN7IyMOQLgpfOB1Dr1GqoT1zOLQGXtx4ahm2BhDQ4czE0Mc8Hwj1mPR
	 XbUEyaWjO5A4LeF6YU3JA7sWDL/AdNGry28vG/Lmfp03vVHGHbIemr9lc1CoN3MHKM
	 TvOgjy5BrHaVAgajOWyAVcyJ3SUCYsBwzsR9sxGwPTlCXodocMLdTPXFQIbU+mtCiO
	 KVcLsPgusUBVg==
Date: Tue, 23 Jul 2024 15:04:00 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net v4 00/23] mptcp: fix endpoints with 'signal'
 and 'subflow' flags
In-Reply-To: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
Message-ID: <24cfc7bc-bf53-1c0b-0110-e6ca93583a3a@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 22 Jul 2024, Matthieu Baerts (NGI0) wrote:

> When looking at improving the user experience around the MPTCP endpoints
> setup, I noticed that setting an endpoint with both the 'signal' and the
> 'subflow' flags -- as it has been done in the past by users according to
> bug reports we got -- were resulting on only announcing the endpoint,
> but not using it to create subflows: the 'subflow' flag was then
> ignored.
>
> My initial thought was to modify IPRoute2 to warn the user when the two
> flags were set, but it doesn't sound normal to ignore one of them. I
> then looked at modifying the kernel not to allow having the two flags
> set, but when discussing about that with Mat, we thought it was maybe
> not ideal to do that, as there might be use-cases, we might break some
> configs, and it was working before apparently. So instead, I fixed the
> support on the kernel side (patch 5) using Paolo's suggestion. This also
> includes a fix on the options side (patch 1), an explicit deny of some
> options combinations (patch 2), and some refactoring (patches 3 and 4).
>
> While at it, I added a new selftest (patch 7) to validate this case --
> including a modification of the chk_add_nr helper to inverse the sides
> were the counters are checked (patch 6) -- and allowed ADD_ADDR echo
> just after the MP_JOIN 3WHS.
>
> While working on that, I also noticed that re-using IDs were not
> possible in some cases -- see patches 8, 10 and 12 -- and the accounting
> was not correct in some other cases -- see patches 14 to 17.
>
> The selftests modification have the same Fixes tag as the previous
> commit, but they should not get the 'Cc: Stable' one later: if the
> backport can work, that's not, if not, no need to worry, many CIs will
> use the selftests from the last stable version to validate previous
> stable releases.
>
> The last patches don't have any modifications of the selftests attached
> to them, because the current ones were producing the new WARN() that
> have just been added.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Changes in v4:
> - Patch 19: check for msk->first != NULL
> - New patches 21-22
> - Imported patch 23: might be easier to review all of them, then this
>  single one alone, while it depends on the previous ones.
> - Link to v3: https://lore.kernel.org/r/20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org

Hi Matthieu -

I had a few typo comments, and one suggestion to split off some 
refactoring in to a net-next patch. But the functionality in the series 
looks good to me. I think we should discuss how to deal with the size of 
the series in the meeting tomorrow!

- Mat

>
> Changes in v3:
> - Small changes in patches 10 and 14, see individual changelog (Geliang)
> - New patches 18-20: small fixes
> - Link to v2: https://lore.kernel.org/r/20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org
>
> Changes in v2:
> - Do not split id_avail_bitmap per target in patch 5 (Paolo)
> - Explicit deny (patch 2), reduce indentation (patch 3), stop earlier
>  (patch 4) (Paolo)
> - New fixes and tests (patches 8-17).
> - Link to v1: https://lore.kernel.org/r/20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org
>
> ---
> Matthieu Baerts (NGI0) (23):
>      mptcp: fully established after ADD_ADDR echo on MPJ
>      mptcp: pm: deny endp with signal + subflow + port
>      mptcp: pm: reduce indentation blocks
>      mptcp: pm: don't try to create sf if alloc failed
>      mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set
>      selftests: mptcp: join: ability to invert ADD_ADDR check
>      selftests: mptcp: join: test both signal & subflow
>      mptcp: pm: re-using ID of unused removed ADD_ADDR
>      selftests: mptcp: join: check re-using ID of unused ADD_ADDR
>      mptcp: pm: re-using ID of unused removed subflows
>      selftests: mptcp: join: check re-using ID of closed subflow
>      mptcp: pm: re-using ID of unused flushed subflows
>      selftests: mptcp: join: test for flush/re-add endpoints
>      mptcp: pm: remove mptcp_pm_remove_subflow()
>      mptcp: pm: only mark 'subflow' endp as available
>      mptcp: pm: only decrement add_addr_accepted for MPJ req
>      mptcp: pm: check add_addr_accept_max before accepting new ADD_ADDR
>      mptcp: pm: only in-kernel cannot have entries with ID 0
>      mptcp: pm: fullmesh: select the right ID later
>      selftests: mptcp: join: validate fullmesh endp on 1st sf
>      mptcp: pm: avoid possible UaF whend selecting endp
>      mptcp: pm: reuse ID 0 after delete and re-add
>      mptcp: pm: reduce entries iterations on connect
>
> net/mptcp/options.c                             |   3 +-
> net/mptcp/pm.c                                  |  24 ---
> net/mptcp/pm_netlink.c                          | 210 +++++++++++++++---------
> net/mptcp/pm_userspace.c                        |  19 +--
> net/mptcp/protocol.h                            |  13 +-
> net/mptcp/subflow.c                             |  29 ++--
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 131 ++++++++++++---
> 7 files changed, 258 insertions(+), 171 deletions(-)
> ---
> base-commit: 140ff27ee47286bb0a270f3aa275fc319724da8d
> change-id: 20240620-mptcp-pm-avail-f5e3957be441
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
