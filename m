Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14836EEA9
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 01:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741225823; cv=none; b=JBH9pMbn+azqgqc0U375FVqGfzONtXdE60q8x1A/LglsaMzn4QALKAeYjXJay9Dn4hfTM1cW35IxVd37K0wpYPekHTfz0XYpLM7ULy8AkgZifAMw9GMl1LQuX0/IPUwRS/BMIyGviWXMzT8UtJz5Y/SW0DwVsun2lQTcbG3r9wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741225823; c=relaxed/simple;
	bh=v5/kLGuAblrTXT5o0ZWA4PckJOK9SyYrzQgX1KMJT8g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lW8//5R17jxdq5eHSMIc2AJpYJ1UYOuK53fTMQibGf8NZS+6Gq9hGGiEXZTDumTY8dPb6q1JluC/iX1UbdZ0ftT15D3lmKYQPV8PxGqzdLTIXORcroBFPtKj2dh6F/k4oTEjGuvmxgKju4K2VWakp3UozHxok4oDFghbbYit+6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbG9RRLk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbG9RRLk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D7DC4CED1;
	Thu,  6 Mar 2025 01:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741225822;
	bh=v5/kLGuAblrTXT5o0ZWA4PckJOK9SyYrzQgX1KMJT8g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=YbG9RRLkCk6otWsKZwSXJE+9gL+ko/oVQJMDfVxt/3IBSEcnREUhStiS3l0EdPzRU
	 y6bOG9o0gnu/Qrt6HQzHPZRSsneW0cbQh93KzY4FJ7yoPIZ/HXZzBVyGjqqpTWF06L
	 /soCOqDdo2/myvoxNbwuWv0TBEVbZufVVzcdfoVZ3zrHYqvc0byzF9TfcryGaQrrNl
	 MGv3a+BWle0pyL0gcLi3Yu4yB1SoO3w5wZHScGRIVVe9MXCyd2ueZBbgFhO7dTjDBy
	 w6FXLaU8epITIFPv9qt0/BpE86za/infUp4fdd90XltRi7DkmOA4TWm/r9KgAsFXCl
	 cwtdoa3BJGHFQ==
Message-ID: <e6f4c2e46d6089e4b76fe8a0e8b83557ddfd53de.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v4 0/5] Squash to "Add mptcp_subflow bpf_iter
 support"
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 06 Mar 2025 09:50:18 +0800
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

Hi Matt,

On Mon, 2025-02-24 at 11:37 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> v4:
>  - drop sock_owned_by_user_nocheck and spin_is_locked. According to
>    comments from Mat and Martin, in this set mptcp_subflow
>    bpf_iter only used from a cg sockopt bpf prog, no need to add
> these
>    check at this moment.
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

Thanks for applying this set. Please update this commit log too.

-Geliang

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

