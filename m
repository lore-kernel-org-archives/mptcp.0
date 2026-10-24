Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792859175;
	b=JfOSWdlBzT8ZDDP7ln188w8n5Z8rZZRrZ5V1Eg802ja/gYP8OqsBnztcg0qWlWfh5WoL
	 GYaBwmB5+RHidqlxB+18rADxzQGeLTIfgNbV0UD0wLsPkjiGk9kg/CO2/QK+0DmQoLEp9
	 pghbAQn4CBtHT2JlGQZPO0wfDfLZX7Hnff6u6ETgBR215krwwRRfGLnLhorUG7NYix0Gu
	 1erTxcxXnQrhQCDDrgcg86Zdx5bQroPhSRO6ZbioU9oR0sI3KCTWjBH6tG2OA/Aa0J/Pw
	 E6K4ggmoQKak7kK1gABLQlq0ob8IL3Eaoy116Ml1ZueZqrADzijEQ6p2RiupKRFnGzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792859175;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=rEYvHdhBa3LszUOn6NvnbQU7HVKpJnGhOfI1tUGT76U=;
	b=ZsrB5cqrzRUkde6Gk9ggnhxycCumvJQEOt7x8QMbxuPGvtRnpyz2gq/jtyD+igLlAwiv
	 VCNEohezKss4VrudagtzwEh8QPhOQ4MjgNo3DaWdjgBhSix8NMKRwRVrtT5KCFIISspIU
	 A134Y7l+7UtchC6PSF1FtchLsejSUoFbKtrwzQpLG5ZLE3lx/rpdkYaVAm3LY+wEwUBTc
	 icnMGEdETLI9wrW+20wJ+Aqj2a+/B/9wiIk80klaBnR+A0WDL4Au2DysQtPH8CBhgBhUC
	 bnZXR/XtdHgV6PHRvMF6ZMi3gUw3t0ABK8DoHvvwjJV2Q0Byr1o6c4gLgIrauNoPalw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QDOpDJQJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F25606A323
	for <mptcp@lists.linux.dev>; Sat, 24 Oct 2026 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QDOpDJQJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539BC1F01828;
	Sat, 24 Oct 2026 16:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792859174;
	bh=rEYvHdhBa3LszUOn6NvnbQU7HVKpJnGhOfI1tUGT76U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QDOpDJQJQYqsPyq4+CS5DwVzW+dxeRXg3skg06rSybRsnlziVPS/OjT4pcFFH3uKn
	 LmvZL2y+X0VGwLKXZ7gxBhEsbdv1kOzSLNI6ayePyNqOwWdMRzdZg7l5NCt9v/nivh
	 TpycLs5dYbb2k/6BXCcFa/ezT+99s6L4vlt0gw3B3Lcta03yxLWfF0s45zNCcOJZFy
	 vC8TONlHv2/9dnCGRubIDWiNLfoHtlxMIcCu9yEBB+HrUSJSrFD0J3njZSRVcvu5aP
	 UvKjpiTcxvaKcJLemXF9NGIQUAwygEFfGHwAnSD5I8ixubvfLaQUEjy0c1ytLHeqy8
	 5p9AP1lB7TAhA==
Subject:
 Re: [PATCH mptcp-next v15 10/11] selftests: mptcp: sockopt: check app_limited
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, yangang@kylinos.cn, kuba@kernel.org
Date: Sat, 24 Oct 2026 16:26:13 +0000
Message-ID: <179285917388.3132.154779516364059270@kernel.org>
In-Reply-To: =?utf-8?q?=3C24897c9e72a3f0a2d489dcd7f1c2413eef88c85a=2E1792718?=
 =?utf-8?q?041=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C24897c9e72a3f0a2d489dcd7f1c2413eef88c85a=2E17927180?=
 =?utf-8?q?41=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new assertion
  `assert(s.tcp_info.tcpi_delivery_rate_app_limited == 1)` in…

--

selftests: mptcp: sockopt: check app_limited

This patch extends the TCP_INFO readback at the end of
connect_one_server() in mptcp_sockopt. It now asserts that
tcpi_delivery_rate_app_limited is 1, which is meant to guard the
subflow-side app-limited accounting added in the preceding commit.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> index b8158a1198eba..f7a45b93cbe06 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> @@ -635,6 +635,11 @@ static void connect_one_server(int fd, int pipefd)
>  	do_getsockopts(&s, fd, total, total);
>  
>  	assert(s.mptcpi_rcv_delta == (uint64_t)total);
> +
> +	/* app-limited accounting requires a recent kernel */
> +	if (expect_all_features())
> +		assert(s.tcp_info.tcpi_delivery_rate_app_limited == 1);

[Severity: Low]
Can this assertion tell the new accounting apart from the default value?

Every subflow starts out with the flag already set to 1:

net/ipv4/tcp.c:tcp_init_sock() {
    ...
	tp->app_limited = ~0U;
	tp->rate_app_limited = 1;
    ...
}

tcp_get_info() then reports tp->rate_app_limited ? 1 : 0.

The SYN is sent while app_limited is still ~0U, so tcp_rate_skb_sent()
tags it with is_app_limited = 1. The handshake sample therefore writes 1
again.

The only writer of rate_app_limited is this block in tcp_rate_gen():

net/ipv4/tcp_input.c:tcp_rate_gen() {
    ...
	if (!rs->is_app_limited ||
	    ((u64)rs->delivered * tp->rate_interval_us >=
	     (u64)tp->rate_delivered * rs->interval_us)) {
		...
		tp->rate_app_limited = rs->is_app_limited;
	}
    ...
}

That block is skipped for invalid samples (!rs->prior_mstamp, SACK
reneging, or rs->interval_us < tcp_min_rtt(tp)). With the preceding
commit applied, it is also skipped for an app-limited data sample whose
bandwidth is lower than the SYN sample's.

So with the fix, the 1 seen here may just be left over from init or the
handshake. Without the fix, the assertion fails only when a valid,
non-app-limited data-ACK sample overwrites the default.

In the common lossless veth case that overwrite does happen, so a revert
would most likely still be caught. Still, the check does not prove that
the data sample itself was flagged app-limited.

The msk->write_seq != msk->snd_nxt early return in
mptcp_rate_check_app_limited() is also never exercised. Would
over-marking go unnoticed by this test?

The commit message also seems to describe the mechanism inaccurately:

> Without the preceding commit, mptcp_sendmsg() never updates the per-subflow
> app-limited state, and this field stays at 0 - the assertion would fail.
> With it in place, the value is forced to 1, turning this into a regression
> guard for the subflow-side application-limited accounting.

Based on tcp_init_sock() and tcp_rate_gen() above, the field does not
stay at 0 without the fix. It starts at 1 and is cleared only by a valid
non-app-limited data sample. With the fix, it is not forced to 1 either.

Could the message be updated to reflect this? Could it also name the
commit it depends on ("mptcp: track app-limited state in mptcp_sendmsg")
instead of saying "the preceding commit"?

> +
>  	close(fd);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792718041.git.tanggeliang%40kylinos.cn
