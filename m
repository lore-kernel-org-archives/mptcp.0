Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC6C56855E
	for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999300; cv=none; b=euAAjdx/Qew2sMKk9YDjHK6fQIUI77iLvY9wVU3Ca2g5TKGNGwiMXjlCyByP4pkziaraWLOj+16tQ112xh9am4u0ZvT+ApvM9Jlba0gRjQOeXZESpU85AVn5cn/b+m8xMZjIKTEK/pBlGyBFX2M5FxarhR7JRr8y/5FDW7jlpW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999300; c=relaxed/simple;
	bh=WSLCAygQM3BjW2d+Jyg97ycWYMsuv7oLtPtRWAOl1qs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H15gckGYbrhHO03H0iBvMjepjffIMiGAyMQxl0WzzVim4v1Wi423GPoi0sxFpfs8GNTaw1sHFysltdDpTcjPHWBT1DqRoQnmvU0VFPIEntCeE1ZBN8s0jesLcxr2I37OxkNABPzA6Ahf6FxzsdixpVz4ySeAC57P0/GVWfhsP4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJh6zg3U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJh6zg3U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6892F1F000C5;
	Wed, 14 Oct 2026 17:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791999297;
	bh=f1rKatsHDKFQkH7UqUztc8go6ee6H3B+AIiiEWQwnzs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KJh6zg3UplUgwfYnic40slFiyPLFrUnOPKXGFhuWdSBRKgqeTBTTgmTDhVUGqjhDE
	 bl4/edJ6zj0DMlYg9smncqk5W6+9oLe92NEp5j+ai+CtBXDSWRY7atgkdkjTTyOyjt
	 R3QUjsWtFox2fBfktBrkehkk7S/muUvab5STC5K3k4Mw+iTTCWtE+BkZQ98vamY7cN
	 0AEaHCO6M/Kdj36TFN2/6oTfn5xGNP3NPrcT+dbiEWu2OFe+udAtVZsx8JAq6UZ/GC
	 Hy7cPS8lGJmY27nGgfhqkeKzDQzd0Zh/Th1I8P+FudVsAUPb+GHdv8dr9rJHnMn8O5
	 w96ugTewYeplQ==
Subject: Re: [RFC PATCH mptcp-next v2 3/3] selftests: mptcp: join: validate
 subflow retry after link failure
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Wed, 14 Oct 2026 17:34:56 +0000
Message-ID: <179199929697.3135.6810712957067366060@kernel.org>
In-Reply-To: <20261013025653.523755-4-anilkaushikwireless@gmail.com>
References: <20261013025653.523755-4-anilkaushikwireless@gmail.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] sf_retry_after_block() in
  tools/testing/selftests/net/mptcp/mptcp_join.sh compares the…
- [Medium] The new subtest runs `run_tests` with test_linkfail=65536
  inside a background subshell (`{ timeout_test=120 test_linkfail=65536…

--

selftests: mptcp: join: validate subflow retry after link failure

This adds a mptcp_join.sh subtest for the new net.mptcp.subflow_retries
sysctl. It runs a long transfer in the background and uses nftables to
drop client packets, first from the additional subflow address and then
from the initial one. It then checks that each subflow is retried and
comes back once the packets are allowed again.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index f4d8afaeda4f3..10c431304d783 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

[ ... ]

> @@ -2585,6 +2647,34 @@ link_failure_tests()

[ ... ]

> +	if reset "subflow retry after link failure" &&
> +	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/subflow_retries'; then
> +		init_nftables
> +		init_shapers
> +		ip netns exec $ns2 sysctl -q net.mptcp.subflow_retries=15
> +		ip netns exec $ns2 sysctl -q net.ipv4.tcp_retries2=3
> +		ip netns exec $ns2 sysctl -q net.ipv4.tcp_syn_retries=1
> +		pm_nl_set_limits $ns1 0 4
> +		pm_nl_set_limits $ns2 0 2
> +		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
> +		{ timeout_test=120 test_linkfail=65536 \
> +			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null

[Severity: Medium]
If this subtest is selected on its own, does it leak the 64 MiB cinfail
and sinfail temp files?

Here run_tests() runs in a background subshell. If $cinfail or $sinfail is
still empty in the parent shell, run_tests() creates the file inside the
subshell:

		if [ -z "$cinfail" ]; then
			cinfail=$(mktemp)
		fi
		make_file "$cinfail" "client" $size

It does the same for $sinfail. With test_linkfail=65536, make_file fills
each file with 65536 x 1024 bytes.

Those assignments never reach the parent shell. As a result, cleanup()
only sees the empty strings:

	rm -f "$cin" "$cout" "$sinfail"
	rm -f "$sin" "$sout" "$cinsent" "$cinfail"

In a full run, the earlier foreground link failure subtests
(test_linkfail=1 and test_linkfail=2) have already set both variables in
the parent. When this subtest is picked by ID or by name, those subtests
are skipped, and about 128 MiB is left in /tmp on every run.

The existing userspace PM tests use the same background pattern. With
test_linkfail=128, they only leave about 128 KiB behind.

Could cinfail and sinfail be created in the parent shell before the
background run_tests is started?

> +		local tests_pid=$!
> +
> +		wait_mpj_ack 1
> +		sf_retry_after_block 10.0.3.2 2 2
> +		sf_retry_after_block 10.0.1.2 3 3

[Severity: Medium]
Can these fixed running totals turn the second block into a no-op? A
threshold of 3 for 10.0.1.2 is only right if the 10.0.3.2 block produced
exactly 2 retries.

In mptcp_pm_kernel_retry_reconnect(), the counter goes up before the SYN
is sent:

net/mptcp/pm_kernel.c:mptcp_pm_kernel_retry_reconnect() {
    ...
	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_SUBFLOWRETRY);
	if (mptcp_subflow_reconnect(sk, ssk, &retry->local, &retry->remote))
		return false;
    ...
}

So when wait_sf_retry() sees the counter reach 2, the nft rule is still
dropping that SYN. With tcp_syn_retries=1, there is only one SYN
retransmission, about 1s later.

Before the rule is flushed, the shell still has to:

- finish sleep 0.1
- read the counter with nstat in mptcp_lib_get_counter()
- run nft flush

On a loaded or debug-kernel CI machine this can take more than about 1s.
Couldn't the retransmission be dropped too in that case?

The attempt would then fail with ETIMEDOUT. Since 2 is below
subflow_retries=15, a third attempt raises MPTcpExtSubflowRetry to 3.

In the second block, wait_sf_retry $ns2 3 then returns on its first poll,
and the drop rule on 10.0.1.2 is flushed within milliseconds. The initial
subflow never reaches the tcp_retries2 timeout, so the ID 0 re-creation
never runs.

sf_retry_after_block() ignores the return values of both wait helpers:

	wait_sf_retry $ns2 "${2}"
	ip netns exec $ns2 nft flush chain ip filter OUTPUT
	wait_mpj_ack "${3}"

So wait_mpj_ack 3 times out after 30s without reporting anything. Then
chk_join_nr 3 3 3 fails with only 2 joins.

The counter also can't separate retries from the two blocks.
mptcp_pm_kernel_retry() raises the same namespace-wide counter when it
creates a new subflow:

	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_SUBFLOWRETRY);
	if (__mptcp_subflow_connect(sk, &retry->local, &retry->remote))
		return;

Could each block save the counter before adding its drop rule and wait for
a delta instead? Could the test also fail when wait_sf_retry() or
wait_mpj_ack() time out?

> +		mptcp_lib_kill_group_wait $tests_pid

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013025653.523755-1-anilkaushikwireless%40gmail.com
