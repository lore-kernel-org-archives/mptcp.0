Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795570279;
	b=JPQSv8x3VT620jupsSWUajH8a5v0QlQ4dPyYjR1X2i9fYa43Vsgv8lTkVxR6B9dMFSta
	 mUki4w+o4Fjmdr3vlIqKnlE/i+O5Le1zkEg/tzbnYZ7L5SJmaFs4Z+nR2eNSprKLB79nt
	 HdQfWidOAWeKksloxmuRVGNnjOVch4tYUC6QNeb1KCf9qRwqz5lTKMXxaUUYgMCAUY5Hg
	 55Xxnz55sgeLNB8PTyh5YtbCxYFAIPQ63LaE3zgKUgkqb3kFNGKfc8/ALGJ/Ldpu9yj7x
	 J/qEho8PRfprTAsSa9fP/VKdO5mrvqjRpKMF+uHpiVNdKCHRPo/GsZQA0ks52adrnRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795570279;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=3B5KM3Fb5XXbJiUHIqya6nhcBepOCl0IH3pADwmgzrE=;
	b=msccbV3r0yNmTGt9m5blGtl0Xxq2gkvJdm8D+SftET8fiMVvvy3U+B3Vridex8472G8p
	 sK2XS57J6mL8JpMHmSSz0xeGbPaUhb6sXOPiGk7dGHB2JRIfs3OQ0idWhD4AskylTY33h
	 S866R4iho6jQwSOsObtoy+zt+DYf+FwFTdLHpK2svtYSIK0Um2tm4i8CQeY37oQXeEmvX
	 h5kmz8fdvnAoJhMgG8kUEeDU2QDlro5rwhN9+UuC+AH5d6K7aswosbD3A3ZkSW5eyxuci
	 nek98/Ts2icC7s1AURpOovaKHhZ2ro9jdE+TC0zwYX//emDdi/hfCY9CaZsnLQCbIzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bwD3MJwm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD19C606A31E
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 01:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bwD3MJwm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11131F000C4;
	Wed, 25 Nov 2026 01:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795570279;
	bh=3B5KM3Fb5XXbJiUHIqya6nhcBepOCl0IH3pADwmgzrE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bwD3MJwmK+Ten9sZL+WXKjCFqkholWR14Tg4Z+Kwbwx/sBOtW/LbeDxMpbjpHTZnT
	 InaXD96td4AHyO0Nkir9WsVjZurp2anhgzFP1Opd9Jq1mMYPwe7cboFXskxUp/WKCL
	 +cBPZt7/cnARvxDNqwMaEb8jszu9gMjeLLC97VvB1Yn7FDMPygXBcPkYr0LSqC6Tt9
	 g+KnAPL+AJ/EhIgU97x/4imN65Ri+QyzQXazeZ60ZzNVc8T5lx6wOPW0PGjtC3gKUi
	 o3DZrgg+XDWLK3bIhljIxEa9s4/hMd3UK5IsKV/JIYgn5lupC6MQiZlCE+hARQHHeT
	 qbDS+wSjU8WfQ==
Subject: Re: [PATCH mptcp-next v7 2/2] selftests: mptcp: bpf: exercise the
 subflow avoid flag across rounds
From: netdev-bot+sashiko@kernel.org
To: kalpan.jani@mpiricsoftware.com
Cc: mptcp@lists.linux.dev, shardul.b@mpiricsoftware.com, janak@mpiric.us,
 kalpanjani009@gmail.com, pabeni@redhat.com, kuba@kernel.org
Date: Wed, 25 Nov 2026 01:31:18 +0000
Message-ID: <179557027850.3133.2018668236611241328@kernel.org>
In-Reply-To: <20261123123730.3265284-3-kalpan.jani@mpiricsoftware.com>
References: <20261123123730.3265284-3-kalpan.jani@mpiricsoftware.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c,
  bpf_avoid_get_send() always returns 0, including when it scheduled no…
- [Low] bpf_avoid_get_send() in
  tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c treats `avoid` as…
- [Low] The commit message misdescribes the extern declarations.

--

selftests: mptcp: bpf: exercise the subflow avoid flag across rounds

This adds a BPF struct_ops MPTCP scheduler selftest. The scheduler calls
mptcp_subflow_set_avoid() once, on the second subflow, and in later rounds
relies on reading the avoid flag back. Per-msk state lives in SK_STORAGE,
and the harness checks that the avoided path carried no data.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/349

> Add a BPF struct_ops scheduler selftest for mptcp_subflow_set_avoid(),
> and add the required extern declarations for it and for
> mptcp_subflow_active(), both declared locally in this file rather
> than in the shared mptcp_bpf.h. mptcp_subflow_active()'s extern was
> missing here even though the other BPF scheduler progs already have
> it (see mptcp_bpf_burst.c).

[Severity: Low]
Is this description accurate? mptcp_bpf_avoid.c is a new file, so the
extern can't have been missing from it before.

