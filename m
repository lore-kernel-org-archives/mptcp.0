Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641763612F3
	for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 07:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791963114; cv=none; b=q7WuMLA4TD46JZPGO/m/7WHcc80u3qq00GDyx465wWFm3/R0Pl7vIiC8/gijSmcI4WtNx2iH6K/qapT6cxGeLq5eZ2bjNN3vJ8RYqMjgfN5pSSBT95oUv3fh7b+XrrMpABqF+wpyAp87gx32Pb4qaAReZmiuGnTmwAB+jMl99ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791963114; c=relaxed/simple;
	bh=uMJOsAUzq4O1ACf76jm2hO3ziZOnRi3eE+FoiLz3ges=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BFyngUKLeO+cyP+8TAlD+KPQR7XWA4MXHr3qonr0WbTWzlmfnnUuK8gajaDdWWpdhwgUkg1SkbPqpgvpevMZd/4/Pf5tqoYCfDtO8WipipbwBrxcvTAQmb9nh45EblvqCxi5uXRAzpfRdYJIE4yTHy1+TeJkDnU3MsxOOzDYc/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqEuRkap; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqEuRkap"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9307C1F00898;
	Wed, 14 Oct 2026 07:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791963112;
	bh=qn22/FxNoWQjTMV4gAqKmsJG0KGatCRZjLXQhFEfmsA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iqEuRkapXjj86Y6qk+JTTIoVPTaxsqSuauisOL/eRykPIkXmZWcYDFfcEncEHideI
	 M9/UVVAwO2U9+SuJZwy3ggVYkGaDn/D+BbjCOVRfRZFuYm2dh345IGyr7weVtBmXgV
	 Y4BehfZcRFQJt4gsuzaMk/Y6llQPB3ciSoZrYy3M+141QJm9QcgCG1J9P1/K7hOCPo
	 Ymqq3aI1nlqmt+l6zZ/9MUwO1vOHVgRcqpx9+vrBBtNCpRP9Ux55uMVZ/gN509hzhf
	 llpg261m9bmH0IqXZzbw1rnWFBHwWB2xratSP/P6RKgmy1XNFti4D28gyiU1oTN1kU
	 ujj+8ISTtwZeg==
Subject: Re: [RFC PATCH mptcp-next 3/3] selftests: mptcp: join: validate
 subflow retry after link failure
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Wed, 14 Oct 2026 07:31:52 +0000
Message-ID: <179196311218.3135.16247940867951856164@kernel.org>
In-Reply-To: <20261012171740.464517-4-anilkaushikwireless@gmail.com>
References: <20261012171740.464517-4-anilkaushikwireless@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] run_sf_retry() in
  tools/testing/selftests/net/mptcp/mptcp_join.sh runs the transfer in…
- [Medium] run_sf_retry() calls run_tests() as a background job
  (`test_linkfail=32768 run_tests ... &`, lines 2204-2205), so it runs…
- [Low] Both new subtests check only totals: MPJoinSynRx/SynAckRx/AckRx
  == 2 and MPTcpExtSubflowRetry >= 1.

--

selftests: mptcp: join: validate subflow retry after link failure

This adds two mptcp_join.sh subtests for the new subflow_retry_timeout
sysctl. A transfer runs in the background while netem drops every packet
the client sends on one link. Once a subflow retry is counted, the link is
restored and the join counters are checked, for both an MP_JOIN subflow
and the initial subflow.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index f4d8afaeda4f3..a4549d8f291ee 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

[ ... ]

