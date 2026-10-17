Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD293D9043
	for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 21:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792271239; cv=none; b=BKxDEIOYKMnaFkikLQGfcybaaPOLmoZ6h5ac9ZvtXtHXrEYI/96Xl5OVReny/w/+pS+L1SHWk5g3qSaQ4Ki2nrKwRsXnHnpzgTRcLwNY8OchL/7rzI8h2CNyunOfq7jwMW8rb/ciyMKQb/QxBR5jUmO8+uJBQ6YoQhulWLEGPs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792271239; c=relaxed/simple;
	bh=tT28Fbz8UBVm7AQlfRBNYN+r8bi/9ef9kYgBuKZMRmg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KyiIOskGNBcFA++sTNgd8WHAdX5SFenvGO5918oSVIqdlrvVsxX3ioMISLpE0jIwvVHihQ2fbuX8ytTJG1N2kG8NoIZXx5QPaBbZrOwJ3Wtn7YUMj/P73c70/Gs1YZGIl8OlhNOCwhUhb4mWWNDv4zTpBeiqclOqb+7YcOu7uZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zzpkt1dH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zzpkt1dH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7AB1F000C6;
	Sat, 17 Oct 2026 21:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792271237;
	bh=O4jwhDiLQQMe8wu9hV+aMmS+04ChpQ/OtABASUvthm8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Zzpkt1dH+nacVigtJRtQzkBvmJhYwqW8hLanjhQ5NgwxHv2bqb5k7RrKHemXNfyIk
	 IYNwqyJ4z/V/84CJOELxCtCgWO0lGloEsVBeo1PSvgYxdu//YoMO+bP1KYDcyuT31b
	 6kA12oj2JmkiQ4GKnI2eXxYQy7/ACH/eA5jd1LXCMMtPyDcEfzvacqw835Q/DiX5zP
	 XF3yRfKVBwPMjwSPMIJyF22sTrzaCyHyl1n+gcvbj0RWEsIK41KKsfZZH3n4Xi72Hz
	 TuutqlQbREP1plySz78Kg4EAMloiJolpDs3B2jwY9axfQbMOzkEApAkdgd1jwwg01/
	 uys5DlRnwwIVQ==
Subject: Re: [PATCH mptcp-next v4 3/3] selftests: mptcp: join: validate
 subflow retry after link failure
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sat, 17 Oct 2026 21:07:17 +0000
Message-ID: <179227123722.3133.10646334827815358929@kernel.org>
In-Reply-To: <20261016055010.980819-4-anilkaushikwireless@gmail.com>
References: <20261016055010.980819-4-anilkaushikwireless@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The post-close check in link_failure_tests() sets
  `net.mptcp.close_timeout=5` and says 'stopped at the latest by the…
- [Low] The new test never checks whether its netfilter rules were
  installed.
- [Low] link_failure_tests() now ends with `cinfail=""` and `sinfail=""`.
- [Low] The commit message says 'The big files used for the long
  connection are removed at the end'.
- [Low] The first sync point with the background job ignores its result:
  `wait_counter $ns1 "MPTcpExtMPJoinAckRx" 1` at line 2676.

--

selftests: mptcp: join: validate subflow retry after link failure

This adds a test to mptcp_join.sh. While a long transfer runs in the
background, nftables drops the client packets from one subflow address,
and the test checks that the subflow is re-created from the same address
once the packets go through again. It does the same for the initial
subflow, then closes the connection while a subflow is being re-created
and checks the netlink events.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index f4d8afaeda4f3..bbeff6739c5ac 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2151,6 +2151,69 @@ wait_attempt_fail()

[ ... ]

