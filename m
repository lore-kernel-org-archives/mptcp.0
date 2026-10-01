Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9344849BD6D
	for <mptcp@lists.linux.dev>; Thu,  1 Oct 2026 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889135; cv=none; b=SYPoRM4TK08mUx25ArgSOp7ejuNYb97wIKGvSA9pwlvvtGW0Em5eqg3E9aEywkJK+EU3LilFZba7vQKaDZuOIuIBLMiQuAx1si4WXd8eI+6rIPd34gCXc6MfMrhnR3iPtxfPDhx6JGqlvY+qslpGsck5jyFoqbIutoeLQgjR0W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889135; c=relaxed/simple;
	bh=GrodIak0UR3Pb+maq+wWWSImknkjYzNP2nLPSt6kIIc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CRJkLF2dbNTkOvIJGhS8Z/U525m8Gh7fhUXwHQJXo+e+Bn38N52g41/N3GjoFndWFLmDng0ij6jNxINKpZa0xSYR+uRDoaUgXiNsC0xRDGm1/kIIb/WbVst783wgMWR5FFXpDWu3PqBdLDeu8gdY7BufDrs0B+IAC+BMXifpf7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlcL2FZj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlcL2FZj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376C71F00893;
	Thu,  1 Oct 2026 21:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790889134;
	bh=JR5gM0RZoCWkh20BX7b7gw6oL/SQBQ0elEkbHNuz6Zw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DlcL2FZjd5b4J6UjgTI4iZ/w4LFQ2iIiKaiViV910NT8AuMwOeX7IDSlwOK29VjT6
	 Wp3tCQwg5tDlqettTGh9KF4jfOVL0a4C4VlaXyw+G2VKJSbfslcRK67WBMVZIAOt4t
	 CbRgR0jn4tREGyPRK9ZZsohnn//X8RzveEUooFvktTPY6MtwbVX0M8YoEdqpNpvqrz
	 oh165t3nm/HA/J7zNb6QMoF+xGoH4VfxYYAdbyS2aXr9hJ3gb8cc8XUJTVHNyysAyW
	 jHFPxCBb2j8fdYiXeyUSsGMATxSpyZGr0U6FPO3LOG+EdVbNGMx+On7QCLFLFV/XjL
	 +poxFKHjQWaUQ==
Subject:
 Re: [PATCH mptcp-next v14 10/11] selftests: mptcp: sockopt: check app_limited
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc:
 mptcp@lists.linux.dev, pabeni@redhat.com, yangang@kylinos.cn, kuba@kernel.org
Date: Thu, 01 Oct 2026 21:12:13 +0000
Message-ID: <179088913377.3135.2634053413734817495@kernel.org>
In-Reply-To: =?utf-8?q?=3Cbfe557770e77e6122a343dbfa3a7969e10606c48=2E1790734?=
 =?utf-8?q?083=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3Cbfe557770e77e6122a343dbfa3a7969e10606c48=2E17907340?=
 =?utf-8?q?83=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new assert(s.tcp_info.tcpi_delivery_rate_app_limited == 1)
  in connect_one_server()…

--

selftests: mptcp: sockopt: check app_limited

This commit adds a check to connect_one_server() in the mptcp_sockopt
selftest. After the small echo exchange, it asserts that
tcpi_delivery_rate_app_limited reads 1. The intent is to guard the
subflow-side app-limited accounting added in mptcp_sendmsg() by the
preceding commit.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> index d68515b7903b8..8d712bdb4325d 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> @@ -640,6 +640,7 @@ static void connect_one_server(int fd, int pipefd)
>  		total += 1; /* sequence advances due to FIN */
>  
>  	assert(s.mptcpi_rcv_delta == (uint64_t)total);
> +	assert(s.tcp_info.tcpi_delivery_rate_app_limited == 1);

[Severity: Medium]
Will this fail the whole test on kernels that don't have the
"mptcp: track app-limited state in mptcp_sendmsg" change?

The assert always runs. The only gate before ./mptcp_sockopt runs is the
mptcp_diag_fill_info check in mptcp_sockopt.sh:do_mptcp_sockopt_tests().
That check can't tell whether the running kernel has the new app-limited
accounting.

On such a kernel the value seems to be reliably 0 at this point:

  tcp_init_sock()
      tp->app_limited = ~0U;
  SYN-ACK -> tcp_rate_gen()
      app_limited is cleared, since after(delivered, ~0U) is always true
  write() -> tcp_rate_skb_sent()
      no tcp_rate_check_app_limited() runs on the subflow, so the data
      skb gets tx.is_app_limited = 0
  echo ACK -> tcp_rate_gen()
      tp->rate_app_limited = rs->is_app_limited;   /* 0 */
  tcp_get_info()
      reports tcpi_delivery_rate_app_limited = 0

tcp_ack() runs before the echoed payload is queued. The value is
therefore already 0 when the final do_getsockopts() reads it.

When the assert fires, the client aborts and rcheck() reports "client
killed by signal 6". mptcp_sockopt.sh then marks all of sockopt v4 as
failed and returns, so sockopt v6 never runs.

This file already lets new checks run on older kernels. For example,
process_one_client() has:

	/* be nice when running on top of older kernel */
	if (s.pkt_stats_avail) {

and the IP(V6)_RECVERR test uses expect_all_features():

		if (errno == EOPNOTSUPP && !expect_all_features()) {
			fprintf(stderr, "IP(V6)_RECVERR not supported, SKIP\n");
			return;
		}

Could this check be gated the same way? One option is to enforce it only
when expect_all_features() is true, or when the kernel is known to have
the feature, for example via a kallsyms check in mptcp_sockopt.sh.

>  	close(fd);
>  }
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790734083.git.tanggeliang%40kylinos.cn
