Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40FF11181
	for <mptcp@lists.linux.dev>; Fri,  7 Jul 2023 18:01:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA48C433C8;
	Fri,  7 Jul 2023 18:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688752884;
	bh=nFtqUnTuwDE6NQhCWNDEi0Rmu5sP2WJu9zBIZi65m9A=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ujCiN6tlrfwxpBG84xumEuFInDtXGnZoeJ5xPn1B0DOczevs27McVqYgWWin+5Wvl
	 jKcg89H8kk/C1nNSK3GvcT9zb6qB6YRkbZvh1B5GUCo/Yk4EnB3pJXGMWcobQvZ2rp
	 uT52/prFyN27DUM2I3+n7kXnbRKucnx+hVmf8ejRYhebkCskvORg+cMzlSDb7XSIjS
	 uOdwzS0zmpnUg7rbKnN6OzIx5bqP05+tZ5suWUzz7mt6xZIreUTFr1hD4VoUOxaMfM
	 17PU0PxVd9UyV8kg5wv8vjRtwMdbOc65/I86Up26wP28vBr2T8BVjiQHKka9aXDAyT
	 mhSH8PVFwTSfw==
Date: Fri, 7 Jul 2023 11:01:23 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@suse.com>, Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 08/10] bpf: Export more bpf_burst related
 functions
In-Reply-To: <b123ce780d733db77d0821d4e9d7560f7439ded5.1687829823.git.geliang.tang@suse.com>
Message-ID: <8c1888af-2bc2-f1ab-32b0-14b6c6f72c6a@kernel.org>
References: <cover.1687829823.git.geliang.tang@suse.com> <b123ce780d733db77d0821d4e9d7560f7439ded5.1687829823.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 27 Jun 2023, Geliang Tang wrote:

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
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index c580add9c7f1..a1c85605ed39 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -171,10 +171,26 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
> 	.name		= "mptcp_sched_ops",
> };
>
> +bool bpf_sk_stream_memory_free(const struct sock *sk)
> +{
> +	return sk_stream_memory_free(sk);
> +}
> +
> +bool bpf_tcp_rtx_and_write_queues_empty(const struct sock *sk)
> +{
> +	return tcp_rtx_and_write_queues_empty(sk);
> +}

I'm not sure the internals of TCP should be made part of the "public API" 
like this (any opinion here, Paolo?). Maybe they could be renamed 
something related to the job they are doing for MPTCP, so there's more 
flexibility to change their implementation and other BPF code doesn't 
start depending on these for generic TCP usage.

Suggest bpf_mptcp_subflow_memory_free() and 
bpf_mptcp_subflow_queues_empty()?

- Mat

> +
> BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
> BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
> BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
> BTF_ID_FLAGS(func, mptcp_subflow_ctx_by_pos)
> +BTF_ID_FLAGS(func, mptcp_subflow_active)
> +BTF_ID_FLAGS(func, mptcp_set_timeout)
> +BTF_ID_FLAGS(func, mptcp_wnd_end)
> +BTF_ID_FLAGS(func, bpf_sk_stream_memory_free)
> +BTF_ID_FLAGS(func, bpf_tcp_rtx_and_write_queues_empty)
> +BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale)
> BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
>
> static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 5f9f046b2124..84a82967b009 100644
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
> @@ -497,7 +497,7 @@ static long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subfl
> 	       inet_csk(ssk)->icsk_timeout - jiffies : 0;
> }
>
> -static void mptcp_set_timeout(struct sock *sk)
> +void mptcp_set_timeout(struct sock *sk)
> {
> 	struct mptcp_subflow_context *subflow;
> 	long tout = 0;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index bb4d50c8c398..58a634fc2fcc 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -636,6 +636,10 @@ void __mptcp_subflow_send_ack(struct sock *ssk);
> void mptcp_subflow_reset(struct sock *ssk);
> void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
> void mptcp_sock_graft(struct sock *sk, struct socket *parent);
> +u64 mptcp_wnd_end(const struct mptcp_sock *msk);
> +void mptcp_set_timeout(struct sock *sk);
> +bool bpf_sk_stream_memory_free(const struct sock *sk);
> +bool bpf_tcp_rtx_and_write_queues_empty(const struct sock *sk);
> struct socket *__mptcp_nmpc_socket(struct mptcp_sock *msk);
> bool __mptcp_close(struct sock *sk, long timeout);
> void mptcp_cancel_work(struct sock *sk);
> -- 
> 2.35.3
>
>
>
