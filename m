Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793487517;
	b=c01Bx0Mzur8xxW+PN1EPFhnenQyRegLiJwBv9p261l/SEex0IVPh45yiP6CFlvkI7u0B
	 osfKGimVmSbC1EzatGnFBbLOzvpRKiPzJnFGFRenTtA/7ucE5qBMgyW7O9Xs0QgYDEDb4
	 6ZQahFJQU7nIt1ISzw7RF1k7y8c3RoYtqB2XbZ7QDXF5/3o/UOjFfukJ/jj8lfmSS903L
	 vY4iQYUBt6jyAe+qxtzpRapHENwvYxHn5iLo8nrY36SJw23ab/3sWeQPybqqM6u8ktqFe
	 KGKRqbsQbY64tM6dCV29tbRcayCv2fOoVGNYWjYJlAISk2Ox6EAWTjqPup6qbqkpJbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793487517;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bxwmnpYlLiDXl80c+WMGbI8gt8tNfehn5nc+UGRzbPE=;
	b=D2NkdvJciz+kks844vaiKmPLeH0N1VgTFJQShuDP5RtG3sqGLCzeFfBnhVN6M8BwLayS
	 7IUtAkC5mRx3RcqhSouGZIGPx+sz7qXbakNDcqF2XtP4E99MpTbNwpTsKr4PHRGFzhYqU
	 gLHvEm11if6djf0Q1gt/VAz47A6BVB5g88B5los5ZjsOsJlcJ/p8jq4WaEHbnb0Sw4Bsi
	 nhKDjLGdWbigKsVAreKWdf9nObWBOZs8fiBjFyR4bgCbKulspBAxsabS09M8d8kZ3R8s1
	 cjdJlJg9es4mqTYciWe1XNgaZfnpAq0P3XNRMAl6pCbZK6SDKW+bGlNuv3MrqNzx62A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XnKEzgVf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BC2606A31A
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 22:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XnKEzgVf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966F11F000C1;
	Sat, 31 Oct 2026 22:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793487516;
	bh=bxwmnpYlLiDXl80c+WMGbI8gt8tNfehn5nc+UGRzbPE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=XnKEzgVfrUn12SYYkyDNsAdQ3j4+nXeU64btQOxHEnNdv/LQJL7Z6FFCvtlN8BpMs
	 rAmQmaLdfCh4ONb9rRE6xyLk1FymGw7URWmYaskWM4/X+dcMNXnsnxZJgbwPepETWG
	 g5i7NF6eyOk0Ro9+gCG9WLEgDgZ/wsxdoGSIds5AvVfI4Ehz+5Brd77ly8EyyDgrD3
	 LTwNFyPk4xlYwH2r+M4E2IirqiEcI51Tp/0wdEDxG3jmyDMPIvnauihIHXqHwCnCmX
	 gVpC8wUvZuK06brbP3+Pmea7+oW1KzXgcH9meohwox+42LofZIidDD6qJ2wMnsX0A4
	 5o12bfG1y89ew==
Message-ID: <sashiko-outbox-192215@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v2 7/8] selftests: bpf: mptcp: test the send
 limit of a scheduler
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261031-mptcp-sched-opp-retrans-v2-7-e9c4a30f6841@kernel.org>
References: <20261031-mptcp-sched-opp-retrans-v2-0-e9c4a30f6841@kernel.org>
 <20261031-mptcp-sched-opp-retrans-v2-7-e9c4a30f6841@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 22:58:36 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] selftests/bpf: deprecated CHECK() macro used in test_limit()
- [Low] selftests/bpf: non-standard multi-line comment style in mptcp limit=
 test
--

commit fb18275d8cce4c512f78d41262ea65272c01b932
Author: Abdul Wasey <w453y.me@gmail.com>

selftests: bpf: mptcp: test the send limit of a scheduler

This commit adds a bpf_limit round-robin MPTCP scheduler that sets send_lim=
it
to 4 KB on the selected subflow and a selftest verifying that no subflow
receives more than 4 KB between two get_send calls when sending 64 KB chunk=
s.

> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testi=
ng/selftests/bpf/prog_tests/mptcp.c
> index d77c9f8c53c75..4302c16cb6bb4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
[ ... ]
> @@ -820,6 +821,109 @@ static void test_burst(void)
>  	mptcp_bpf_burst__destroy(skel);
>  }
> =20
> +struct big_send_arg {
> +	int lfd;
> +	int err;
> +};
> +
> +/* send total_bytes in 64 KB writes, so that data fragments get larger t=
han
> + * the scheduler's limit
> + */
> +static void *big_send(void *data)
[ ... ]
> +/* At most 4 KB per decision, also inside a data fragment: no subflow ge=
ts
> + * more than that between two calls of the scheduler.
> + */
> +static void test_limit(void)

[Severity: Low]
This isn't a bug, but in BPF code and selftests, should multi-line comments
above big_send() and test_limit() place the opening /* on its own line with
the comment text starting on the next line?

> +{
[ ... ]
> +	ASSERT_OK(arg.err, "send");
> +	ASSERT_EQ(recvd, total_bytes, "recv");
> +	CHECK(has_bytes_sent(ADDR_2), "limit", "should have bytes_sent on addr2=
\n");

[Severity: Low]
Since CHECK() is deprecated in BPF selftests, could test_limit() use
ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr2") here instead,
matching the other ASSERT_*() calls in this function?

> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_limit.c b/tools/=
testing/selftests/bpf/progs/mptcp_bpf_limit.c
> new file mode 100644
> index 0000000000000..431f07d6b6696
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_limit.c
> @@ -0,0 +1,94 @@
[ ... ]
> +/* An MPTCP-level retransmission is not one of our decisions: do not cou=
nt
> + * what it sends.
> + */
> +SEC("struct_ops")
> +int BPF_PROG(bpf_limit_get_retrans, struct mptcp_sock *msk)

[Severity: Low]
Similarly, should the multi-line comment above bpf_limit_get_retrans() have
the opening /* on its own line to follow BPF coding style?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031-mptcp-sche=
d-opp-retrans-v2-0-e9c4a30f6841@kernel.org?part=3D7
