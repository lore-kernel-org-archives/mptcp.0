Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2211799F
	for <mptcp@lists.linux.dev>; Wed, 29 Apr 2026 00:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777421346; cv=none; b=AE41xgikjcFTJALhXm8Wa4IgYo/1+a9Zs5wBi9ga5XN4AgD11QhtS0aev9v4Zc2K/wTp2sTydFDMW8SNKeq3a8It6OkTY3ctyfzF+S82xkZEJRROKNWyu9rL8S8HkWjxPwCaP9Xem8X7iHniMN3uu8Qk8S6j8bHsxJ1+kDniCZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777421346; c=relaxed/simple;
	bh=O9i7uoeYNMRCQU75797W15Zl8EHvL0I8ZaVAuQikAuY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cs0sK9b0oBhrcWJAZhNAAWsJKUwrS61ORnpyoGLOZ0BPpXWXzCy8U0jmhXzoM0iIRb78H4BMrMawXrdGZ3B9uc3A0M+W8IN2XoGYLOOCpGttB/mML5Y1XQe+Z8qknnibDA9deVBinFdiC7eGfAf7TgWu1oQ/Lyn/GUxWDtmAoyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkZQM3T0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkZQM3T0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB5FC2BCAF;
	Wed, 29 Apr 2026 00:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777421346;
	bh=O9i7uoeYNMRCQU75797W15Zl8EHvL0I8ZaVAuQikAuY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=AkZQM3T0+v/JXppHpn9wTi0nxVwa/Ycs0rOBYc6GYbC8U+VdxzaaTFsH9K49kYaUk
	 G2hySPKD+em+8hrx4HbR4hyfdEbHqOxAtJZPOEyrVs3/+LciNxXRzq/K5z9vCnv4+D
	 t02awNaH4WRKgRIo45bwhI5c2xAoy0pxEstf8UF1q1oKvnbGVK7QT19h2PQlgu7+9I
	 qpj7iOmd9/WuCwZnJn9xbquGK+orerqDsckTJqEJfwSHRFAxxDuvWnlwXsKTJiG3Nh
	 UPHoLMmtKb0bqImN2IkwrBPPh5HY9B0uRak0oqbobP0OISmFCNRbggLLoZQBh8HpFc
	 0Evj4HkZAf+/Q==
Date: Tue, 28 Apr 2026 17:09:05 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net v6 00/19] mptcp: pm: increase limits, and
 related fixes and cleanup
In-Reply-To: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
Message-ID: <8a91a5e4-1fa2-6c06-8cc4-89a4f3d87d36@kernel.org>
References: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 22 Apr 2026, Matthieu Baerts (NGI0) wrote:

> The initial intension was to increase the limits, but some fixes were
> needed, then when looking at the code around, other fixes had to be
> added too. So now I ended up with multiple fixes (including one early
> exit while at it), followed by patches increasing limits with some
> adaptations required before, some to validate the modifications, and one
> small improvement in the selftests.
>
> The patches with a Fixes tag are for -net, the rest for net-next.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Changes in v6:
> - patch 4: fix label name in commit message + mention next patch.
> - patch 7: use min() to improve clarity (Mat)
> - patch 15: fix typo.
> - patch 20: removed: will be sent in another series after that one.
> - Link to v5: https://patch.msgid.link/20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org

Hi Matthieu -

v6 LGTM, thanks for the updates.

Reviewed-by: Mat Martineau <martineau@kernel.org>

>
> Changes in v5:
> - patch 5: only set timer_done to true in the timer handler: safer.
> - patch 9: fix typo in commit message.
> - patch 10: 3rd check expects error, better err msg, rename var.
> - Link to v4: https://patch.msgid.link/20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org
>
> Changes in v4:
> - patch 5: reset timer_done when the timer is reset.
> - patch 10: new: selftests: correctly catch error in 'check output'.
> - patch 16: add example with init_shapers to silence AI reviews
> - Patch 18: clearer way to check errors (without buggy '&&')
> - Link to v3: https://patch.msgid.link/20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org
>
> Changes in v3:
> - patch 1: new: retransmit ADD_ADDR for ID 0 with right ID.
> - patch 5: moved below + support calling sk_free().
> - patch 13: new: allow flushing more than 8 endpoints.
> - patch 12: clarify single batch of 8 subflows as known limit.
> - patch 16: fix typo in comment.
> - Link to v2: https://patch.msgid.link/20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org
>
> Changes in v2:
> - patch 2: new: fix potential data-race.
> - re-order patches 1 to 5 and use shorter prefix (ADD_ADDR rtx).
> - patch 6: restore accidentally deleted icsk->icsk_rto > max check.
> - patch 16: fix already present checkpatch warning.
> - Link to v1: https://patch.msgid.link/20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org
>
> ---
> Matthieu Baerts (NGI0) (19):
>      mptcp: pm: kernel: correctly retransmit ADD_ADDR ID 0
>      mptcp: pm: ADD_ADDR rtx: fix potential data-race
>      mptcp: pm: ADD_ADDR rtx: allow ID 0
>      mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
>      mptcp: pm: ADD_ADDR rtx: free sk if last
>      mptcp: pm: ADD_ADDR rtx: resched blocked ADD_ADDR quicker
>      mptcp: pm: ADD_ADDR rtx: skip inactive subflows
>      mptcp: pm: retrans ADD_ADDR: return early if no retrans
>      mptcp: pm: prio: skip closed subflows
>      selftests: mptcp: check output: catch cmd errors
>      selftests: mptcp: pm: restrict 'unknown' check to pm_nl_ctl
>      mptcp: pm: in-kernel: explicitly limit batches to array size
>      mptcp: pm: in-kernel: increase all limits to 64
>      mptcp: pm: kernel: allow flushing more than 8 endpoints
>      mptcp: pm: in-kernel: increase endpoints limit
>      selftests: mptcp: join: allow changing ifaces nr per test
>      selftests: mptcp: join: validate 8x8 subflows
>      selftests: mptcp: pm: validate new limits
>      selftests: mptcp: pm: use simpler send/recv forms
>
> net/mptcp/pm.c                                  | 62 +++++++++++------
> net/mptcp/pm_kernel.c                           | 90 ++++++++++++++++---------
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 33 ++++++++-
> tools/testing/selftests/net/mptcp/mptcp_lib.sh  | 16 +++--
> tools/testing/selftests/net/mptcp/pm_netlink.sh | 74 ++++++++++++--------
> tools/testing/selftests/net/mptcp/pm_nl_ctl.c   |  8 +--
> 6 files changed, 193 insertions(+), 90 deletions(-)
> ---
> base-commit: b3fa12c3ddab70d570c42071efb0edd5dad07060
> change-id: 20260403-mptcp-inc-limits-ce9811024066
>
> Best regards,
> --
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
