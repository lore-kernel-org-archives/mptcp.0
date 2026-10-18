Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E992D0C8F
	for <mptcp@lists.linux.dev>; Sun, 18 Oct 2026 05:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792301968; cv=none; b=BPykAJ9/tlviO9binmnPboemIXjwv5KBYIzmcZDNu7MF7TT2vjwhARojQcQ8o1KxpoKeQg1cQgJZwwhjzMbS7xT0qokNKpYHI8XBtQrvyzaEuWB/RtER1++LZ9SVzgLOt4T9AgM75/KvZnYBhFAlnvkYrjBnCZG6Wj2QVjyWqEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792301968; c=relaxed/simple;
	bh=1CvKztzrCFaYZMH3bSvOjiEObH26VN99InXRyZT8x6w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B6TDWeidpZ3p/7vpQok4iSGAD6Vf4pkW8sKOoV1Y7fcDgBlKNIUYlPLR4xcG7AQ2A75D3KWgSJmlXYuNXcaQnhJpo7T+htQXr4eC2OpWW7vO5QdyhVUms7fG3Az0ReRN0dHv2m+0iwsOmKLxAXjGCLYih05x0HP/+YU2fosYHyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVC+Js7R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVC+Js7R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFCD1F000C5;
	Sun, 18 Oct 2026 05:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792301966;
	bh=P5C+wg+EJI32FgQ9fC8DrsdcnAu02OZRozikG56M/qE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CVC+Js7Rllz/0MOMPBFdj/lMMJ3IHdhnM1EGkb438yHxqce0OM03dmuIG4EF6M0p3
	 BspUW/cBDE+OBujdKzilzK5JuXd4HEB+Ra6XeupNqdzd7tfY3O8/twdn1wVFrlpCMZ
	 ToVuMft2RiZYTtteE/CelwaIT9AwjCFNtgjpw2ieZz6yca2W6ewRihUNzoeRPWmtq8
	 6uNWG1L8/VfTH5jGAdpO0+I95dflpyTzYuizNyZ0oOCKRLAnbeECZBJrNHL39erzmT
	 D0WuDWAaFyD6vIoKQ1EztzHo3dHaGzHxBqVKNXCu8rypUmUlylPnEdp1b72ezInrml
	 OzM0q4zeMdPfw==
Subject: Re: [PATCH mptcp-next v5 7/7] selftests: mptcp: join: validate
 subflow retry after link failure
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sun, 18 Oct 2026 05:39:26 +0000
Message-ID: <179230196601.3133.2242694314991271561@kernel.org>
In-Reply-To: <20261016160926.1155262-8-anilkaushikwireless@gmail.com>
References: <20261016160926.1155262-8-anilkaushikwireless@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Setup for the new "subflow retry after link failure" test in
  link_failure_tests() depends on timing, and its first gate is never…
- [Low] chk_no_sf_connecting() cannot reliably show that the new
  mptcp_close_retry_subflows() helper works.

--

selftests: mptcp: join: validate subflow retry after link failure

This adds a test to mptcp_join.sh for the subflow-retries limit. While a
long transfer runs in the background, nftables drops the client packets
sent from a subflow address. Once the re-created subflow's SYN has been
retransmitted more times than tcp_syn_retries allows, the packets are let
through and the test checks that the subflow comes back. This is done for
the additional subflow and then the initial one. Finally the connection is
closed while a subflow is being re-created, and the netlink events are
checked.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index f4d8afaeda4f3..521f95d3027fa 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

[ ... ]

> @@ -2585,6 +2681,62 @@ link_failure_tests()
>  		chk_stale_nr $ns2 1 -1 2
>  		chk_link_usage $ns2 ns2eth3 $cinsent 50
>  	fi
> +
> +	# subflows closed after a silent link failure, then re-created: the
> +	# additional one, then the initial one. Then close the connection
> +	# while a subflow is being re-created.
> +	if reset_with_events "subflow retry after link failure" &&
> +	   continue_if has_subflow_retries; then
> +		init_nftables

[ ... ]

