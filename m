Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D4029BDBF
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 05:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792127516; cv=none; b=EOvEUUNiEfpN5ZjGECQe/br4hB9z0yKqbmrnMOl9lmBggOVnHcZbM/ttlfQJILLCUFNdO18e0zvXyPBeNYsIWO+LJ5dhFYph/Y4UJvjnpPRR4j6/IA9Z8CSVqH00+mGUwGFkrDYHyHryBUCZN7Dzo1N8o9eDUk/+Sp2nM/J6gkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792127516; c=relaxed/simple;
	bh=SYxucZjk8urJu6J4M+OViQKRgVQE7oiC4+7sv8YSm98=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pru/mA49RKzND2l+KylY3IrsadN4V2f1tjRHNYzYOBWrE3hfYi2irESKV2jLrQNDl6KVyGYq86BmnlUOpFvs6RoNxKJIVgMS3AQrZNhVv+dTGSwP5RBxvcfMK1Wuq9YqhNEPM2h5MZRJ/XV4hYYmd8rbiZzljE/OEGRdLmBtz1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0E+Acn9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0E+Acn9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7341F000C6;
	Fri, 16 Oct 2026 05:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792127515;
	bh=9vfyBLhCjHXk0edbnZwWsNY2j2gUceWzfTafYQYOm/o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=F0E+Acn9EWJoWcLzVcYMljIbXXArekOqBx2ofnd9A68SpnmB7X6SpBQjk+HK3/BEP
	 5/8B+iHT/NlQNIExf0DMEYiARdDL+0ykxA2OqqJlNGdUNM94KCQzpacXYWw/SC8+OB
	 DPjhcFzw5focDm9aAwmTh4LchwnDzGxbDMhj7FsixyAqDWv1gIiMXsrgy+DTrLuZXY
	 Lg1cx9ZChXRuZBcWI6OhATwz3/B0RJXxT618i3ozBbZOUvnaKtX5q43oY6C4YU9j4A
	 58iQv+XZazwlO32vyrLdOGeBHZKmqV78VNBOCKpaVTj5g/W5vF7d2yyYHIGH1jRW1Y
	 67d1vZ/3PvmLg==
Subject: Re: [RFC PATCH mptcp-next v3 3/3] selftests: mptcp: join: validate
 subflow retry after link failure
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Fri, 16 Oct 2026 05:11:54 +0000
Message-ID: <179212751449.3135.2387059591648808037@kernel.org>
In-Reply-To: <20261014143349.768138-4-anilkaushikwireless@gmail.com>
References: <20261014143349.768138-4-anilkaushikwireless@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new background transfer uses `test_linkfail=131072`
  (mptcp_join.sh:2679).