> +sf_retry_after_block()
> +{
> +	local syn_tx ack_rx before after
> +
> +	syn_tx=$(mptcp_lib_get_counter $ns2 "MPTcpExtMPJoinSynTx")
> +	ack_rx=$(mptcp_lib_get_counter $ns1 "MPTcpExtMPJoinAckRx")
> +	before=$(sf_from "${1}")
> +
> +	print_check "subflow from ${1}"
> +	if [ -z "${before}" ]; then
> +		fail_test "no established subflow from ${1} before the block"
> +		return
> +	fi
> +
> +	ip netns exec $ns2 nft add rule ip filter OUTPUT ip saddr "${1}" drop
> +	if ! wait_counter $ns2 "MPTcpExtMPJoinSynTx" $((${syn_tx:-0} + 1)); then
> +		ip netns exec $ns2 nft flush chain ip filter OUTPUT
> +		fail_test "subflow from ${1} not re-created"
> +		return
> +	fi

[Severity: Low]
What happens if this nft rule can't be installed? The test ignores the
result of init_nftables, of this nft add rule, and of the drop rule added
in the third phase in link_failure_tests().

If the insertion fails, the subflow keeps working and wait_counter times
out. The test then reports "subflow from X not re-created" (or "no
subflow re-created before the close") when it should have been skipped.

The other nft add rule users in mptcp_join.sh check the result and skip.
For example, reset_with_tcp_filter():

	if ! ip netns exec "$ns" nft add rule ip filter "${chain}" \
			ip saddr "${src}" meta l4proto tcp "${target,,}"; then
		mark_as_skipped "unable to set the filter rules"

Could this test use the same check-and-skip pattern? In practice this
only shows up on kernels without IPv4 nftables support, since the
selftest config gets it via CONFIG_NF_TABLES_INET.

[ ... ]

> @@ -2585,6 +2648,67 @@ link_failure_tests()
>  		chk_stale_nr $ns2 1 -1 2
>  		chk_link_usage $ns2 ns2eth3 $cinsent 50
>  	fi
> +
> +	# subflows closed after a silent link failure, then re-created: the
> +	# additional one, then the initial one. Then close the connection
> +	# while a subflow is being re-created.
> +	if reset_with_events "subflow retry after link failure" &&
> +	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_kernel_retry$"; then
> +		init_nftables
> +		init_shapers
> +		ip netns exec $ns2 sysctl -q net.ipv4.tcp_retries2=3
> +		ip netns exec $ns2 sysctl -q net.ipv4.tcp_syn_retries=1
> +		ip netns exec $ns2 sysctl -q net.mptcp.close_timeout=5
> +		pm_nl_set_limits $ns1 0 4
> +		pm_nl_set_limits $ns2 0 2
> +		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
> +		# created here, not in the background job, for cleanup()
> +		if [ -z "$cinfail" ]; then
> +			cinfail=$(mktemp)
> +		fi
> +		if [ -z "$sinfail" ]; then
> +			sinfail=$(mktemp)
> +		fi
> +		{ timeout_test=120 test_linkfail=131072 \
> +			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
> +		local tests_pid=$!
> +
> +		wait_counter $ns1 "MPTcpExtMPJoinAckRx" 1

[Severity: Low]
Should the return value of this wait_counter be checked?

mktemp only creates empty files in the foreground. The background
run_tests() still fills both 128 MiB files from /dev/urandom with
bs=1024 before mptcp_connect starts:

	if [ -z "$cinfail" ]; then
		cinfail=$(mktemp)
	fi
	make_file "$cinfail" "client" $size

On slow or debug kernels (KASAN, lockdep), could that plus the
connection setup take longer than the ~30 second wait_counter budget?

If so, sf_retry_after_block 10.0.3.2 runs before any join is
established. It fails with the misleading "no established subflow from
10.0.3.2 before the block", and the later checks fail too.

> +		sf_retry_after_block 10.0.3.2
> +		sf_retry_after_block 10.0.1.2
> +
> +		ip netns exec $ns2 nft add rule ip filter OUTPUT \
> +			ip saddr 10.0.3.2 drop
> +		wait_counter $ns2 "MPTcpExtMPJoinSynTx" 4
> +		local retrying=$?
> +		mptcp_lib_kill_group_wait $tests_pid
> +
> +		# stopped at the latest by the close timeout
> +		print_check "no subflow connecting after close"
> +		for _ in $(seq $((timeout_poll * 10))); do
> +			ip netns exec $ns2 ss -tnH state syn-sent | grep -q . ||
> +				break
> +			sleep 0.1
> +		done

[Severity: Medium]
Does the net.mptcp.close_timeout=5 setting above apply at this point?

After mptcp_lib_kill_group_wait, the msk is orphaned. __mptcp_close()
calls sock_orphan(sk), which sets SOCK_DEAD, before it calls
mptcp_start_tout_timer(sk). For a dead msk, mptcp_close_timeout()
ignores the sysctl:

net/mptcp/ctrl.c:mptcp_close_timeout() {
	if (sock_flag(sk, SOCK_DEAD))
		return TCP_TIMEWAIT_LEN;
	return mptcp_get_pernet(sock_net(sk))->close_timeout;
}

So the guaranteed bound is 60 seconds, but this loop polls for only
timeout_poll * 10 * 0.1 seconds (about 30 seconds).

mptcp_pm_kernel_retry() sets icsk_syn_retries to 15 on the SYN-SENT
subflow. The subflow only goes away sooner in one of two ways:

  - a fastclose, when one side has unread data at close
  - the client DATA_FIN, sent through
    mptcp_check_send_data_fin()->mptcp_subflow_shutdown()->tcp_disconnect()

The DATA_FIN goes out only after the whole pending send queue has been
pushed.

If both sides close gracefully and the client send queue doesn't drain
in time, could this report "subflow still connecting after close" on a
correct kernel? In that case the comment "stopped at the latest by the
close timeout" would not hold either.

[ ... ]

> +		# big files: do not keep them, the next tests create their own
> +		rm -f "$cinfail" "$sinfail"

[Severity: Low]
The commit message says:

    The big files used for the long connection are removed at the end.

Doesn't $cinsent also hold a big file at this point? With
test_linkfail=131072, do_transfer() copies the client stream into it:

	tee "$cinsent" < "$cinfail" | \

That can be tens of MB, up to 128 MB. Only a later do_transfer() with
test_linkfail != 0 rewrites $cinsent; in a full run that is
fastclose_tests(), many subtests later. Otherwise cleanup() removes it
at exit.

On a tmpfs /tmp, that memory stays in use through all the subtests in
between. Should $cinsent be removed or truncated here as well?

> +		cinfail=""
> +		sinfail=""

[Severity: Low]
Can clearing these variables leave temp files behind in later subtests?

Before this patch, link_failure_tests() left cinfail and sinfail
pointing at files owned by the parent shell.

Later subtests in userspace_tests() and endpoint_tests() call
run_tests() in a background subshell, for example:

	{ timeout_test=120 test_linkfail=128 speed=5 \

Inside the subshell, run_tests() sees empty variables and creates new
files:

	if [ -z "$cinfail" ]; then
		cinfail=$(mktemp)
	fi

These assignments never reach the parent shell, so cleanup() at exit
does not remove those files:

	rm -f "$cin" "$cout" "$sinfail"
	rm -f "$sin" "$sout" "$cinsent" "$cinfail"

In a full run, fastclose_tests() runs in the foreground in between and
sets both variables again. With "mptcp_join.sh -l -u" or
"mptcp_join.sh -l -I", though, each background subtest would leave two
temp files in /tmp.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016055010.980819-1-anilkaushikwireless%40gmail.com
