Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794963948;
	b=IHffOdAdYxOkztCsp5qbLBdccvyNCJPBQXjmMfkecxnLROOx1qJd4xdj6rrjbw1PmAEg
	 R1MP+/96M0PS+kQVegXlrg3zxbvaCma661LLA82BuKkMNE9zXnUTyysoyKD76t3Kgk/Ex
	 kAUOiSDOKoADLLlc1l8zuIiY5H0OF6xHLFjLFmuDCC69xy5iXpPbLt3oa3ASyK0LyGCPd
	 gk34EF68Zy5XVLfiG7vwFnmZr6BA4iQfWYAJ7T+UHrmhhGzUK5JaUMOz2hOHMp5T+76sw
	 dYIkWVhogQ2yCLrZZgpk2MohfxkjgrAPnIBy61AOFkphmhce5oSr557BZCkap6wazAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794963948;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=J2YGWE6Ma5p//M9yz33XZiCPlWpYPogA+amqkMr44qw=;
	b=5ekRk72ID5GCJ/hJ0QONRT5KUzdFvb1MseZRPAI25oTs1C3Ur25+tx1NclKebejwIF6o
	 NTzAJ5WEWiMfzes9Sz3a15db6jU1ILNTQhK8xm1qfszGasgO0FshgGbaTYCGzlMOO+JE4
	 0+DuLIo5tohyofwkorzLsOaZiLPn4fbV+mfJsZ94tng/5cI3jp6mQYhUFqS0/ALDvSh/2
	 UxVj+XT9Yjpuzk4kXjHrGnK3ohwH1GFQSnXp+Wm9L5a9UPi+pFWFllzfnVvA2LQgoef6L
	 pjAGoKDWRWwe7QSbE9LuUe7mG82cr5urN8SNZfdDQyfe/2mmNQJZOlb92HMVb81crWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YW69J1QY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1DD606A31C
	for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 01:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YW69J1QY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D721F000C9;
	Wed, 18 Nov 2026 01:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794963948;
	bh=J2YGWE6Ma5p//M9yz33XZiCPlWpYPogA+amqkMr44qw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YW69J1QY3oND5QmHKlO3A93ukj368B0rnAvnMKGCASJj/Bitx4hLU8yQA4tKIIQYS
	 GcnKOT2FGUwJXM4XFNZEvbcaHoHbJ2qXlmFkMboBoH0iXtv8IcvO6SCeDAcnzP3G1B
	 kEB3iGRaDWdrE0Cn2RZ8dUNEHq5355wvock25ivwCEZ/6Z9lkGhsExufpVM34rHkTS
	 KYddFLdKBIgdiB4pvB71fZLTxHWSvxSFgJb14OtcF5rjKrQmRjjNT2bjHTXoqZz6LD
	 07StUo9UWQhA5pRv2Np1iyFR7Pt2KorjELXitJ3PTWIrVJLxtCTjkt3Awdaj6n+BDW
	 o2oU4nyqLymRA==
Subject:
 Re: [PATCH mptcp-next v8 6/7] selftests: mptcp: sockopt: check app_limited
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Wed, 18 Nov 2026 01:05:47 +0000
Message-ID: <179496394785.3133.6898080008519020798@kernel.org>
In-Reply-To: <655e40ce580c2cdb8126397d03498d225dbea6da.1794826541.git.geliang@kernel.org>
References: <655e40ce580c2cdb8126397d03498d225dbea6da.1794826541.git.geliang@kernel.org>
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

- [Low] The commit 'selftests: mptcp: sockopt: check app_limited' is
  authored by `Geliang Tang <geliang@kernel.org>`, but its only Signed-…
- [Low] In connect_one_server()
  (tools/testing/selftests/net/mptcp/mptcp_sockopt.c:640-641), the new…

--

selftests: mptcp: sockopt: check app_limited

This commit adds a check to connect_one_server() in mptcp_sockopt.c. After
a small data exchange, it asserts that tcpi_delivery_rate_app_limited is 1
when expect_all_features() is enabled. The goal is to catch regressions
where MPTCP subflows are never marked app-limited.

> Author: Geliang Tang <geliang@kernel.org>
> ...
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the author address and the only Signed-off-by
address are different. checkpatch.pl reports this as
FROM_SIGN_OFF_MISMATCH.

Most of the series has the same mismatch:

  "mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint"
  "selftests: mptcp: connect: check TFO SIOCINQ overflow"
  "mptcp: implement peek_len for proto_ops"
  "mptcp: add sendmsg_locked to proto_ops"
  "mptcp: track app-limited state in mptcp_sendmsg"

"mptcp: update mptcp_check_readable", however, signs off with the
kernel.org address.

Could an in-body From: line with the kylinos.cn address be added, or the
sign-off switched to the kernel.org address, so the series is consistent?

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> index b8158a1198eba..9517c530ba214 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> @@ -635,6 +635,11 @@ static void connect_one_server(int fd, int pipefd)
>  	do_getsockopts(&s, fd, total, total);
>  
>  	assert(s.mptcpi_rcv_delta == (uint64_t)total);
> +
> +	/* app-limited accounting only checked under EXPECT_ALL_FEATURES */
> +	if (expect_all_features())
> +		assert(s.tcp_info.tcpi_delivery_rate_app_limited == 1);

[Severity: Low]
Can this assertion pass even when no rate sample was accepted for the
client's data?

The expected value is the same one tcp_init_sock() sets at the start:

net/ipv4/tcp.c:tcp_init_sock() {
    ...
	tp->app_limited = ~0U;
	tp->rate_app_limited = 1;
    ...
}

tcp_rate_gen() only updates tp->rate_app_limited when the sample gets
past its early returns, including this one:

net/ipv4/tcp_input.c:tcp_rate_gen() {
    ...
	if (unlikely(rs->interval_us < tcp_min_rtt(tp))) {
		...
		rs->interval_us = -1;
		return;
	}
    ...
}

Also, tcp_update_rtt_min() replaces a 0 us RTT with one jiffy:

net/ipv4/tcp_input.c:tcp_update_rtt_min() {
    ...
	minmax_running_min(&tp->rtt_min, wlen, tcp_jiffies32,
			   rtt_us ? : jiffies_to_usecs(1));
}

Suppose the clocksource is coarse and the data skb's RTT measures as 0 us.
Then ack_us is below min_rtt and the sample is dropped. rate_app_limited
keeps its initial value of 1, so the assert would still pass if
mptcp_rate_check_app_limited() were broken or removed.

On loopback with a fine-grained clock a sample is normally accepted, so
the check works in the usual case.

Would it make sense to also require s.tcp_info.tcpi_delivery_rate != 0,
or to compare tcpi_delivered before and after the exchange? Either would
confirm that a sample was actually measured.

> +
>  	close(fd);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794826541.git.geliang%40kernel.org
