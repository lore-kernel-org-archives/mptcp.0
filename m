Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795651940;
	b=5mpgT8g3nRWdlP8mNP0cXc6BssGx+aA/lTNKScyK+865yHjzf0Cfdz8FEtcXBL7UQQde
	 0nmkaZEKMS0Le0pXSkUBOrIdvtqyp7ci0GKRSmz+mvfWt9H77foSgEyiCx+No3sHSzFJb
	 KDxKq7B0DaPPezpc9to2jkFzvbdYCpir1lVw3vKaLajjIyEgR4/o2mSIrIAjrWjV8KWIb
	 1r0BVQt/WYssYA/CAkbaX7FABG6CBymkkBsJVAfrxK2SNE1igOg6M/dY+0nOInV22Xmka
	 tLzVrf4fkExukKK83ub9nrrKB00U/w/hiO46e09e/cy5kmPNeC/YQbTwFDGWSsKLp5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795651940;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wA3ojGu7jrn1/zeAQuyNeZrpCDVpFmMbE6qv/6ZVfP0=;
	b=wOj4H3kAdHo6r7c7qHFp5si55cmL9GdpJtvO5flXn+SU+H/FY+gL1SqoAEokCPGtLv+T
	 hvJgCDhtAc3EWYNkNbNvTxo2PIo+ab88psPOFamCpzVTEyrcZJLlG1tCAEzDoGo2dM1XA
	 K8VyekgzlSZ8QlM24Xv5V70zg/iddE1kq+2tkIQOB7a4cV9xUYmd7RJSFPmi4UvEyPxuN
	 C0ijW5m3RDRNsW3ikZCfAMjnKRsALH0DylJPNXNaosY9VkYvrVT/tSPCQ4xS0jhhH47N+
	 2Vr6MyzjsZIEo1CnTS34HBniGfnyeOARh1rTXuJczLjjcem9VZlTmQt9+zekJEmv+Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D5HSj2pH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C783606A31E
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 00:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D5HSj2pH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660D01F000CF;
	Thu, 26 Nov 2026 00:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795651939;
	bh=wA3ojGu7jrn1/zeAQuyNeZrpCDVpFmMbE6qv/6ZVfP0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D5HSj2pHYkSM6hZc6CRl+wtcZvxiQQvV0m6sUwdPr1aZbQT3yj29hccAo4tH6Q/1m
	 ft1gxTPKwJT6pRDFNpC6ZC90CVNe3O3E8hp8yZilgc6jN9klaxiDz8QW35K6xOJdh0
	 itKTXfXio9Gf8cgScZ5TeeViY5llRbbpswRZr+zxwiQDWwZNYroTkmGYFrTJ2HSkDk
	 bAbU3UkQteMf5RkPSNfnrPNQ3Y3ARWtrDdGgzdlHAdMlG7EBRnO6zYUldvtTQmNKKc
	 tWtRglR4ClwdlJCsD5Tzo0WjeQY37lR1QNT4cQ1T5g3/5x2rHAoSTyIzYCs4lFX8+E
	 9NdDix+8xcMTg==
Subject: Re: [PATCH mptcp-next v8 2/2] selftests: mptcp: bpf: exercise the
 subflow avoid flag across rounds
From: netdev-bot+sashiko@kernel.org
To: kalpan.jani@mpiricsoftware.com
Cc: mptcp@lists.linux.dev, shardul.b@mpiricsoftware.com, janak@mpiric.us,
 kalpanjani009@gmail.com, pabeni@redhat.com, kuba@kernel.org
Date: Thu, 26 Nov 2026 00:12:19 +0000
Message-ID: <179565193900.3133.17683264299454421291@kernel.org>
In-Reply-To: <20261124102214.3930527-3-kalpan.jani@mpiricsoftware.com>
References: <20261124102214.3930527-3-kalpan.jani@mpiricsoftware.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The kfunc mptcp_subflow_set_avoid() in net/mptcp/sched.c was
  added by the earlier commit "mptcp: sched: add subflow avoid flag for…
- [Low] The commit message says the test "exercises the MPTCP core
  enforcement" and lists two branches: both kinds scheduled (drop the…
- [Low] The 'avoid' subtest's only check is test_bpf_sched(...,
  WITH_DATA, WITHOUT_DATA).

--

selftests: mptcp: bpf: exercise the subflow avoid flag across rounds

This adds a BPF struct_ops MPTCP scheduler selftest. It marks the second
subflow as avoided with mptcp_subflow_set_avoid(), then schedules both the
avoided and the non-avoided subflows, so the MPTCP core has to filter out
the avoided one. Per-msk state is kept in a BPF_MAP_TYPE_SK_STORAGE map,
and the new "avoid" subtest expects data only on ADDR_1.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/349

> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index d77c9f8c53c75..3bff30d0d5300 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c

[ ... ]

