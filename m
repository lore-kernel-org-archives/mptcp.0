Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C67F2F37
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 03:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740369400; cv=none; b=FhsWCfrJ2fgs3suOuUwyh6/MJEevFj8dDZZOUdzYYJOdt6EPGAlyscULJl0xJb8T6n8HgqRBJLSKR1v0wfXYor8cVsvP2PKxydwm9po1TOCnPw/DTmUwRct8aNqk9ICSyc73fk5O3O5Mi8sH4Z7FWPWou//N4m8hukueEo/iBBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740369400; c=relaxed/simple;
	bh=iXys2Drn20TfIR2M8xN1NCK7rWHFSpYQqBsgm36Vgqo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fEzRLkrcRucxpVULaBmEKTuoXv8Fh1Cr5lNUWUDvCyZfPWjWWp0lRI3sQqntPC5te8VYBsClDjnRa8Xsf6p2Uem2fKLi27YH+szTSpzJa0lVhbgUBEfZ/FmO7EkzRS24cw42DrcEVa7gte+hDIoeYNvEbFkgtHQiYSnkiJ5CBPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLyabbOU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLyabbOU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E1EC4CED6;
	Mon, 24 Feb 2025 03:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740369399;
	bh=iXys2Drn20TfIR2M8xN1NCK7rWHFSpYQqBsgm36Vgqo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XLyabbOUVxz2v5FvRfCzVvMuJxSd27vfUlPuN2L4d1xtKuRwEDOnhdKqMU3IADVuQ
	 vVD/VKR7D1QN3ny5CTcShK4+QhxoahJrCz9WMrYz2DAVfNvHF0Xr9TxAyycaAo1cr4
	 YI9RytkZljrVly6saon+twuZu2ceoJoB/1UvBj95NJLdJ2tSw7OULYrv6+N+r/AGJi
	 cdfg9tGFZARu8paQB54snIxkEmDCkWpFa7KfewB3+DFCrzbjAppCpC3VDJwtJF2QtE
	 Je21x+xvN9p1s2ZRG9wUG6Q/F7P0wW+7aWvujnV3eBE1Q5m+CA90Q5SQtBxqgY14Ve
	 0wadFGTdQNu4w==
Message-ID: <f00934e9dd1c6adccadb7611e1ee6daa4734e202.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v4 0/5] Squash to "Add mptcp_subflow bpf_iter
 support"
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Mon, 24 Feb 2025 11:56:35 +0800
In-Reply-To: <cover.1740368110.git.tanggeliang@kylinos.cn>
References: <cover.1740368110.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2025-02-24 at 11:37 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> v4:
>  - drop sock_owned_by_user_nocheck and spin_is_locked. According to
>    comments from Mat and Martin, in this set mptcp_subflow
>    bpf_iter only used from a cg sockopt bpf prog, no need to add
> these
>    check at this moment.

The commit log of "bpf: Register mptcp common kfunc set" doesn't match
the code, please update it as:

'''
bpf: Register mptcp common kfunc set

MPTCP helper mptcp_subflow_ctx() is used to convert struct sock to
struct mptcp_subflow_context. It will be used in MPTCP BPF programs.

This patch defines corresponding wrapper of this helper, and put it
into the newly defined mptcp common kfunc set and register this set
with the flag BPF_PROG_TYPE_CGROUP_SOCKOPT to let it accessible to
the 'cgroup/getsockopt' type of BPF programs.
'''

Thanks,
-Geliang

> 
> v3:
>  - patch 3, continue to use sock_owned_by_user_nocheck() and
> spin_is_locked()
> checks instead of using msk_owned_by_me().
>  - patch 5, drop declaration of bpf_mptcp_subflow_tcp_sock. It's no
> longer
> used.
>  - patch 5, update the comment for mptcp_subflow_tcp_sock(), which is
> a BPF
> helper, not a kfunc.
> 
> The commit log of "bpf: Register mptcp common kfunc set" doesn't
> match the
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
>  - Drop bpf_skc_to_mptcp_sock
>  - Check the owner before assigning the msk as Mat suggested.
>  - Use bpf_core_cast() in mptcp_subflow bpf_iter subtest instead of
> using bpf_skc_to_mptcp_sock().
> 
> Address Martin's suggestions for "Add mptcp_subflow bpf_iter support"
> v2.
> 
> Geliang Tang (5):
>   Revert "bpf: Extend bpf_skc_to_mptcp_sock to MPTCP sock"
>   Revert "bpf: Allow use of skc_to_mptcp_sock in cg_sockopt"
>   Squash to "bpf: Add mptcp_subflow bpf_iter"
>   Revert "bpf: Acquire and release mptcp socket"
>   Squash to "selftests/bpf: Add mptcp_subflow bpf_iter subtest"
> 
>  include/net/mptcp.h                           |  4 +-
>  kernel/bpf/cgroup.c                           |  2 -
>  net/core/filter.c                             |  2 +-
>  net/mptcp/bpf.c                               | 41 ++++-------------
> --
>  .../testing/selftests/bpf/bpf_experimental.h  |  2 +-
>  tools/testing/selftests/bpf/progs/mptcp_bpf.h |  5 ---
>  .../selftests/bpf/progs/mptcp_bpf_iters.c     | 10 ++---
>  7 files changed, 15 insertions(+), 51 deletions(-)
> 

