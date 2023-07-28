Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFA77C
	for <mptcp@lists.linux.dev>; Fri, 28 Jul 2023 01:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553E7C433C7;
	Fri, 28 Jul 2023 01:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690508023;
	bh=9QXdCz0APHGS1q0RtIIQFTUgqsxcEN7MhGJJu4laNBM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=IwGVFcOkuqeGwC/pp3pxlmRoMdyQsoF/3gg1CzkhL7cW//HFxihRSodRoI/iSyv2Y
	 pn9KSm3K5T4SMAMCpWBFpGXSmjx5F+uCWGtWNUPpDinIja4XbtCx7AvQF/ze3z7jKI
	 Y9NErDOZpXe0r3BdbeaDV/aJH7/GGqZao4yxrgpLRLYvRl+faFMcMLx/7G1ss88m9+
	 FKJpVm0oqZ4FofyOUuj9lvVWDVy6K8VYlNV7wKlKIOjxuQMK/t7qwvFY+rLEILtbdb
	 0bPD+uUuJhJSN+MnvkyysAnxrQynW3uYmj09BVfRWCIxoanIEm/KEXQN/vx/fcsvQf
	 kMjfcycSELFjQ==
Date: Thu, 27 Jul 2023 18:33:42 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 11/13] bpf: Export more bpf_burst related
 functions
In-Reply-To: <cb16ad49ee7b95ef6c744af0cba5b0aba5718107.1689650435.git.geliang.tang@suse.com>
Message-ID: <c811701a-1cc1-85c5-2dbb-5a7a149b604b@kernel.org>
References: <cover.1689650435.git.geliang.tang@suse.com> <cb16ad49ee7b95ef6c744af0cba5b0aba5718107.1689650435.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 18 Jul 2023, Geliang Tang wrote:

> sk_stream_memory_free() and tcp_rtx_and_write_queues_empty() are needed
> to export into the BPF context for bpf_burst scheduler. But these two
> functions are inline ones. So this patch added two wrappers for them,
> and export the wrappers in the BPF context.
>
> Add more bpf_burst related functions into bpf_mptcp_sched_kfunc_set to make
> sure these helpers can be accessed from the BPF context.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/bpf.c      | 16 ++++++++++++++++
> net/mptcp/protocol.c |  4 ++--
> net/mptcp/protocol.h |  4 ++++
> 3 files changed, 22 insertions(+), 2 deletions(-)
>

Patches 11-13 look good to add to the "features other trees" section of 
the export branch for further testing:

Reviewed-by: Mat Martineau <martineau@kernel.org>


> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index e6f94d5e22fb..12b747813dee 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -144,11 +144,27 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
> 	.name		= "mptcp_sched_ops",
> };
>
> +bool bpf_mptcp_subflow_memory_free(const struct sock *sk)
> +{
> +	return sk_stream_memory_free(sk);
> +}
> +
> +bool bpf_mptcp_subflow_queues_empty(const struct sock *sk)
> +{
> +	return tcp_rtx_and_write_queues_empty(sk);
> +}
> +
> BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
> BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
> BTF_ID_FLAGS(func, mptcp_subflow_set_stale)
> BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
> BTF_ID_FLAGS(func, mptcp_subflow_ctx_by_pos)
> +BTF_ID_FLAGS(func, mptcp_subflow_active)
> +BTF_ID_FLAGS(func, mptcp_set_timeout)
> +BTF_ID_FLAGS(func, mptcp_wnd_end)
> +BTF_ID_FLAGS(func, bpf_mptcp_subflow_memory_free)
> +BTF_ID_FLAGS(func, bpf_mptcp_subflow_queues_empty)
> +BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale)
> BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
>
> static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 9f00a0288a0a..b4218108f17f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -50,7 +50,7 @@ DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
> static struct net_device mptcp_napi_dev;
>
> /* Returns end sequence number of the receiver's advertised window */
> -static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
> +u64 mptcp_wnd_end(const struct mptcp_sock *msk)
> {
> 	return READ_ONCE(msk->wnd_end);
> }
> @@ -494,7 +494,7 @@ static long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subfl
> 	       inet_csk(ssk)->icsk_timeout - jiffies : 0;
> }
>
> -static void mptcp_set_timeout(struct sock *sk)
> +void mptcp_set_timeout(struct sock *sk)
> {
> 	struct mptcp_subflow_context *subflow;
> 	long tout = 0;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 78b3beeb7d7a..cabda60f5f76 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -635,6 +635,10 @@ void __mptcp_subflow_send_ack(struct sock *ssk);
> void mptcp_subflow_reset(struct sock *ssk);
> void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
> void mptcp_sock_graft(struct sock *sk, struct socket *parent);
> +u64 mptcp_wnd_end(const struct mptcp_sock *msk);
> +void mptcp_set_timeout(struct sock *sk);
> +bool bpf_mptcp_subflow_memory_free(const struct sock *sk);
> +bool bpf_mptcp_subflow_queues_empty(const struct sock *sk);
> struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
> bool __mptcp_close(struct sock *sk, long timeout);
> void mptcp_cancel_work(struct sock *sk);
> -- 
> 2.35.3
>
>
>
