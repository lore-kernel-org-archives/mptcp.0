Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FDA38655D
	for <mptcp@lists.linux.dev>; Thu,  2 Jul 2026 06:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782973354; cv=none; b=Jn++IaE8a0ukyn+9Z/jIH7p4L8W7zxRGl9ZMllivGgrJmB0L6I6t7ttENI5AWJ/AEh7ewWF+muMdC81f5MN05ekWJb2+xHm0SQtwgfoaDURRgJ/FAUG2HBqTrj9aE/tbHs6W+cocjgX3VAg94qYYxjJwBGViZwswS7D/Qqf2os8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782973354; c=relaxed/simple;
	bh=JR5zBGZKHLWfny0DyyTLdAlT2nMFh2vbIvDg4luOCVE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dVWuidmryUHzCUOxWy6Pj8ahPzT4nsSO/meLlLyV518nBAtFGxLR/uxFlv4RG9AMpsCHI6KQt44A7DdLm/hJTorZdptFcNcJhVbAUUzxLrE5/2k7pU986YZVyssTmX2Dp6f2hDQsAUnKraPgSjSwJVXbmISoChmT9aETbsHpn1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqRA9BjV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqRA9BjV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98E31F000E9;
	Thu,  2 Jul 2026 06:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782973352;
	bh=QVfeQ3ovxE4LAxGpJm45RL571+xC5k83h2t2YlxClv4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cqRA9BjV6+MvArZS1inQ2n5Zum8teEujDh0oD2ymfKroFI/tR6cZ93Q3AGtqTTmU8
	 1Yp4GLvVLVHDnDBeIiZpCtoCJ5LS4j6jJdHCr/NBXij/cwQ5Nxj7bOdMSeaXSmWoqz
	 LS/sEFywEnOaDUiaAWmNUOQG+0vkKfeS6OHL/QVQotuAZ/NxWGnHzFr2HrdyPmFKks
	 Hffzcx4RgWEvtbgr8XxI0OC34p6JgjP+EM3gmiYJ6DH1bzzsjFntwbO5HLH9ndgxdL
	 FTycNWAZwz+UVwqx/nGhc7qJZXhvwLQ+/l47Al2nqacWNdkg71cjpyrEkQXtVQFWA6
	 lgf0V3gMkgtng==
Message-ID: <c3502e76a181c33156e76a5483ca19e6592d94d4.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 2/4] Squash to "bpf: Export mptcp packet
 scheduler helpers"
From: Geliang Tang <geliang@kernel.org>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>, mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
 kalpan.jani@mpiricsoftware.com, janak@mpiric.us, shardulsb08@gmail.com
Date: Thu, 02 Jul 2026 14:22:28 +0800
In-Reply-To: <20260629-mptcp_bpf_kfunc_fixes-v1-2-8cc875f36f53@mpiricsoftware.com>
References: 
	<20260629-mptcp_bpf_kfunc_fixes-v1-0-8cc875f36f53@mpiricsoftware.com>
	 <20260629-mptcp_bpf_kfunc_fixes-v1-2-8cc875f36f53@mpiricsoftware.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2026-06-29 at 17:37 +0530, Shardul Bankar wrote:
> mptcp_pm_subflow_chk_stale() is exposed to BPF MPTCP packet
> schedulers as
> a kfunc whose second argument is a generic "struct sock *ssk". The
> verifier only checks that the argument is a trusted struct sock; it
> cannot
> tell a subflow's TCP socket from any other socket. A scheduler
> get_retrans() program can therefore pass a non-subflow socket (e.g.
> (struct sock *)msk, or any other full socket), and
> mptcp_pm_subflow_chk_stale() reinterprets it via mptcp_subflow_ctx(),
> which is an unchecked cast of inet_csk(ssk)->icsk_ulp_data. On a
> non-subflow socket the derived subflow is bogus, and the function
> reads
> tcp_sk(ssk) state and writes through that bogus pointer
> (subflow->stale_rcv_tstamp, subflow->stale_count).
> 
> This kfunc legitimately operates on a subflow TCP socket, so the fix
> is a
> runtime role check rather than a narrower arg type: register a
> bpf_mptcp_pm_subflow_chk_stale() wrapper that validates ssk is a full
> MPTCP subflow TCP socket before calling the internal helper, like
> bpf_mptcp_subflow_ctx(). A scheduler passing a real subflow socket is
> unaffected; update the in-tree burst scheduler selftest accordingly.
> 
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
> ---
>  net/mptcp/bpf.c                                     | 10 +++++++++-
>  tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c |  4 ++--
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 9355fb53e89d5..30d3cbb23efb0 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -306,6 +306,14 @@ __bpf_kfunc static void
> bpf_mptcp_set_timeout(struct mptcp_sock *msk)
>  	mptcp_set_timeout((struct sock *)msk);
>  }
>  
> +__bpf_kfunc static void
> +bpf_mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct
> sock *ssk)
> +{
> +	if (ssk && sk_fullsock(ssk) && ssk->sk_type == SOCK_STREAM
> &&
> +	    ssk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(ssk))
> +		mptcp_pm_subflow_chk_stale(msk, ssk);

Sashiko suggested to verify that the subflow socket actually belongs to
the provided msk, I think it make sense.

> +}
> +
>  __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(bpf_mptcp_iter_kfunc_ids)
> @@ -327,7 +335,7 @@ BTF_ID_FLAGS(func, mptcp_subflow_active)
>  BTF_ID_FLAGS(func, bpf_mptcp_set_timeout)
>  BTF_ID_FLAGS(func, mptcp_wnd_end)
>  BTF_ID_FLAGS(func, bpf_sk_stream_memory_free)
> -BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_mptcp_pm_subflow_chk_stale, KF_SLEEPABLE)
>  BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
>  
>  static int bpf_mptcp_common_kfunc_filter(const struct bpf_prog
> *prog, u32 kfunc_id)
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
> b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
> index 1c4673d7c2338..408c65ed897b5 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c

Also, this part should be in another squash-to patch.

> @@ -25,7 +25,7 @@ extern bool mptcp_subflow_active(struct
> mptcp_subflow_context *subflow) __ksym;
>  extern void bpf_mptcp_set_timeout(struct mptcp_sock *msk) __ksym;
>  extern __u64 mptcp_wnd_end(const struct mptcp_sock *msk) __ksym;
>  extern bool bpf_sk_stream_memory_free(const struct
> mptcp_subflow_context *subflow) __ksym;
> -extern void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk,
> struct sock *ssk) __ksym;
> +extern void bpf_mptcp_pm_subflow_chk_stale(const struct mptcp_sock
> *msk, struct sock *ssk) __ksym;
>  
>  static __always_inline __u64 div_u64(__u64 dividend, __u32 divisor)
>  {
> @@ -140,7 +140,7 @@ int BPF_PROG(bpf_burst_get_retrans, struct
> mptcp_sock *msk)
>  
>  		/* still data outstanding at TCP level? skip this */
>  		if (!tcp_rtx_and_write_queues_empty(ssk)) {
> -			mptcp_pm_subflow_chk_stale(msk, ssk);
> +			bpf_mptcp_pm_subflow_chk_stale(msk, ssk);
>  			min_stale_count = min(min_stale_count,
> subflow->stale_count);
>  			continue;
>  		}
> 

