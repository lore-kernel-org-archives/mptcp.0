Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175B0385D7D
	for <mptcp@lists.linux.dev>; Thu,  2 Jul 2026 06:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782973327; cv=none; b=SKhgRc2UTsUoYNlVytzOuhkaz4lHTjMXR5JWcs+u7ZW7zwtkdijUruoRetdD4E8fSYtuodKqtUUYlVFQ5opXR63wvlvcLLVsuz3+0H75fTq/djCaRfiPv0FwpJvh2TPH1ReKAk7iN3QVc4I80vyMJ3l7OtK46Le/bMPTJX+GGFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782973327; c=relaxed/simple;
	bh=Tr07Q24DPpM/igK6Dd6KMrh3sfANJLr1qkvh5WDGQ14=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IG1SLWinNFQfCDE+fbgWBUJ8B2FNjIP79ERjindPX62DUxrDYpLTMEg3Vy003uOclAuF/Xpo81Z2jG8n4dO03iY4sTH1Yhr+NWEqQyeEWiXk5ba6JwfseTavABncHW1JlQOgXin8Rsqwiu5RRdN45zAX3m7LM0hlxItpYy9NKWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8Agzjzn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8Agzjzn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B511F000E9;
	Thu,  2 Jul 2026 06:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782973325;
	bh=KEC2lPZFMVLZtx4NGLYllDu2ZhqeiCkFwtMQ/vDeAEE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X8Agzjzn+EWeIA1itm7z1mePY7vFKKTH7kEw5vWaMZxesy1xGigUtAOms3Uy1zidV
	 nvZameESndvf9bd12bRbZiJk/FG+zBERbfcI6SWOg76ng2yMNGlieMFpfLMhoG32UQ
	 RBzOPGauMzj1va5vp75yojmPm7V6cgue9oIWzie7wfM2ds0xxBwWNoeOFMLf8cy9R3
	 uHZTX5xCigI9moX8x0cNG+pLsJU1unKsQ3Mw3qJqr2J+5pzoYTtKmH/djgiokLnYd4
	 Y4dJliitp0S594Auo9DV6tmwwscT1epjZk0W6WHhbre4aKXkFweEuHNgaFTQapr3ke
	 o1T7oH8hXsZUA==
Message-ID: <f18cc4c65df99b921fecd03d0a6e1b852300c209.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 1/4] Squash to "bpf: Export mptcp packet
 scheduler helpers"
From: Geliang Tang <geliang@kernel.org>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>, mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
 kalpan.jani@mpiricsoftware.com, janak@mpiric.us, shardulsb08@gmail.com
Date: Thu, 02 Jul 2026 14:22:00 +0800
In-Reply-To: <20260629-mptcp_bpf_kfunc_fixes-v1-1-8cc875f36f53@mpiricsoftware.com>
References: 
	<20260629-mptcp_bpf_kfunc_fixes-v1-0-8cc875f36f53@mpiricsoftware.com>
	 <20260629-mptcp_bpf_kfunc_fixes-v1-1-8cc875f36f53@mpiricsoftware.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shardul,

Thanks for this fix.

On Mon, 2026-06-29 at 17:37 +0530, Shardul Bankar wrote:
> mptcp_set_timeout() is exposed to BPF MPTCP packet schedulers as a
> kfunc
> taking a generic "struct sock *". The verifier only checks that the
> argument is a trusted struct sock; it cannot distinguish an MPTCP-
> level
> socket (msk) from a subflow's TCP socket. A scheduler get_send()
> program
> can therefore pass a subflow socket (e.g. msk->first, or the result
> of
> bpf_mptcp_subflow_tcp_sock()), which mptcp_set_timeout() upcasts via
> mptcp_sk() and iterates as msk->conn_list. On a subflow socket those
> bytes are live TCP state, so the walk yields a wild
> mptcp_subflow_context
> and the subsequent subflow->tcp_sock dereference faults (GPF / KASAN
> user-memory-access).
> 
> Narrow the kfunc-facing type: register a bpf_mptcp_set_timeout()
> wrapper
> taking "struct mptcp_sock *" instead of the raw mptcp_set_timeout()
> symbol, so the verifier's BTF-id check rejects a non-msk socket at
> program load time. A scheduler that passes its msk is unaffected;
> update
> the in-tree burst scheduler selftest accordingly.
> 
> Found by an MPTCP protocol-flow harness extending BRF
> (arXiv:2305.08782).
> 
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
> ---
>  net/mptcp/bpf.c                                     | 7 ++++++-
>  tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 4 ++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 0845061ddc65c..9355fb53e89d5 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -301,6 +301,11 @@ bpf_sk_stream_memory_free(const struct
> mptcp_subflow_context *subflow)
>  	return false;
>  }
>  
> +__bpf_kfunc static void bpf_mptcp_set_timeout(struct mptcp_sock
> *msk)
> +{
> +	mptcp_set_timeout((struct sock *)msk);
> +}
> +
>  __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(bpf_mptcp_iter_kfunc_ids)
> @@ -319,7 +324,7 @@ BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx,
> KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock, KF_RET_NULL)
>  BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
>  BTF_ID_FLAGS(func, mptcp_subflow_active)
> -BTF_ID_FLAGS(func, mptcp_set_timeout)
> +BTF_ID_FLAGS(func, bpf_mptcp_set_timeout)
>  BTF_ID_FLAGS(func, mptcp_wnd_end)
>  BTF_ID_FLAGS(func, bpf_sk_stream_memory_free)
>  BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale, KF_SLEEPABLE)
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
> b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
> index 8ff529d38a595..1c4673d7c2338 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c

This part should be in another squash-to patch for the commit
"selftests/bpf: Add bpf_burst scheduler & test", right?

> @@ -22,7 +22,7 @@ struct bpf_subflow_send_info {
>  #define RB_EMPTY_ROOT(root)  (READ_ONCE((root)->rb_node) == NULL)
>  
>  extern bool mptcp_subflow_active(struct mptcp_subflow_context
> *subflow) __ksym;
> -extern void mptcp_set_timeout(struct sock *sk) __ksym;
> +extern void bpf_mptcp_set_timeout(struct mptcp_sock *msk) __ksym;
>  extern __u64 mptcp_wnd_end(const struct mptcp_sock *msk) __ksym;
>  extern bool bpf_sk_stream_memory_free(const struct
> mptcp_subflow_context *subflow) __ksym;
>  extern void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk,
> struct sock *ssk) __ksym;
> @@ -99,7 +99,7 @@ int BPF_PROG(bpf_burst_get_send, struct mptcp_sock
> *msk)
>  			send_info[backup].linger_time = linger_time;
>  		}
>  	}
> -	mptcp_set_timeout(sk);
> +	bpf_mptcp_set_timeout(msk);
>  
>  	/* pick the best backup if no other subflow is active */
>  	if (!nr_active)
> 