Among the existing scheduler progs, only mptcp_bpf_burst.c declares
mptcp_subflow_active(). mptcp_bpf_rr.c, mptcp_bpf_red.c, mptcp_bpf_first.c
and mptcp_bpf_bkup.c don't declare it, and mptcp_bpf.h doesn't either.

The message also doesn't say why both externs stay local. The extern for
the sibling kfunc mptcp_subflow_set_scheduled() is in mptcp_bpf.h. The
preceding patch, "mptcp: sched: add subflow avoid flag for BPF
schedulers", registers mptcp_subflow_set_avoid() in the same kfunc set in
net/mptcp/bpf.c.

Could this wording be left over from an earlier revision?

> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c
> new file mode 100644
> index 0000000000000..8276ceb0e5397
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c
> @@ -0,0 +1,87 @@

[ ... ]

> +SEC("struct_ops")
> +int BPF_PROG(bpf_avoid_get_send, struct mptcp_sock *msk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct mptcp_subflow_context *first = NULL;
> +	struct mptcp_avoid_storage *ptr;
> +
> +	ptr = bpf_sk_storage_get(&mptcp_avoid_map, msk, 0,
> +				 BPF_LOCAL_STORAGE_GET_F_CREATE);
> +	if (!ptr)
> +		return -1;
> +

[ ... ]

> +	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
> +		if (!first) {
> +			first = subflow;
> +			continue;
> +		}
> +
> +		if (!ptr->avoid_marked) {
> +			mptcp_subflow_set_avoid(subflow, true);
> +			ptr->avoid_marked = true;
> +			continue;
> +		}
> +
> +		if (subflow->avoid)
> +			continue;

[Severity: Low]
Should avoid be a hard exclusion here? struct mptcp_subflow_context
documents the field as:

	bool	avoid;		    /* pkt scheduler: skip subflow if possible */

Once avoid_marked is set, this loop always skips the avoided subflow. The
fallback after the loop only schedules first, and only when first is
active and not avoided.

That leaves nothing scheduled in at least two cases:

  - The head subflow goes stale. mptcp_pm_subflow_chk_stale() only marks
    it stale when another active subflow exists, and here that is the
    avoided one.

  - The head subflow is closed or reset. The avoided subflow then becomes
    first and is rejected by !first->avoid.

No get_retrans op is set, so retransmissions also go through get_send and
stall the same way. On the __mptcp_push_pending() path, nothing is sent on
any retry.

Could the scheduler fall back to the avoided subflow when no other
subflow is usable?

> +
> +		if (mptcp_subflow_active(subflow)) {
> +			mptcp_subflow_set_scheduled(subflow, true);
> +			return 0;
> +		}
> +	}
> +
> +	if (first && mptcp_subflow_active(first) && !first->avoid)
> +		mptcp_subflow_set_scheduled(first, true);
> +
> +	return 0;

[Severity: Medium]
Can this return 0 even when no subflow was scheduled? The core reads a 0
return from get_send as "a subflow has been scheduled".

The in-tree implementations return an error when they find nothing.
mptcp_sched_default_get_send() returns -EINVAL, and the get_send ops in
mptcp_bpf_first.c and mptcp_bpf_burst.c return -1.

In __mptcp_subflow_push_pending(), the scheduler exit is only taken on a
nonzero return:

net/mptcp/protocol.c:__mptcp_subflow_push_pending() {
    ...
	while (mptcp_send_head(sk) && keep_pushing) {
		...
		if (mptcp_sched_get_send(msk))
			goto out;

		if (READ_ONCE(subflow->scheduled)) {
			...
		}

		mptcp_for_each_subflow(msk, subflow) {
			if (READ_ONCE(subflow->scheduled)) {
				...
					keep_pushing = false;
		...
	}
    ...
}

If the return is 0 and nothing is scheduled, keep_pushing stays true. The
BPF prog then sees the same state on every iteration.

Doesn't this loop then spin forever in softirq with the msk data lock
held?

One way to get there, starting from the stale case above:

mptcp_pm_subflow_chk_stale()
    subflow->stale = 1;   /* head subflow; the avoided one is active */
    __mptcp_retransmit_pending_data(sk);

and then a DATA_ACK arrives on the avoided subflow:

ack_update_msk()
    __mptcp_check_push()
        __mptcp_subflow_push_pending()
            mptcp_sched_get_send()
                bpf_avoid_get_send()   /* returns 0, nothing scheduled */

Closing or resetting the initial subflow leads to the same state.
mptcp_subflow_process_delegated() is another entry into this loop.

The core's missing guard here is pre-existing, and mptcp_bpf_bkup.c uses
the same return 0 pattern. Because this scheduler excludes a subflow on
purpose, the empty case is more likely here.

Would returning -1 when nothing was scheduled avoid this? The function
already does that for the !ptr case.

> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123123730.3265284-1-kalpan.jani%40mpiricsoftware.com
