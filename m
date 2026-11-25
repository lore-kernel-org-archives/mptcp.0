Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795570278;
	b=NJlDAeOgWzOYsTdGFqqaIGBTRCUu0Uz8k8pqiyhKYxR9vA5A2jI2Rx3ny3s0fqiq1bSW
	 75uF1OcLP2lINihrY1NRNqEirmX+dgzKGlsFVDHotKAS20xeLMB9RmAiymYvCswtrxnK/
	 VTy9aHQcXqT9FVVFTwRbr0f01FlJ5d3/1fiKTKLmjJr5/Ru2woXSHHkTLQ6RAxlLDc8Lo
	 FKcdKPxQnTI82Y+rGqM6ajWZ85c4Oq4GdErujf6ACc78DVwVb7UeqlEF/qarW1L64lgfE
	 3pusCz3O3Vo/WObAgPOGmTXA2Zy7E8k7zHAasQUQkfgTKkaioqeKCjyYzVtEENltMEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795570278;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=E7mdx/1Jy1AZ4AgE/fuZqOZQ4rNMNCYnAybwwuBcyIQ=;
	b=a8Rb7BGP0gCzooj2BzPeB9MP8569AbDe+I7Fw3vbLpWt41uNMPU7zus+72guUrm8crrW
	 ZyQTg8laGNN8bQTpFcXK40ehGXGmPT6ltOsrQwSwYwnMhExmnX4IP2oMhqCsixsUEopYx
	 FgridKZFX16ekMLpzAm+XWhpTR4BlsvX0Vm6oOheajyIt5QOvqD5w/PDUgppAKLhnSPOd
	 k3jDVqu7Ex2hr2bmGsxHoTClUkaoPnypPxNcIORVuI7sSIU58pdCB258tmctH3FCLZS6Y
	 gyuGS7GK7iEbKQlJ+XCsfkdu8cKQpYNCtakWHO0M8bmIoD8+o3rVVZk4Gf70MSEf79w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cafmkMBL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93A2606A31E
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 01:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cafmkMBL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC0D1F000C4;
	Wed, 25 Nov 2026 01:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795570277;
	bh=E7mdx/1Jy1AZ4AgE/fuZqOZQ4rNMNCYnAybwwuBcyIQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cafmkMBLrjuzggVFZBm445FcTRNS1qusaHn+WBCzjvo3UfVf4LamCc54l6MLvdwOu
	 mnrJ3BeqTSbqYx0uIJFkNDdDo+JdFGC7GHk155iShrK6laiq8dk6UkQ5CaaaGaWRjF
	 gjNvhOzKZEIxJE7cP2XSG0fakQO3iUbPWkxVI6l/S36EJ9Ybmw+KOjVDTpuUat+7fr
	 1Mqc7R7H8eDmZ2xReMrUW74KSSX7POGYO/xiyZBqo4rOQrx7/CkjrS4EzUQNJs6rZU
	 FgBQpg9ww/JLF+s6tJQZDyJMP8/ze6fxwaJ+9J0WgpT4Zyjulx0qQPmVFMOID0Djov
	 vvGbP3eT2QoPg==
Subject: Re: [PATCH mptcp-next v7 1/2] mptcp: sched: add subflow avoid flag
 for BPF schedulers
From: netdev-bot+sashiko@kernel.org
To: kalpan.jani@mpiricsoftware.com
Cc: mptcp@lists.linux.dev, shardul.b@mpiricsoftware.com, janak@mpiric.us,
 kalpanjani009@gmail.com, pabeni@redhat.com, kuba@kernel.org
Date: Wed, 25 Nov 2026 01:31:17 +0000
Message-ID: <179557027703.3133.4249741891623868683@kernel.org>
In-Reply-To: <20261123123730.3265284-2-kalpan.jani@mpiricsoftware.com>
References: <20261123123730.3265284-2-kalpan.jani@mpiricsoftware.com>
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

- [Medium] mptcp: sched: subflow avoid flag is unused by MPTCP core
- [Low] The commit message says "only mptcp_subflow_set_avoid() writes it
  ... so only a BPF scheduler can change its value".