- [Medium] The two phases wait on absolute, cumulative
  MPTcpExtSubflowRetry values (`sf_retry_after_block 10.0.3.2 2 2` then…
- [Low] The per-step checks in sf_retry_after_block()
  (tools/testing/selftests/net/mptcp/mptcp_join.sh, lines 2208-2222) can…
- [Low] The comment on the new subtest in link_failure_tests() (lines
  2659-2660) says the initial subflow is re-created 'with an MPJ using…

--

selftests: mptcp: join: validate subflow retry after link failure

This adds a subtest to link_failure_tests() that runs a long transfer in
the background. It uses nftables to drop the client packets from the
additional subflow address until MPTcpExtSubflowRetry increases, then lets
them through and checks that a subflow comes back from that address. It
then repeats this for the initial subflow address.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index f4d8afaeda4f..1048c9cfceb7 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2151,6 +2151,76 @@ wait_attempt_fail()

[ ... ]

> +# $1: client address to block ; $2: retries ; $3: MPJ, expected after it
> +#
> +# The link stays up, but the client packets from this address are dropped:
> +# the subflow using it is closed after a few retransmissions, then re-created
> +# once the packets go through again.
> +sf_retry_after_block()
> +{
> +	ip netns exec $ns2 nft add rule ip filter OUTPUT ip saddr "${1}" drop
> +	wait_sf_retry $ns2 "${2}"
> +	ip netns exec $ns2 nft flush chain ip filter OUTPUT
> +	wait_mpj_ack "${3}"
> +
> +	print_check "subflow from ${1}"
> +	if ip netns exec $ns2 ss -tnH state established src "${1}" |
> +	   grep -q .; then
> +		print_ok
> +	else
> +		fail_test "no established subflow from ${1}"
> +	fi
> +}

[Severity: Low]
Can this check print OK even if no subflow was re-created?

wait_sf_retry() and wait_mpj_ack() both return 1 on timeout. Here both
results are ignored, so the rule is flushed and the check runs either way.

The ss filter only matches on source address and state. Nothing records
the original source port or 4-tuple before the block. So if the blocked
subflow never reaches the tcp_retries2 timeout, or one of the waits times
out, the original socket is still established and this prints
"[OK] subflow from <addr>".

The final chk_join_nr 3 3 3 would still fail, but it doesn't say which
address failed. Each silent timeout also costs at least timeout_poll
seconds. The same goes for the first wait_mpj_ack 1 call in
link_failure_tests(), which is also unchecked.

Would it make sense to check the wait return values, and to compare the
subflow source port before and after the block?

> @@ -2585,6 +2655,42 @@ link_failure_tests()
>  		chk_stale_nr $ns2 1 -1 2
>  		chk_link_usage $ns2 ns2eth3 $cinsent 50
>  	fi
> +
> +	# subflows closed after a silent link failure, then re-created: the
> +	# additional one, then the initial one, with an MPJ using ID 0

[Severity: Low]
This isn't a bug, but the comment says the initial subflow is re-created
with an MPJ using ID 0, and nothing below checks the address IDs.

mptcp_pm_kernel_retry_check() in net/mptcp/pm_kernel.c has handling that
is specific to ID 0:

	retry->remote.id = READ_ONCE(subflow->remote_id);
	if (!retry->remote.id && READ_ONCE(msk->pm.remote_deny_join_id0))
		return false;
	...
	retry->local.addr.id = subflow_get_local_id(subflow);

The only per-address check is ss -tnH ... src 10.0.1.2, and its output
doesn't include MPTCP IDs. chk_join_nr only counts SYN, SYN-ACK and ACK.
So a re-join with a wrong ID that the peer still accepts would not be
caught.

Could ss -tniH or the subflow events be used to confirm the ID?

[ ... ]

> +		{ timeout_test=120 test_linkfail=131072 \
> +			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null

[Severity: Medium]
Is 131072 the intended value here? run_tests() treats any test_linkfail
value above 2 as a file size in KB:

	if [ "$test_linkfail" -gt 2 ]; then
		size=$test_linkfail
		...
		make_file "$cinfail" "client" $size

So this writes 128 MiB of urandom data into cinfail and another 128 MiB
into sinfail. The transfer also writes cinsent and cout/sout copies. The
other background long-connection tests in this file use test_linkfail=128
with speed throttling. The largest value used elsewhere is 1024.

cinfail and sinfail are global. They are only rewritten by a later
foreground test with test_linkfail above 2, such as fastclose_tests, or
removed by cleanup() at exit. On CI where /tmp is tmpfs, about 256 MiB of
RAM stays in use through several of the test groups that follow.

The files are also generated inside the background job before the
connection starts, while the foreground runs the unchecked wait_mpj_ack 1.
On a slow debug kernel, could that wait time out, so the 10.0.3.2 drop rule
is added before the first MP_JOIN exists? The test would then cover a join
that never gets established, not an established subflow closed by RTO.

> +		local tests_pid=$!
> +
> +		wait_mpj_ack 1
> +		sf_retry_after_block 10.0.3.2 2 2
> +		sf_retry_after_block 10.0.1.2 3 3

[Severity: Medium]
Can the absolute retry thresholds turn the second phase into a no-op?

wait_sf_retry() compares the cumulative MPTcpExtSubflowRetry counter
against an absolute value. Phase 2 therefore assumes phase 1 ended with
exactly 2 retries.

In phase 1, the 10.0.3.2 subflow times out and mptcp_pm_kernel_retry()
bumps the counter to 1. The SYN for that attempt is dropped, and with
tcp_syn_retries=1 it fails after about 3s. mptcp_pm_kernel_retry_reconnect()
then does:

	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_SUBFLOWRETRY);
	if (mptcp_subflow_reconnect(sk, ssk, &retry->local, &retry->remote))

mptcp_subflow_reconnect() sends the SYN at once through
ssk->sk_prot->connect(), while the drop rule is still installed. Only the
SYN retransmit, 1s later, can get through.

The foreground may need more than about 1s to see the counter and run the
nft flush, for example on loaded CI or on debug or KASAN kernels. In that
case this attempt fails too, and a third attempt bumps the counter to 3
before the join succeeds.

Phase 2 then adds the 10.0.1.2 drop rule, but wait_sf_retry $ns2 3 returns
immediately and the rule is flushed straight away. The initial subflow is
never disrupted. wait_mpj_ack 3 times out silently, the ss check passes on
the original socket, and the run fails at chk_join_nr 3 3 3.

Would it help to read the counters at the start of each
sf_retry_after_block() call and wait for an increase from those values?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014143349.768138-1-anilkaushikwireless%40gmail.com
