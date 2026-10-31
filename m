Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793458576;
	b=YFF989WmLRz43FUPTmr35dFT4FIYefKAHB9v6YyNk8hsBHjqAAyqP+QP6xtN/3e38seI
	 uLM9RS/2zMVxQFaqdmOx+KV61++vk0cpppER0dAsilbit96dfvBsCeIj/Lq7S6Xwpqdny
	 EDpLs+n3CWwBoU6zBpxtX5v1zntzVjaC2lgV8oSHPcyOtCsrW38M9JDcKbEtrlKKZ8gu8
	 wBK+4AYKdun1merzRwvMPfOMfp/c8QNZUnjZ1kk2T8+1BvGm6SoysO6dvQCIni6m5/fSw
	 1f7UArnvQav9N1AeWD6JklX7/hzMOZWUKduM1luk7NIIh0pU7+cI4XT8O+RhKduAY1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793458576;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=yDsnxPCPwDvfH7jQTIC7U9licrwvkVUOmUPVD2tQqDs=;
	b=WBf7V1tssV303z9Vn4FFpbSElgnyypxAJqCEhLejF++LK39ovkNLSg0t5Sk0I/M+jqyy
	 +5aiF8UeznmvM6r5lWtZq/fVai6jqfTFkB2GS7ixw+mwpaLXI2u8jsYxuFFdiHPUakDSi
	 JJ9ka9z6bXksn5Yu17O7uFDzA+Eo3VkxIDwUrTb0WtxnE109AETvI6HG7ilpN51M0Lt9T
	 CeUPgRhzy6tMV+sUrZePCVah4V1wwYqP/vyC4YgSHQOtgMSoVv7CYsYpNsacttD+KNA/K
	 ZmGbpa11lAy6ojOzrsThpxQX2ZigcNhXoyoHYJ6HuJWuDBgBMPl7zIfLw60P51P9KMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FxY5TiO4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3712606A31C
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FxY5TiO4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED2A1F000C1;
	Sat, 31 Oct 2026 14:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793458575;
	bh=yDsnxPCPwDvfH7jQTIC7U9licrwvkVUOmUPVD2tQqDs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FxY5TiO4G0S+Lb2CDD9kqsSntR5TkYQSjGBrF3+jKZfeE3dlVrkIrj/VIpKDSiVAy
	 a1ZvuBwgPxG0o/GOfKNL6BG2ra5HE9XbE9FYpGEJ3KTMRyoEvjZEEEOX/cltkNWiks
	 yVKTmBwpXNmlbrz0WcaKwlmjU8kfLX1ev3XNLquaLT1DzdE0SlqFCFKJDU8rJjfGRJ
	 xSlHxTWmEkX6gcPenm6lbNC7f8ewPZMU/0TigfdAxRX13jnhxAhnc/DpSoHvXYf37K
	 4+iEdtVP/1yWYCpQdc1U78nHajeb+0S+gEgBwA+gSdafL1qGrna40rceaeyFH5xkt7
	 M+zXZ8MyIiGhw==
Subject:
 Re: [PATCH mptcp-next v3 5/5] selftests: mptcp: sockopt: check app_limited
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Sat, 31 Oct 2026 14:56:14 +0000
Message-ID: <179345857465.3128.15418324477063692917@kernel.org>
In-Reply-To: =?utf-8?q?=3C3067cbb56400f1c1c7d372b17e82c1fd61d3e102=2E1793324?=
 =?utf-8?q?316=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C3067cbb56400f1c1c7d372b17e82c1fd61d3e102=2E17933243?=
 =?utf-8?q?16=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
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

- [Low] In connect_one_server()
  (tools/testing/selftests/net/mptcp/mptcp_sockopt.c:639-641), the new…

--

selftests: mptcp: sockopt: check app_limited

This adds an assertion to connect_one_server() in mptcp_sockopt.c. After
a small data exchange, it checks that tcpi_delivery_rate_app_limited is
still 1. The aim is to catch regressions in the subflow app-limited
accounting added by the preceding mptcp_rate_check_app_limited() change.

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
This isn't a bug, but a question about coverage. With this gate, the new
check only runs when SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES=1 is set:

static bool expect_all_features(void)
{
	char *env = getenv("SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES");

	return env && strcmp(env, "1") == 0;
}

So a plain "make run_tests" or a default kselftest run never checks the
subflow app-limited accounting. The comment says "requires a recent
kernel", but the code only reads the environment variable. It does not
probe the kernel.

This looks deliberate and follows existing MPTCP selftest practice.
pm_netlink.sh gates checks that only hold on newer kernels the same way:

if mptcp_lib_expect_all_features; then
	check "get_limits" "$(format_limits 0 2)" "defaults limits"
fi

mptcp_lib.sh also says the variable is set when validating against the
latest kernel. As far as I can tell there is no runtime probe that could
replace it. tcpi_delivery_rate_app_limited was in struct tcp_info long
before MPTCP_TCPINFO existed, so the size of the tcp_info the kernel
fills says nothing about whether mptcp_rate_check_app_limited() is
present.

Would it help to make the comment say the check is only enabled when
SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES is set, so it is clear that
default runs skip it?

> +
>  	close(fd);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793324316.git.tanggeliang%40kylinos.cn