- [Low] The new kfunc mptcp_subflow_set_avoid() (net/mptcp/sched.c)
  stores a BPF-supplied `bool avoid` with `WRITE_ONCE(subflow->avoid,…

--

mptcp: sched: add subflow avoid flag for BPF schedulers

This patch adds an "avoid" bool to struct mptcp_subflow_context. BPF
struct_ops schedulers set it through a new mptcp_subflow_set_avoid()
kfunc. The flag is also exported to userspace through MPTCP diag as
MPTCP_SUBFLOW_FLAG_AVOID.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/349

> Add a scheduler-owned "avoid" bool to mptcp_subflow_context:
>
>  - only mptcp_subflow_set_avoid() writes it. It is exposed to BPF
>    struct_ops schedulers as a kfunc with the same registration and
>    filter as mptcp_subflow_set_scheduled(), so only a BPF scheduler
>    can change its value;

[Severity: Low]
Is this description accurate? The new field is declared inside
struct_group(reset, ...) in struct mptcp_subflow_context. That means
mptcp_subflow_ctx_reset() also clears it:

net/mptcp/protocol.h:mptcp_subflow_ctx_reset() {
	memset(&subflow->reset, 0, sizeof(subflow->reset));
	...
}

The core reaches this from two places. One is
__mptcp_close_ssk()->__mptcp_subflow_disconnect(), which includes
msk->first being reset for reuse. The other is the error path of
mptcp_connect().

Resetting the flag together with the rest of the subflow context is
probably the intended behaviour. Could the commit message, or the field
comment, say that avoid is cleared on subflow context reset, so BPF
scheduler authors know the core can clear it?

[ ... ]

> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index 1e59072d478c9..0ce59eb093df6 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -165,6 +165,12 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
>  	WRITE_ONCE(subflow->scheduled, scheduled);
>  }
>
> +__bpf_kfunc void mptcp_subflow_set_avoid(struct mptcp_subflow_context *subflow,
> +					 bool avoid)
> +{
> +	WRITE_ONCE(subflow->avoid, avoid);

[Severity: Medium]
This version drops the avoid checks from mptcp_subflow_get_send() and
mptcp_subflow_get_retrans(). Does anything in the MPTCP core still read
subflow->avoid?

As far as I can see, the only reader left is subflow_get_info() in
diag.c. The only writer is mptcp_subflow_set_avoid(), and
bpf_mptcp_common_kfunc_filter() limits that kfunc to
bpf_mptcp_sched_ops struct_ops programs. So the field ends up as one
byte of per-subflow scratch storage owned by the BPF scheduler. The
core never acts on it in the send, retransmission, stale or
mptcp_subflow_active() paths.

The selftest in patch 2 shows the same thing. bpf_avoid_get_send()
sets the flag with mptcp_subflow_set_avoid() and then reads it back in
its own get_send callback to decide whether to call
mptcp_subflow_set_scheduled(). A BPF scheduler can already keep this
kind of per-subflow state in a BPF map without any kernel change.

This matters because the patch also adds MPTCP_SUBFLOW_FLAG_AVOID to
include/uapi/linux/mptcp.h. Once released, that bit is uAPI, but its
meaning depends entirely on whichever BPF scheduler is loaded. The
kernel itself attaches no semantics to it.

Earlier review of this series asked for a working scenario that the
scheduled bit cannot already cover, with the core actually making use
of the new state. Is a follow-up planned where the core honours avoid
in code that runs regardless of which scheduler is attached? If not,
would it be better to drop the field, the kfunc and the uAPI bit, and
keep this state inside the BPF scheduler?

[Severity: Low]
Can a BPF scheduler store a non-canonical bool here?

The verifier classifies a bool kfunc parameter as a plain ARG_SCALAR in
get_kfunc_arg_type(), and the ARG_SCALAR case applies no range check. A
struct_ops scheduler could therefore pass a value such as 2 in R2, using
raw BPF instructions or an extern declared with an int parameter. That
byte would then be written into the _Bool field unchanged.

Any user can later reach the read side through the MPTCP inet_diag dump:

net/mptcp/diag.c:subflow_get_info() {
	...
	if (READ_ONCE(sf->avoid))
		flags |= MPTCP_SUBFLOW_FLAG_AVOID;
	...
}

Loading a _Bool that holds a value other than 0 or 1 is undefined
behaviour. CONFIG_UBSAN_BOOL would report it, and depending on codegen
it could put unexpected bits into MPTCP_SUBFLOW_ATTR_FLAGS.

Would storing !!avoid here avoid this? mptcp_subflow_set_scheduled() has
the same pattern, but this patch adds a new instance and exposes the
value to userspace.

> +}
> +
>  int mptcp_sched_get_send(struct mptcp_sock *msk)
>  {
>  	struct mptcp_subflow_context *subflow;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123123730.3265284-1-kalpan.jani%40mpiricsoftware.com