> +		# created here, not in the background job, for cleanup()
> +		if [ -z "$cinfail" ]; then
> +			cinfail=$(mktemp)
> +		fi
> +		if [ -z "$sinfail" ]; then
> +			sinfail=$(mktemp)
> +		fi
> +		# killed at the end: the timeout only stops a stuck test
> +		{ timeout_test=600 test_linkfail=131072 \
> +			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
> +		local tests_pid=$!
> +
> +		wait_counter $ns1 "MPTcpExtMPJoinAckRx" 1

[Severity: Medium]

Can the setup for this test take longer than this first wait_counter()
allows?

With test_linkfail=131072, run_tests() always regenerates both files,
because test_linkfail > 2. Only after that does it call do_transfer():

tools/testing/selftests/net/mptcp/mptcp_join.sh:run_tests() {
    ...
	if [ "$test_linkfail" -gt 2 ]; then
		size=$test_linkfail
		...
		make_file "$cinfail" "client" $size
    ...
	if [ "$test_linkfail" -gt 2 ]; then
		size=$test_linkfail
		...
		make_file "$sinfail" "server" $size
    ...
	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr}
}

That reads 2 x 128 MiB from /dev/urandom in 1 KiB blocks
(mptcp_lib_make_file() uses dd with bs=1024). All of this runs in the
background subshell before the listener and connector start. The mktemp
calls above only create the file names.

The return value of this wait_counter() call is ignored. File generation
plus connection setup might not fit in the timeout_poll window, for
example on a KASAN or lockdep debug kernel, or under emulation. In that
case sf_retry_after_block 10.0.3.2 fails with "no established subflow
from 10.0.3.2 before the block".

The later phases would then fail in turn. The absolute
wait_counter $ns2 "MPTcpExtMPJoinSynTx" 4 waits out its full timeout,
chk_no_sf_connecting() reports "no subflow re-created before the close",
and chk_join_nr and chk_evt_nr fail.

The commit message says the transfer lasts the whole test "on any
machine", but that covers the transfer, not this setup time.

Would it help to check the result of this first wait, or to generate the
files in the foreground before starting the background job?

> +		sf_retry_after_block 10.0.3.2
> +		sf_retry_after_block 10.0.1.2
> +
> +		ip netns exec $ns2 nft add rule ip filter OUTPUT \
> +			ip saddr 10.0.3.2 drop
> +		wait_counter $ns2 "MPTcpExtMPJoinSynTx" 4
> +		local retrying=$?
> +		mptcp_lib_kill_group_wait $tests_pid
> +		chk_no_sf_connecting ${retrying}

[Severity: Low]

Does chk_no_sf_connecting() actually exercise
mptcp_close_retry_subflows()?

mptcp_lib_kill_group_wait() closes the connection by killing both
mptcp_connect processes in the middle of a bidirectional transfer. If the
client msk still has unread data at that point, __mptcp_close() takes the
fastclose path:

net/mptcp/protocol.c:__mptcp_close() {
    ...
	if (mptcp_data_avail(msk) || timeout < 0 ||
	    (sock_flag(sk, SOCK_LINGER) && !sk->sk_lingertime)) {
		...
		mptcp_do_fastclose(sk);
		timeout = 0;
	} else if (mptcp_close_state(sk)) {
		__mptcp_wr_shutdown(sk);
	}

	mptcp_close_retry_subflows(sk);
    ...
}

mptcp_do_fastclose() moves the msk to TCP_CLOSE. __mptcp_destroy_sock()
then closes every subflow, including the SYN_SENT retry subflow, whatever
the new helper does.

The same happens if the server is killed first with unread data. It sends
MP_FASTCLOSE, and on the client mptcp_check_fastclose() closes every
subflow not already in TCP_CLOSE, including SYN_SENT ones:

	if (tcp_sk->sk_state != TCP_CLOSE) {
		mptcp_send_active_reset_reason(tcp_sk);
		tcp_set_state(tcp_sk, TCP_CLOSE);
	}

The helper only seems to matter on the graceful close path. Which path a
run takes depends on timing that the test doesn't control.

Could the "no subflow connecting after close" check pass even if
mptcp_close_retry_subflows() were broken or removed? Would a drained,
graceful close make this check deterministic?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016160926.1155262-1-anilkaushikwireless%40gmail.com
