Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793071736;
	b=BP7q8aYuETo2+WhWsyDS6rbsR+E4OLUUc2mf/M2lyn8A7eyy2cA9ukVgj9Wdzd6JyPRy
	 kxHmYJYPyF1u1fs4kpDJUu79KgK17PN7yYiho9+si7T2vkvjp1I/pxeCp+pmVL1s9uu8V
	 DtHk+Ybr0hleC8gW51mmiVz98IQQQg6guywL1+pM2TDtTDZUlPiSRiQVQr/+3x43cAknh
	 QSEMJkApfybHxXcW3dIjlXtSTrnZe8JLkOyenWTsU7YFOEjjJV6eAihpPNC0EaCUwKhNc
	 /Ohnt1WkmUhnTV4YlEcoblZRitAD8vplfmerOIBa45sRl9Nkxon8ftiku2jWnmF6t4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793071736;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=DHrJhQnJsy8qR45yRwardHDqhC1mbcOnourkfrXQrNA=;
	b=hFtij4u5c5PKdYa0CqWIPaoZbYB7ToX08NwUS+g4+6hCfwSRmbPR5KVtuXSdGTueB9if
	 CPzdqQdFNLjqBrLZ8Vq+IepzAqDBkvkviBxXwS5FWpCjHoVqGFn4k9a7nTK7u8KUisDIs
	 Fsu+sYw3KcjjVxNJK35BAzykZ0IseYxPa+NOD81CdxhintTaIFJLlqiC/oXm1cUM7S2YV
	 CL6yia4H3qU7BKPEUdW6uKwSP+sTWtE3MLb7dXLIRWIywPkXvLPflRP6pdIVm5u6SNNHb
	 oFVtyIPruz3/ElIDYDzkynafhKTLvn1o9QgyxIjG2B3bJlMU83q84CbDR1CrI39x5Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VYh+2T+m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16EB606A322
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 03:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VYh+2T+m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AD21F01825;
	Tue, 27 Oct 2026 03:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793071735;
	bh=DHrJhQnJsy8qR45yRwardHDqhC1mbcOnourkfrXQrNA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VYh+2T+m1nZgLgI5UyL10VOdryLhf1iN6G8VNdVUWvLG1269ujIRTf3V3QqN5cpIh
	 524pF/TCZ50rHQhi3J9R+nHaOM8N89dWy3dtJrpBtgxDz5aRC2D+1nTlJrfg2KZJOS
	 Co6A1EfQMcEi4qkcUMjqR6XYZjGZQvI/wjV+VvBjrYXbyqrQXtzYjQMs1hcQZgw9Fr
	 ELody37wNiw9IyJnRln2NEh3lkdzYE9xmROz904ZCDhA8NnGBiTN7mgtvauYhsileA
	 x8VOMyHHeHyFStBd7dSYT2AQh5dW0SPfd2i7Z1eQX0IgL46hpBbMkldpfbGnS7xHya
	 4TgrIlIbrXtZw==
Subject: Re: [PATCH mptcp-next v9 6/6] selftests: mptcp: join: validate
 subflow retry after link failure
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 27 Oct 2026 03:28:54 +0000
Message-ID: <179307173479.3132.8276480291439834113@kernel.org>
In-Reply-To: <20261025134909.2794368-7-anilkaushikwireless@gmail.com>
References: <20261025134909.2794368-7-anilkaushikwireless@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In link_failure_tests(), the third new test ("subflow retry,
  no other subflow") does not reliably check what it claims, that the…

--

selftests: mptcp: join: validate subflow retry after link failure

This adds three tests to link_failure_tests() for the subflow-retries
limit. Netfilter drops the client packets so the subflows are closed and
re-created. The tests check that the re-created subflows connect again,
that a subflow still connecting goes away when the connection is closed,
and that a connection whose only subflow is re-created is still closed
after the close timeout.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index c3ccce96b45b1..e80f3f5f99973 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

[ ... ]

> @@ -2585,6 +2784,119 @@ link_failure_tests()

[ ... ]

> +	# the only subflow is re-created: the connection is still closed after
> +	# the close timeout, the new subflow cannot connect
> +	if reset_with_events "subflow retry, no other subflow" &&
> +	   continue_if has_subflow_retries && init_nft_filter; then
> +		sf_retry_init
> +		pm_nl_flush_endpoint $ns2
> +		ip netns exec $ns2 sysctl -q net.mptcp.close_timeout=5
> +		{ timeout_test=600 test_linkfail=131072 \
> +			run_tests $ns1 $ns2 10.0.1.1 >/dev/null & } 2>/dev/null
> +		local tests_pid=$!
> +
> +		print_check "closed after the close timeout"
> +		if ! wait_counter_ge $((timeout_poll * 4)) \
> +		     $ns1 "MPTcpExtMPCapableACKRX" 1; then
> +			fail_test "connection not established"
> +		elif ! nft_drop_from 10.0.1.2; then
> +			fail_test "unable to drop the packets"
> +		# no other subflow: the first MP_JOIN SYN is the re-created one
> +		elif ! wait_counter_ge "${timeout_poll}" \
> +		     $ns2 "MPTcpExtMPJoinSynTx" 1; then
> +			fail_test "no subflow re-created"
> +		# closed with the connection, after 5 seconds
> +		elif slowwait "${timeout_poll}" no_sf_connecting; then
> +			print_ok

[Severity: Medium]
Could this check pass even when the close timeout never fires?

do_transfer() starts the background client with the usual 30 s I/O
timeout. Setting timeout_test=600 only changes the outer watchdog:

    ./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \

After 10.0.1.2 is blocked, the client gets no more events. When poll()
times out, copyfd_io_poll() returns 2 and mptcp_connect exits, which
closes the MPTCP socket. __mptcp_close() then calls
mptcp_close_retry_subflows(), and that closes the SYN_SENT retry subflow
without any help from the close timeout:

net/mptcp/protocol.c:mptcp_close_retry_subflows() {
    ...
		if (state != TCP_SYN_SENT && state != TCP_CLOSE)
			continue;
    ...
		__mptcp_close_ssk(sk, ssk, subflow, 0);
}

The client's last event happens at or before the re-created SYN. Its 30 s
poll timeout therefore starts around the time of the block.

The slowwait window here is also timeout_poll (30 s). It only starts once
MPTcpExtMPJoinSynTx >= 1 is seen, about 3-5 s after the block with
tcp_retries2=3. So the client's own close falls inside this window, or
races with its end.

Suppose the re-arm in mptcp_retry_check_tout() were missing or broken:

	if (connecting)
		mptcp_start_tout_timer(sk);

__mptcp_subflow_connect() stops the timer, so the subflow would stay
connecting until the client exits on its own. Wouldn't this check still
print ok, or pass or fail depending on a sub-second race?

The final checks don't tell the two close paths apart either.
__mptcp_close_ssk() emits no SUB_CLOSED event, and the exit status of the
background transfer is never checked.

Could the wait be bounded to close_timeout plus a margin, well below
timeout_poll? Alternatively, the test could check that the client is still
running when the subflow goes away.

> +		else
> +			fail_test "subflow still connecting"
> +		fi
> +		mptcp_lib_kill_group_wait $tests_pid
> +		kill_events_pids
> +
> +		join_syn_tx=1 chk_join_nr 0 0 0
> +		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1 error 1
> +		sf_retry_cleanup
> +	fi
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261025134909.2794368-1-anilkaushikwireless%40gmail.com
