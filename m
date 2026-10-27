Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793136193;
	b=modZm5+310JxHluF3xCzsA3oUydrYqKRHP0PMDZ3XlQJtp0jvvpX0lamfSuRK2y7rY0l
	 YpuyxmMKOv7bcJdQF1SmHcMkneIzUcphQ1RE6dY4mWyi8uNCe09O720OiiWje3am/Rz01
	 0dwcVc9m6tZNKbRJjO6AhLe2T5NsZCQTEPlDzdz+E5Y3lIKkg4mYeyAzY89XgXWbm+K9l
	 A79vCf2/DxGYoYB2QO+T6Gld02ocRd3WU5V92S2JDS7VBYXQKI8j6levE7+WJtR5I1Vp3
	 zoARnc8glUQG3VmH2Ue+LL2PWS8XJZ4WkOHB/K+DSW0KBNzjR5TcYti6780rAfoDuKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136193;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=6A+5ACqZjK1lxXQ4wn4TYVngV3I0ZVfrbF0xnSxgW/U=;
	b=g0I4cIckKyC+UHp9/qgXiC2yEKKkPVeLxW96dja36GeTlpgRncRHUkGS3/CtW7mPxmnU
	 BshXq4hsU2pFxzRp9sWn0eYQJgR8jKp8U1n7L2LRrdw+ymJpb3i4zZ0VKfOpr57dlECj1
	 fWInIgo3N0U3p1ybPUbZHkZgi1+t92SMBkjqXZyq/k6lZKX0Qp6ZWw0uMudim1DHvR532
	 gKsuWuX38eb4tRCb0WHyXd7SA5NKP54kOFPaXBwn9HelVakvP/HvI+6fn0Tk97+M30CUR
	 dbGD22FhHYp2z+24SozKIE0os4kwkBe4i1V++k3LqwA5Ws+knPujm9tkpk1wK8ucI4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="It64T5/7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5C3606A329
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=It64T5/7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E231F01289;
	Tue, 27 Oct 2026 21:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793136193;
	bh=6A+5ACqZjK1lxXQ4wn4TYVngV3I0ZVfrbF0xnSxgW/U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=It64T5/7Df6E4nnqHHyAhg6N9E3q0Tv1Ofvxn1a2xpnxn8kljyejOvI0jkgJhhEpA
	 F34Yo2Lsj8E+PgSbp+Sy52QagLkDGYoTEPqws3HpAPnA88hGa9h+BLiiiEXR6r+NeM
	 iF8o4IWXUJ0x8nF0CqvnAurfZeE/PQJbVLjJm1nlpQ2ciOykoXQZGHlj8MHDma6CNv
	 nNq5J+9kGi7lVOEXuTPZyRCPFsxFM4K6bjmC9Z/razQHYbOb9k007o7XfRN8Grpx1g
	 P4n5Kp1BTfMxceCkbww0ONVlKOFC8OdRtYDNjmO8qgyJEuk3pcOtJE6MtPw23g8l9Q
	 Uqz8sQBs5MHRQ==
Subject: Re: [PATCH mptcp-next v10 6/6] selftests: mptcp: join: validate
 subflow retry after link failure
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 27 Oct 2026 21:23:12 +0000
Message-ID: <179313619254.3132.16266932205245652213@kernel.org>
In-Reply-To: <20261026063657.2955783-7-anilkaushikwireless@gmail.com>
References: <20261026063657.2955783-7-anilkaushikwireless@gmail.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The 'subflow retry, no other subflow' test in
  link_failure_tests() (tools/testing/selftests/net/mptcp/mptcp_join.sh)…
- [Medium] With -C, mptcp_join.sh sets validate_checksum=true for every
  test (reset(): `validate_checksum=$checksum`).
