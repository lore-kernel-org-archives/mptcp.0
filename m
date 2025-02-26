Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B991EAFA
	for <mptcp@lists.linux.dev>; Wed, 26 Feb 2025 01:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740534170; cv=none; b=b7aJEuK1+S/m5TkbrTUi2dELjU14iHTGzPX6uMFDboabBQTsdaFqFuaKIrTghQBe2u7g0QA9+k0tO4i8cVcIxk+rgS6BAuLMCYVEp1UfRoyF3Qu3Wi6NGP9poUsovWm5CZDNQuFBKoUL86hw+KCUcm7k2zr2bN8wBtfRmFQwo4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740534170; c=relaxed/simple;
	bh=WuozcZVX8nVGda7dyEHBGrxQQvLQgZhpBmgnBuSMKxE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qs18/zQMUxc2kfkpbuCsHjrdMmQQ/17kdnwkF7eu5qcXjrCzoBc/eyTIF79ZNhaTEf/bp6IhhGDthuI00ky/y8UsgjYEt96OSCSPVHt8nxAW4OOTHom/1Gf3qbI6NkZfVTUk8q1NNODaSFtE3AHtuBNZL0a2svPR5LJyh7nqSho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1nfIZtP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1nfIZtP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71089C4CEDD;
	Wed, 26 Feb 2025 01:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740534169;
	bh=WuozcZVX8nVGda7dyEHBGrxQQvLQgZhpBmgnBuSMKxE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=S1nfIZtP5Y+bAzvzY1I2QoVOAa4ndzMT3cz7kag+sxBrQ7i2eTp5XS1SDbMT049k2
	 nG0l7zzAX/TFDn5zI/sTCCg55212y5cs37KLnj8Oy25yJMRU4XdoWqfi7VuMwCr3wQ
	 +CPLoIx21IRl/hAxF+zSAQqdvlhN3BvdNO8g5hzxbXEUbx0WCEEA9bRAYPOmgjtu/U
	 gc4cFw7g41gJmz8exFsGoKdkR+iNI2d+fZwPA9mVdVq7BzXEX5C3nCz9mAt8hKC3J8
	 z7ugj6YigsTIlCt5DbxdLp8R2OjLf5uCjRQTCp5ZEh8JPScrRmCcLgFX2RGKWzkTzF
	 9fpsybYw9UzdQ==
Date: Tue, 25 Feb 2025 17:42:48 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v15 0/8] use bpf_iter in bpf schedulers
In-Reply-To: <cover.1739788598.git.tanggeliang@kylinos.cn>
Message-ID: <0474cace-93d7-c7f6-acb9-f218ab422275@kernel.org>
References: <cover.1739788598.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 17 Feb 2025, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> v15:
> - patch 7, add the declaration of bpf_mptcp_subflow_tcp_sock
>
> Depends on:
> - Squash to "Add mptcp_subflow bpf_iter support", v3
>
> Based-on: <cover.1739787744.git.tanggeliang@kylinos.cn>

Hi Geliang -

I don't have any changes to suggest to this series, so I'll add my 
reviewed tag even though this can't be applied to the export branch yet 
(until the bpf_iter series is updated):

Reviewed-by: Mat Martineau <martineau@kernel.org>

>
> v14:
> - patch 1, keep mptcp_sched_data_set_contexts() helper for future use.
> - patch 2, use "sk = sk__ign" in bpf_mptcp_subflow_ctx() and
>   bpf_sk_stream_memory_free().
> - patch 8, drop "subflows" from struct mptcp_sched_data too.
>
> v13:
> - use '__ign' suffix to ignore the argument type checks of
>   bpf_mptcp_subflow_ctx() and bpf_sk_stream_memory_free(),
>   instead of adding a new helper bpf_mptcp_send_info_to_ssk().
> - use 'bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk)' instead
>   of using 'bpf_for_each(mptcp_subflow, subflow, msk)'.
> - keep struct mptcp_sched_data for future use.
>
> v12:
> - drop struct mptcp_sched_data.
> - rebased on "split get_subflow interface into two" v2.
>
> v11:
> If another squash-to patchset (Squash to "Add mptcp_subflow bpf_iter
> support") under review is merged before this set, v10 will fail to run.
> v11 fixes this issue and can run regardless of whether it is merged
> before or after the squash-to patchset.
>
> Compared with v10, only patches 3, 5, and 8 have been modified:
> - use mptcp_subflow_tcp_sock instead of bpf_mptcp_subflow_tcp_sock in
>   patch 3 and patch 5.
> - drop bpf_mptcp_sched_kfunc_set, use bpf_mptcp_common_kfunc_set instead
>   in patch 8.
>
> v10:
> - drop mptcp_subflow_set_scheduled() helper and WRITE_ONCE() in BPF.
> - add new bpf helper bpf_mptcp_send_info_to_ssk() for burst scheduler.
>
> v9:
> - merge 'Fixes for "use bpf_iter in bpf schedulers" v8' into this set.
> - rebased on "add netns helpers" v4
>
> v8:
> - address Mat's comments in v7.
> - move sk_stream_memory_free check inside bpf_for_each() loop.
> - implement mptcp_subflow_set_scheduled helper in BPF.
> - add cleanup patches into this set again.
>
> v7:
> - move cleanup patches out of this set.
> - rebased.
>
> v6:
> - rebased to "add mptcp_subflow bpf_iter" v10
>
> v5:
> - patch 2, drop mptcp_sock_type and mptcp_subflow_type.
> - patch 3, revert "bpf: Export more bpf_burst related functions"
> - patch 4, merge "bpf: Export more bpf_burst related functions" into it.
>
> v4:
> - patch 2, a new cleanup for "bpf: Add bpf_mptcp_sched_ops".
> - patch 3 should be reverted.
> - patch 8, register kfunc_set.
>
> v3:
> - rebased.
> - put the "drop has_bytes_sent" squash-to patch into this set.
>
> v2:
> - update bpf_rr and bpf_burst
>
> With the newly added mptcp_subflow bpf_iter, we can get rid of the
> subflows array "contexts" in struct mptcp_sched_data. This set
> uses bpf_for_each(mptcp_subflow) helper to update all the bpf
> schedules:
>
>        bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
>                ... ...
>                mptcp_subflow_set_scheduled(subflow, true);
>        }
>
> Geliang Tang (8):
>  Squash to "mptcp: add sched_data helpers"
>  Squash to "bpf: Export mptcp packet scheduler helpers"
>  Squash to "selftests/bpf: Add bpf_first scheduler & test"
>  Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
>  Squash to "selftests/bpf: Add bpf_rr scheduler & test"
>  Squash to "selftests/bpf: Add bpf_red scheduler & test"
>  Squash to "selftests/bpf: Add bpf_burst scheduler & test"
>  mptcp: drop subflow contexts in mptcp_sched_data
>
> include/net/mptcp.h                           |  4 -
> net/mptcp/bpf.c                               | 50 ++++++------
> net/mptcp/protocol.h                          |  2 -
> net/mptcp/sched.c                             | 15 ----
> tools/testing/selftests/bpf/progs/mptcp_bpf.h |  5 +-
> .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 16 +---
> .../selftests/bpf/progs/mptcp_bpf_burst.c     | 78 +++++++------------
> .../selftests/bpf/progs/mptcp_bpf_first.c     |  8 +-
> .../selftests/bpf/progs/mptcp_bpf_red.c       |  8 +-
> .../selftests/bpf/progs/mptcp_bpf_rr.c        | 31 ++++----
> 10 files changed, 83 insertions(+), 134 deletions(-)
>
> -- 
> 2.43.0
>
>
>
