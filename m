Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793397764;
	b=MlHourCQBOrhIcw9kd/txtlWidoBAVogjSZR2hM67sNmbFAtya/V1vsm5c7rXV8N0/3o
	 cGC4wW4+rBpw5wON3L7vrjx2Lizm5PZgNF1RoH2jcXCEdJWCQPEq5OeYO4O5BoI2Ylg7c
	 LmDfOX1AxHykCgvV110KNpWtvD2CryXzmVMoXC1Q0cQRZcJs4nMn2j6anrICmYrmQ/PX6
	 m8Auxo6MKYpjo8xufj3NrWwTas/lN0rCYxsQW+XDW8vKEnUupKS8IEQOHkjgQJ9DASFrv
	 +ExpIsl90Nhr5aCCpP0M05Ca6T2CyRoEYszyTwzPwWArMHTCpd4xoQiE4om7p47XErA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793397764;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=83DWnuryJk8r3INmsqyxAiGGcclgod4HVpZzM7RmFLM=;
	b=ITSpVZIa/zPEgP1ufBK5+m7SyVE5L/liO94/P+NsbQFeTA9k6X3WvEfll+mzzTrXLTte
	 3khFeEg6dObnKpwW/UBN1JYR8tjzV+EDRNfUTDMSBlS48hEsAbR1ZtEQpEzcgJuybv6bB
	 cH/yE9/mmNKyVciYruxdMKMqJRI09a1Opvxx3/qJW0Vt+uACLF/t0OpZlzCiFWqbWKpov
	 gVbM1DD6eRAQwDWQe2HM68qvkrQuJn6m1qLeua069u+bRJLsIKEZz3YK+1CqLzHbnG08D
	 jLGbZhBMYPumPPUY1mEQRrBOvpauKGaSC2CYcd6JmSNzxCPK4PD+p/ZkBe9eHnncS5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jtRc0e7+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F42C60A2602
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 22:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jtRc0e7+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6121F0093A;
	Fri, 30 Oct 2026 22:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793397764;
	bh=83DWnuryJk8r3INmsqyxAiGGcclgod4HVpZzM7RmFLM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jtRc0e7+y9v+ORzJCaLxE4xckvHPho5W3dys7ieT5sFbhFRLgIjsTGVMF04vpBdvW
	 1GSaSSX3ggMUDSI/QDmAIPHCIx04ZlNd0qxyDWxrbk/st0Cndd4+o7T8e/0jrd+u/v
	 rrjUD/G9T8IUF6RDfNdTPnqa22/887CYea3oITQP8DEQdAVL3UaMqB4Z7Yg0nFapOX
	 sKF1VqaXAC2Ajh4R4u24pC/q9vc6PCZB6y6gDRyS20RCn1ePsQKwrWJnTCaV3NLisv
	 BVTxTunOGOUhjS6qBBqUDi7C/LNApUQpUtlKhRKSgHGmS1fNMUJrF3atOPIZ0jIHEY
	 3FDlMN0VwvlAg==
Subject:
 Re: [PATCH mptcp-next v2 5/5] selftests: mptcp: sockopt: check app_limited
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Fri, 30 Oct 2026 22:02:43 +0000
Message-ID: <179339776363.3128.13786911219654450267@kernel.org>
In-Reply-To: =?utf-8?q?=3C785e65bbb01dbf31ef2832d7a36c159027d6f22c=2E1793258?=
 =?utf-8?q?749=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C785e65bbb01dbf31ef2832d7a36c159027d6f22c=2E17932587?=
 =?utf-8?q?49=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
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

- [Low] The new check in connect_one_server()
  (tools/testing/selftests/net/mptcp/mptcp_sockopt.c:640-641) asserts…

--

selftests: mptcp: sockopt: check app_limited

This adds a check to connect_one_server() in the mptcp_sockopt selftest.
After a small data exchange, the test now asserts that the client subflow
reports tcpi_delivery_rate_app_limited == 1. The check is meant to cover
the preceding change to mptcp_rate_check_app_limited().

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
Does this assertion only cover one direction of the subflow app-limited
accounting?

The expected value of 1 is also the initial value set in tcp_init_sock():

net/ipv4/tcp.c:tcp_init_sock() {
    ...
	tp->app_limited = ~0U;
	tp->rate_app_limited = 1;
    ...
}

It only changes in tcp_rate_gen(), and only for a valid sample:

	if (!rs->is_app_limited ||
	    ((u64)rs->delivered * tp->rate_interval_us >=
	     (u64)tp->rate_delivered * rs->interval_us)) {
		tp->rate_delivered = rs->delivered;
		tp->rate_interval_us = rs->interval_us;
		tp->rate_app_limited = rs->is_app_limited;
	}

So a reading of 1 means one of two things: every valid sample was
app-limited, or no valid sample was ever recorded.

The test does catch the case it was written for. Without the preceding
fix, the handshake ACK clears tp->app_limited. The ACK for the data then
gives a valid sample that is not app-limited, and rate_app_limited
becomes 0.

However, the test never creates a sender that still has data queued.
Suppose a later change always marked subflows app-limited, for example
by dropping this bail-out in mptcp_rate_check_app_limited():

	if (msk->write_seq != msk->snd_nxt || mptcp_send_head(sk))
		return;

Would this test still pass in that case? Could a check be added that a
subflow reports rate_app_limited == 0 while the MPTCP socket still has
data queued?

Some smaller points:

Only the client subflow is checked. process_one_client() also sends the
echo through mptcp_sendmsg() on the accepted socket:

	ret2 = write(fd, buf, ret);

Should the server side have a matching check?

The check only runs when SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES=1.
Otherwise it is skipped without printing a SKIP message.

do_getsockopt_tcp_info() only waits for tcpi_bytes_sent and
tcpi_bytes_received to reach the expected values. It does not check that
a delivery rate sample was actually taken.

Given the above, the commit message says:

  This guards against regressions in subflow app-limited accounting.

Could this be narrowed to say that the test covers a missing app-limited
mark on an idle sender?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793258749.git.tanggeliang%40kylinos.cn