> @@ -820,6 +821,18 @@ static void test_burst(void)
>  	mptcp_bpf_burst__destroy(skel);
>  }
>  
> +static void test_avoid(void)
> +{
> +	struct mptcp_bpf_avoid *skel;
> +
> +	skel = mptcp_bpf_avoid__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load: avoid"))
> +		return;
> +
> +	test_bpf_sched(skel->maps.avoid, "avoid", WITH_DATA, WITHOUT_DATA);

[Severity: Low]
Can this check tell the avoid filtering apart from a scheduler that never
touches the second subflow? WITH_DATA on ADDR_1 and WITHOUT_DATA on ADDR_2
is the same expectation that test_first() uses.

Nothing records whether the second subflow joined, was marked avoided, or
was scheduled. Nothing shows that mptcp_sched_get_subflow_state() took
this branch either:

net/mptcp/sched.c:mptcp_sched_get_subflow_state() {
    ...
	if (eligible && avoided) {
		mptcp_for_each_subflow(msk, subflow) {
			if (READ_ONCE(subflow->scheduled) &&
			    READ_ONCE(subflow->avoid))
				mptcp_subflow_set_scheduled(subflow, false);
		}
	}
    ...
}

If the second subflow never joins or never becomes active,
bpf_avoid_get_send() never calls mptcp_subflow_set_avoid() or schedules
it, and the test still passes.

The test also can't tell "retain the eligible one" apart from a core
that drops the whole selection and falls back to mptcp_subflow_get_send().
That function prefers send_info[SSK_MODE_ACTIVE][0] over
send_info[SSK_MODE_ACTIVE][1], so it would also pick ADDR_1.

Would it make sense to expose a counter or global from bpf_avoid_get_send()
that userspace can assert on? Another option is to check the
MPTCP_SUBFLOW_FLAG_AVOID flag that net/mptcp/diag.c already reports.

> +	mptcp_bpf_avoid__destroy(skel);
> +}

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c
> new file mode 100644
> index 0000000000000..4152f9d04a0df
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c

[ ... ]

> +	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
> +		if (!first) {
> +			first = subflow;
> +			continue;
> +		}
> +
> +		if (!ptr->avoid_marked) {
> +			mptcp_subflow_set_avoid(subflow, true);

[Severity: High]
This test only ever passes true here. That hides a problem in the kfunc
it exercises, which was added by the earlier "mptcp: sched: add subflow
avoid flag for BPF schedulers" patch:

net/mptcp/sched.c:
__bpf_kfunc void mptcp_subflow_set_avoid(struct mptcp_subflow_context *subflow,
					 bool avoid)
{
	WRITE_ONCE(subflow->avoid, avoid);
}

The verifier handles scalar kfunc arguments as ARG_SCALAR and does not
check the range of bool. libbpf also treats all BTF integer types as
compatible.

So a struct_ops program can declare this extern with an int second
argument and pass something like 42. On x86-64, the raw low byte then
ends up in subflow->avoid.

The core then uses that byte directly as an index into on-stack arrays:

net/mptcp/protocol.c:mptcp_subflow_get_send() {
    ...
		bool avoid = READ_ONCE(subflow->avoid);
    ...
		if (linger_time < send_info[mode][avoid].linger_time) {
			send_info[mode][avoid].ssk = ssk;
			send_info[mode][avoid].linger_time = linger_time;
    ...
}

mptcp_subflow_get_retrans() does the same:

		if (subflow->backup || subflow->request_bkup) {
			if (!backup[avoid])
				backup[avoid] = ssk;
			continue;
		}

		if (!pick[avoid])
			pick[avoid] = ssk;

With a value of 2..255, can this write a socket pointer and linger_time
past the end of send_info[SSK_MODE_MAX][2], or past pick[2] and backup[2]?
The bad value stays in the subflow context. Every later send or
retransmit pass would repeat the out-of-bounds access.

Should mptcp_subflow_set_avoid() normalize the value, for example with
WRITE_ONCE(subflow->avoid, !!avoid)?

> +			ptr->avoid_marked = true;
> +		}
> +
> +		if (mptcp_subflow_active(subflow)) {
> +			mptcp_subflow_set_scheduled(subflow, true);
> +			scheduled = true;
> +		}
> +	}
> +
> +	if (first && mptcp_subflow_active(first)) {
> +		mptcp_subflow_set_scheduled(first, true);
> +		scheduled = true;
> +	}

[Severity: Low]
The commit message says:

    This exercises the MPTCP core enforcement: when both kinds are
    scheduled, the core must discard the avoided selection and retain
    the eligible one. When only avoided subflows are selected, the
    core falls back to its default selector.

Is the second part actually covered by this test? This block schedules
the first subflow whenever it is active. So whenever the avoided subflow
is scheduled, a non-avoided one is scheduled too, and
mptcp_sched_get_subflow_state() returns MPTCP_SCHED_SUBFLOW_ELIGIBLE.

Reaching the MPTCP_SCHED_SUBFLOW_AVOIDED_ONLY fallback in
mptcp_sched_get_send() would need the first subflow to be inactive while
the second one is active. Nothing in the test sets that up.

If that fallback were reached, mptcp_sched_default_get_send() would
correctly fall back to send_info[SSK_MODE_ACTIVE][1], which is the avoided
ADDR_2 subflow. Wouldn't test_avoid() then fail because of its
WITHOUT_DATA expectation on ADDR_2?

Could the commit message be reworded to say that only the "both kinds
scheduled" path is exercised?

> +
> +	return scheduled ? 0 : -1;
> +}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124102214.3930527-1-kalpan.jani%40mpiricsoftware.com
