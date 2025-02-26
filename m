Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F44742A9D
	for <mptcp@lists.linux.dev>; Wed, 26 Feb 2025 01:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740531915; cv=none; b=MwJT2RJAHkIdcnpWM74O4D9IaUuWnL+5xoC5wpX6ty9VmWAIanzXCaQ8xrnWAfg2H/jC0j47zOcZnM05HmXY2210ypsQfC+zCJWaBJ0VrJCe1umZ9i5bHMCVkqLhQB03wb7n7K95oZOjqV7dTLVxvcf0jirZLsRVYy+kjlh/mAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740531915; c=relaxed/simple;
	bh=wVrKRZQKgYvJqgoP4acRwUn1aT1g18JZlL3UZJsZtCc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nAbzi5R9xa7uY5wnv0ISxmWeDh/dN/jyjonmc8MEbRsWwmVwKuh+kkhoXAYgYSHMR421StxU9C2jYzlDFYiv3aa3KoBHQ7nFypvHbUpb3i9B0SMJ9GhiajOHfWMITXvVVuVeXAY0bkmyiH9vKeVJXxk65YrqxK+L1aToyNPc2EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnsmSlbS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnsmSlbS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0D5C4CEDD;
	Wed, 26 Feb 2025 01:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740531914;
	bh=wVrKRZQKgYvJqgoP4acRwUn1aT1g18JZlL3UZJsZtCc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=jnsmSlbS3RkF7Wy64nH20AMXH+VX1jZg0JXcVJ0qI14HxXg3dw4rj8B6MiYAZVz4E
	 IqK0SwmiJGewGYHXkLLMg1DKVt98oGsqWkKTEz9tS1M0Wc331G/N6JXFmxTEhbS6vI
	 tPRjO1hTRtos2SCEZkcu99wRrPEJwIdpu4hBy5FlxqGM+QB7yJIqQsO65QJlXddbmp
	 L7JKfqI5+oulpZHFvpMoS2QBaRAyyxVrvCJwjATWW0nEQ4pnN1lSn2y+CrgZDgmNOD
	 5HJNClQEoIEjmorzlcB0DlffQ2Gj3KoSbs5O7cafHjq1o0otvQbNEuLW554z+KQ7+d
	 ZMEf/7huKosWQ==
Date: Tue, 25 Feb 2025 17:05:13 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 0/5] Squash to "Add mptcp_subflow bpf_iter
 support"
In-Reply-To: <cover.1740368110.git.tanggeliang@kylinos.cn>
Message-ID: <e5992403-4b1e-91f5-cc4e-edcb6be66d1b@kernel.org>
References: <cover.1740368110.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 24 Feb 2025, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> v4:
> - drop sock_owned_by_user_nocheck and spin_is_locked. According to
>   comments from Mat and Martin, in this set mptcp_subflow
>   bpf_iter only used from a cg sockopt bpf prog, no need to add these
>   check at this moment.

Hi Geliang -

Sorry to continue the churn on this. I looked at Martin's comment in 
https://lore.kernel.org/mptcp/fdf0ddbe-e007-4a5f-bbdf-9a144e8fbe35@linux.dev/ 
where he says:

"For the cg get/setsockopt hook here, the lock should have already been 
held earlier in the kernel."

For the getsockopt case, there is a file layer lock held that ensures the 
'struct socket' remains valid while this hook is run, but no lock is 
acquired that prevents changes to msk->conn_list. It's not safe to iterate 
over the conn_list without protection from lock_sock() / unlock_sock().

As Matthieu noted in 
https://lore.kernel.org/mptcp/3b5af48e-4155-4b98-b67b-b75d9fb6285e@kernel.org/, 
when used in a bpf scheduler the msk lock will be held. But the test code 
called via getsockopt is a case where it's not protected, and a change to 
the linked list during iteration could lead to undefined behavior.

I'll talk about it with Matthieu in the meeting this week too.

- Mat


>
> v3:
> - patch 3, continue to use sock_owned_by_user_nocheck() and spin_is_locked()
> checks instead of using msk_owned_by_me().
> - patch 5, drop declaration of bpf_mptcp_subflow_tcp_sock. It's no longer
> used.
> - patch 5, update the comment for mptcp_subflow_tcp_sock(), which is a BPF
> helper, not a kfunc.
>
> The commit log of "bpf: Register mptcp common kfunc set" doesn't match the
> code, please update it as:
>
> '''
> bpf: Register mptcp common kfunc set
>
> MPTCP helper mptcp_subflow_ctx() is used to convert struct sock to
> struct mptcp_subflow_context. It will be used in MPTCP BPF programs.
>
> This patch defines corresponding wrapper of this helper, and put it
> into the newly defined mptcp common kfunc set and register this set
> with the flag BPF_PROG_TYPE_CGROUP_SOCKOPT to let it accessible to
> the 'cgroup/getsockopt' type of BPF programs.
> '''
>
> v2:
> - Drop bpf_skc_to_mptcp_sock
> - Check the owner before assigning the msk as Mat suggested.
> - Use bpf_core_cast() in mptcp_subflow bpf_iter subtest instead of
> using bpf_skc_to_mptcp_sock().
>
> Address Martin's suggestions for "Add mptcp_subflow bpf_iter support" v2.
>
> Geliang Tang (5):
>  Revert "bpf: Extend bpf_skc_to_mptcp_sock to MPTCP sock"
>  Revert "bpf: Allow use of skc_to_mptcp_sock in cg_sockopt"
>  Squash to "bpf: Add mptcp_subflow bpf_iter"
>  Revert "bpf: Acquire and release mptcp socket"
>  Squash to "selftests/bpf: Add mptcp_subflow bpf_iter subtest"
>
> include/net/mptcp.h                           |  4 +-
> kernel/bpf/cgroup.c                           |  2 -
> net/core/filter.c                             |  2 +-
> net/mptcp/bpf.c                               | 41 ++++---------------
> .../testing/selftests/bpf/bpf_experimental.h  |  2 +-
> tools/testing/selftests/bpf/progs/mptcp_bpf.h |  5 ---
> .../selftests/bpf/progs/mptcp_bpf_iters.c     | 10 ++---
> 7 files changed, 15 insertions(+), 51 deletions(-)
>
> -- 
> 2.43.0
>
>
>
