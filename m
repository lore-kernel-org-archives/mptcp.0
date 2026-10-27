Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793134545;
	b=F9wTQLtt3aW8/4KNR/o9aOgaeikxtk4GOv0KdYcpaJ82MHN0u9NdxfWGOgjr0s3vkZyD
	 26MMGP8kQQpHQVLe0Fmsf0jRU1gFKmw6xir9vbGYLkptuXWmr6cCCq9URwiqFl0iSP/RG
	 4t/MawxBQLqE7YD9KoYdaLn2yAphEoo1uRiJjotmHEu93eHsaRkTACWlZCP9aVW1OS0BA
	 zwduMGUL8Ru2ssqsa/tkY0eNRXmjrKAz5pMddhw0Fg+vta6/sXyC8bPggCPRI+YHmsgiI
	 wn3gsZgTbUG9b9Oj4NsWdOj5GSI2/rX8a2kW+atjBfj4eKEg8HMIFsFYBdX5Vc78WiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793134545;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=DP1CU55727vH3jZ8rLLbPkXMU05vtWK3ELap1ZDWODU=;
	b=sCGefn6nVK4b/OKxFZY/GD67jZIiwmyIVr42oTogepXZxBSn+9LSDIMhU8z9nBZifUfi
	 fHX+6P25r6R6v2gIO1fAo0mxEumo4Jqr6pDRR2tfUxame0bVdPMTQvIDzZR8B4NzG7eZB
	 9m7Srv1c1D5f1rxzqESy47yNBg/e0zX/O8Nhm2omHy8FKPF9nS1sHytZb3OW92PWM2CkU
	 D2VJqJwEr1x8EqdzerRZivAQT+FocHg8cPyLc4tjypOPTmcsdt25ipko+ZWaOheaZv/A8
	 HHmWYnjqrfk0EwBerqlZ+bChfsHiDgepyopcYZWO+sXbUD+4Q4SDeRFhASM9kT5NpDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F68krKBc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E030606A320
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 20:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F68krKBc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9AD1F01825;
	Tue, 27 Oct 2026 20:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793134545;
	bh=DP1CU55727vH3jZ8rLLbPkXMU05vtWK3ELap1ZDWODU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=F68krKBc+R5Xrsez/RTPBf0KuB2GDcLcCqL+YMPFpwhsKsIFlhoImkCO2LPvR2CV8
	 pq8eCht4OlkiJkxdXjK2vFcHnP2YTDgEvohQw6WeKlxSKqHOG5E+SOdUh4kgH7EiRV
	 +PJ6a9BXO3aSbGYvbg6Q49MCZsvN5P+In0LfpDekiqcUMYjM1IzF8Zlf7DJ+XyrX5f
	 zPml0bIJuu7tuf/aY5E4evgUqn6Q0PDhArzb/vUHFj0djyku9SL8VeQ7HDtqtxLeF6
	 zoNl3hpBTINb1Ga85t1pTIXsppc02P2fPtZe597grFNVWCrzpahva37XakVXvh2IFv
	 8qjugdgzNMqvg==
Subject:
 Re: [PATCH mptcp-next 6/6] selftests: mptcp: sockopt: check app_limited
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Tue, 27 Oct 2026 20:55:44 +0000
Message-ID: <179313454439.3132.11520552687559318843@kernel.org>
In-Reply-To: =?utf-8?q?=3C8e5aa0a0ec2790efe1e793cf88ab50e11ef6302c=2E1792999?=
 =?utf-8?q?988=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C8e5aa0a0ec2790efe1e793cf88ab50e11ef6302c=2E17929999?=
 =?utf-8?q?88=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
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

- [Low] The new selftest check reads a different field than the one the
  kernel change writes, and it asserts that field's initial value.

--

selftests: mptcp: sockopt: check app_limited

This commit extends connect_one_server() in mptcp_sockopt.c. After the
small data exchange, and only when expect_all_features() is set, it now
asserts that tcpi_delivery_rate_app_limited is 1. The check is meant to
guard against regressions in the per-subflow app-limited accounting added
by the preceding commit.

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
Is this assertion checking the field that the kernel change writes?

mptcp_rate_check_app_limited() only calls tcp_rate_check_app_limited()
on each subflow, and that function only updates tp->app_limited:

net/ipv4/tcp.c:tcp_rate_check_app_limited() {
    ...
		tp->app_limited =
			(tp->delivered + tcp_packets_in_flight(tp)) ? : 1;
}

The value checked here comes from a different field:

net/ipv4/tcp.c:tcp_get_info() {
    ...
	info->tcpi_delivery_rate_app_limited = tp->rate_app_limited ? 1 : 0;
    ...
}

tcp_init_sock() sets tp->rate_app_limited to 1. Its only writer is
tcp_rate_gen(), and only when a rate sample is accepted:

net/ipv4/tcp_input.c:tcp_rate_gen() {
    ...
	if (!rs->is_app_limited ||
	    ((u64)rs->delivered * tp->rate_interval_us >=
	     (u64)tp->rate_delivered * rs->interval_us)) {
		tp->rate_delivered = rs->delivered;
		tp->rate_interval_us = rs->interval_us;
		tp->rate_app_limited = rs->is_app_limited;
	}
}

tcp_rate_gen() also returns early when !rs->prior_mstamp || is_sack_reneg,
and when rs->interval_us < tcp_min_rtt(tp). In those cases
rate_app_limited keeps whatever value it already had.

Could this still pass on a kernel without the preceding commit? That
seems possible if the rate sample from the ACK of the client's single
write is rejected or never formed, for example after loss and
retransmission or SACK reneging. rate_app_limited would then still hold
1, either from tcp_init_sock() or from the SYN sample.

In the normal lossless veth run the sample is accepted, so there the
check does tell the two kernels apart.

The commit message also says:

    With the preceding commit, mptcp_rate_check_app_limited() re-sets
    rate_app_limited to 1 when the MPTCP connection is application-limited,

and:

    However, in practice, valid samples clear
    it during transfer, so seeing 1 afterward indicates our code re-set it.

Does this match the code? With the fix, tp->app_limited causes the data
skb to be marked app-limited, so the data sample never clears
rate_app_limited. Nothing sets it back to 1. It simply stays at 1 from
the start.

Could the commit message describe the mechanism that way instead?

Coverage is also limited. do_getsockopt_tcp_info() asserts
num_subflows == 1, and connect_one_server() does a single write on a
fresh connection. As a result, the test never exercises the per-subflow
loop in mptcp_rate_check_app_limited() or this early return:

	if (msk->write_seq != msk->snd_nxt || mptcp_send_head(sk))
		return;

> +
>  	close(fd);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792999988.git.tanggeliang%40kylinos.cn