> +run_sf_retry()
> +{
> +	local link="${1}"
> +	local retry_nr
> +	local tests_pid
> +
> +	init_shapers
> +	ip netns exec $ns2 sysctl -q net.mptcp.subflow_retry_timeout=1
> +	ip netns exec $ns2 sysctl -q net.ipv4.tcp_retries2=3
> +	pm_nl_set_limits $ns1 0 2
> +	pm_nl_set_limits $ns2 0 2
> +	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
> +	test_linkfail=32768 \
> +		run_tests $ns1 $ns2 10.0.1.1 &

[Severity: Medium]
Can this leak the two 32 MB input files?

Here run_tests() runs in a background subshell. If cinfail and sinfail
are still empty, the mktemp assignments it makes exist only in that
subshell:

run_tests() {
    ...
		if [ -z "$cinfail" ]; then
			cinfail=$(mktemp)
		fi
		make_file "$cinfail" "client" $size
    ...
		if [ -z "$sinfail" ]; then
			sinfail=$(mktemp)
		fi
		make_file "$sinfail" "server" $size
    ...
}

The parent's cleanup() EXIT trap then runs:

	rm -f "$cin" "$cout" "$sinfail"
	rm -f "$sin" "$sout" "$cinsent" "$cinfail"

At that point cinfail and sinfail are still empty in the parent.

In a full run, the earlier foreground link failure tests set both
variables in the parent first. If only the new subtests are selected, for
example with ./mptcp_join.sh "subflow retry after link failure", reset()
skips those earlier tests.

In that case, does each run_sf_retry() call leave about 64 MB behind in
$TMPDIR?

> +	tests_pid=$!
> +
> +	wait_mpj 1
> +	tc -n $ns2 qdisc change dev ns2eth${link} root netem rate 20mbit \
> +		delay 1ms loss 100%

[Severity: Medium]
Is wait_mpj() enough to make sure both subflows are established before
the loss is applied?

wait_mpj() gives up after about one second, and the caller cannot tell
whether it timed out:

wait_mpj()
{
	...
	for _ in $(seq 10); do
		cnt=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinAckRx")
		[ "${cnt}" = "${exp_cnt}" ] && break
		sleep 0.1
	done
}

Before any connection is opened, the background job runs make_file()
twice with test_linkfail=32768, which writes about 64 MB from
/dev/urandom. Then do_transfer() starts nstat, the listener and the
client. With -c, cond_start_capture() also adds a fixed sleep 1 before
the listener starts.

If wait_mpj() times out first, the 100% loss hits the handshake rather
than an established subflow.

For link 3, the MP_JOIN SYN would be dropped and the subflow would stay
in SYN_SENT, where tcp_retries2 does not apply. mptcp_pm_retry_add() in
net/mptcp/pm.c only adds a retry for a subflow that was never established
after a path error:

	if (!established && !mptcp_pm_retry_path_error(err))
		return;

That path error only comes once the SYN retries time out, which is well
past the wait_sf_retry() budget. So MPTcpExtSubflowRetry would stay at 0.
For link 1, the MPC SYN itself would be dropped.

In both cases, wouldn't chk_join_nr 2 2 2 and chk_sf_retry_nr $ns2 1
report false failures, especially on debug kernels or with -c?

The other backgrounded tests in this file wait with wait_event() or
wait_attempt_fail(), not wait_mpj() alone.

> +	wait_sf_retry $ns2
> +	tc -n $ns2 qdisc change dev ns2eth${link} root netem rate 20mbit \
> +		delay 1ms

[ ... ]

> @@ -2585,6 +2657,18 @@ link_failure_tests()

[ ... ]

> +	# same with the initial subflow: re-created with an MPJ using ID 0
> +	if reset "initial subflow retry after link failure" &&
> +	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/subflow_retry_timeout'; then
> +		run_sf_retry 1
> +	fi

[Severity: Low]
This isn't a bug, but nothing in run_sf_retry() checks the "ID 0" part of
this comment. The checks in run_sf_retry() only look at totals:

	join_syn_tx=$((1 + ${retry_nr:-0})) \
		chk_join_nr 2 2 2
	chk_sf_retry_nr $ns2 1

mptcp_pm_retry_add() saves local.id, remote.id and the bound interface so
the subflow can be re-created on the same path.

A kernel change that reconnected on the wrong endpoint, or with the wrong
address ID, would produce the same counters and still pass.

Would it be worth also checking the addresses, interface and address ID
of the re-created subflow?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012171740.464517-1-anilkaushikwireless%40gmail.com