- [Low] In the 'subflow retry, no other subflow, path back' test, the
  background `run_tests` is started with only stderr redirected (`{…

--

selftests: mptcp: join: validate subflow retry after link failure

This adds four mptcp_join.sh tests for the subflow-retries limit. Each one
uses netfilter to drop the client packets from one address until the
subflow is closed and re-created. They cover re-creating the additional and
initial subflows, closing the connection while a subflow is being
re-created, and the close timeout when only a re-created subflow is left,
with and without the path coming back.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index c3ccce96b45b1..3fa561b1a8fd1 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

[ ... ]

> @@ -2585,6 +2826,148 @@ link_failure_tests()
>  		chk_stale_nr $ns2 1 -1 2
>  		chk_link_usage $ns2 ns2eth3 $cinsent 50
>  	fi
> +
> +	# subflows closed after a silent link failure, then re-created: the
> +	# additional one, then the initial one
> +	if reset_with_events "subflow retry after link failure" &&
> +	   continue_if has_subflow_retries && init_nft_filter; then
> +		sf_retry_init
> +		# killed at the end: the timeout only stops a stuck test
> +		{ timeout_test=600 test_linkfail=131072 \
> +			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
> +		local tests_pid=$!
> +
> +		# the 128 MB files are created first, that can take a while
> +		wait_counter_ge $((timeout_poll * 4)) \
> +			$ns1 "MPTcpExtMPJoinAckRx" 1
> +		sf_retry_after_block 10.0.3.2
> +		sf_retry_after_block 10.0.1.2
> +		mptcp_lib_kill_group_wait $tests_pid
> +		kill_events_pids
> +
> +		join_syn_tx=3 chk_join_nr 3 3 3

[Severity: Medium]
Can this fail on a correct kernel when mptcp_join.sh is run with -C?

With -C, reset() sets validate_checksum=true. chk_join_nr() then also
runs:

	if $validate_checksum; then
		chk_csum_nr $csum_ns1 $csum_ns2
		chk_fail_nr $fail_nr $fail_nr
		chk_rst_nr $rst_nr $rst_nr

join_rst_nr defaults to 0 here, so any MP_RST counted in ns1 or ns2 makes
the check fail.

The transfer is killed while it is still running in both directions at
the full 4mbit link rate, and mptcp_connect has no SIGTERM handler. If
either side still has unread data when its socket is closed at exit,
__mptcp_close() takes the mptcp_data_avail() branch:

__mptcp_close()
    mptcp_do_fastclose()
        tcp_send_active_reset()
            mptcp_established_options()
                mptcp_established_options_rst()  /* MPTCP_MIB_MPRSTTX++ */

On the peer, mptcp_check_fastclose() can do the same for subflows that are
not closed yet.

The "subflow retry, no other subflow, path back" test kills its transfer
the same way before calling join_syn_tx=1 chk_join_nr 1 1 1.

The existing tests that kill live transfers use rate-limited speeds
(speed=5/20), which leaves a much smaller window for unread data. Do these
two tests need to account for the MP_RST counters when -C is used?

> +		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 3
> +		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2 error 2
> +		sf_retry_cleanup
> +	fi

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
Does this check actually depend on the 5 second close timeout?

The commit message says this test "checks the connection is still closed
after the close timeout". However, the only pass condition is that ns2 has
no SYN-SENT socket within timeout_poll, which is 30s by default:

no_sf_connecting()
{
	! ip netns exec $ns2 ss -tnH state syn-sent | grep -q .
}

The background transfer here keeps the default timeout_poll, and
do_transfer() passes it to the client as "mptcp_connect -t ${timeout_poll}".
The path back test raises it, but this test does not.

With the only path blocked, the client stops getting poll events. After
about 30s copyfd_io_poll() returns on poll timeout and the client exits.
Its close goes through:

__mptcp_close()
    mptcp_close_retry_subflows()

This closes the retry subflow that is still in SYN_SENT, whether or not
the close timeout ever fired.

The slowwait only starts once MPJoinSynTx reaches 1, a few seconds after
the block (tcp_retries2=3). That puts the application's own close at
around 30s inside the 30s window.

Wouldn't this still print ok if mptcp_retry_check_tout() never started the
close timeout? It would also pass if the retry subflow followed
tcp_syn_retries=1 and went away after about 3 seconds.

The later checks give the same result in all these cases:

	join_syn_tx=1 chk_join_nr 0 0 0
	chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1 error 1

MPTCP_LIB_EVENT_CLOSED is not checked, and the exit status of the
background job is ignored.

Could the transfer use a longer timeout_poll, and could the wait be bounded
by close_timeout, or check that the MPTCP connection itself was closed?

> +		else
> +			fail_test "subflow still connecting"
> +		fi

[ ... ]

> +	# the path of the only subflow comes back before the close timeout:
> +	# the re-created subflow keeps the connection open
> +	if reset_with_events "subflow retry, no other subflow, path back" &&
> +	   continue_if has_subflow_retries && init_nft_filter; then
> +		# The SYN retransmissions back off: long enough for the next one
> +		# to be sent once the path is back, also on a slow machine.
> +		local close_timeout=30
> +
> +		sf_retry_init
> +		pm_nl_flush_endpoint $ns2
> +		ip netns exec $ns2 sysctl -q \
> +			net.mptcp.close_timeout=${close_timeout}
> +		# no data at all while the only path is blocked: a longer poll
> +		# timeout, so the transfer outlives the outage
> +		{ timeout_poll=$((timeout_poll * 4)) timeout_test=600 \
> +			test_linkfail=131072 \
> +			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null

[Severity: Low]
Will the output of this test always come out garbled? The second and third
tests send the stdout of the background job to /dev/null, but this one
does not.

chk_sf_retry_path_back() starts with:

	print_check "open after the close timeout"
	if ! wait_counter_ge $((timeout_poll * 4)) \
	     $ns1 "MPTcpExtMPCapableACKRX" 1; then

print_check() does not end the line. MPCapableACKRX can only reach 1 once
do_transfer() starts, and that happens after run_tests() has called
make_file() for the two 128 MB files.

So make_file()'s "Test file (size 131072 KB) for client/server" info lines
seem to always land in the middle of the check label, with the
[ OK ]/[FAIL] result on a line of its own.

The first test avoids this by waiting before print_check.

> +		local tests_pid=$!
> +
> +		chk_sf_retry_path_back 10.0.1.2 ${close_timeout}
> +		mptcp_lib_kill_group_wait $tests_pid
> +		kill_events_pids
> +
> +		join_syn_tx=1 chk_join_nr 1 1 1

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026063657.2955783-1-anilkaushikwireless%40gmail.com
