Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792822281;
	b=sjVF7yqxCWFRF+WGU2LQUflWFC4siosFpcCZEQPXGXcs2aAvDev/GWI2jxwnCz1xZ9ek
	 y+l4x3VfeqWr8m9CfgWONMZXZOSRfjwvCh6N4C2WOLAuzY4bKlD+uineQJKV8HZoPJyx4
	 ynTyocIhUo4BaoVM6oY7mHk9BOIo6QPT9G2vY5rWrtQHxqBg8PICk+XGfnthN4eNWwox2
	 jR20axKgdo6u5oY9kvw75Be+yZlreTnOAnQTHzzmRSz42WKcquOLFIsKjzUU07gvKQmI/
	 q/tmSEsyxLaJ4ZvLaLoIAmPD4L+DtiUAz+e4aTKc/f0x98a/J3moIHVWqjwz/Usv5vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792822281;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=lWW4yxu9LJSo1nPDJkZPd4Fkx8NfL05mRTSChA9id1E=;
	b=WBusQJXYFft1iS6g+GGWaMiVoxmlN9XzURnhwFOORSMRzQj9x94TDxwbQiuuMbxfhDNd
	 vS825pQzMDFP1q4jcvN9Bai7ugJH4Hcjl7WRNGb12gtS/F2iVWrQ5++XbE0uRnWJOlgQg
	 z2dexpLpQO4IIuhpp+WNqu5vTLPOYlyLCYgq7h/6Nxg7wTHCgnEWqZ20n4rTzXqC5kar7
	 6Mx28vG1Eg7wbauKSFdm7AqUi/+WiK70RqL8hxl9KYFG2x/miBXHuMicxJK3j+tYkSvJR
	 Hx0D8wLW7C5vgD6y5D03LWDuOuAVgD+K8NmESV3no7MSrxaD97DiNG7kzflUrHs7YsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d5EFt9eW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0639D606A31F
	for <mptcp@lists.linux.dev>; Sat, 24 Oct 2026 06:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d5EFt9eW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8B51F031E2;
	Sat, 24 Oct 2026 06:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792822280;
	bh=lWW4yxu9LJSo1nPDJkZPd4Fkx8NfL05mRTSChA9id1E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=d5EFt9eWpHMFw5tmwKUb11xE/dTOv85y/QeDWvBjjlPbUWdNg2KoUsf7Z28f32LCe
	 Rc/kSs+Dq0X8UOxF6VFacZ4CTJ4ejAmrzpfzXXsjZcJ1clGkwu5Pp5UsOSsmulMA1W
	 CA25vRicxI+8tO7K0/+Ftizgtlorqz7qb6Fizr0TEzx6NuqaAxIMwTFVErE8AfJlqQ
	 r41f7gTciLzmO2yjx7PrEe0lVduKsbQAAGP3Rq8N3PVoO3WUCbtllnk/0pUbMGYU1x
	 jsYOGavf/3fojWhsedHoZQOIfvHuq6vtSIEp2MtdA0F2YisvNtYmEKrvkU4x2r2RUL
	 jNTjwzONhPmKA==
Subject: Re: [PATCH mptcp-next v8 6/6] selftests: mptcp: join: validate
 subflow retry after link failure
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sat, 24 Oct 2026 06:11:20 +0000
Message-ID: <179282228026.3132.4111619533930622506@kernel.org>
In-Reply-To: <20261022151130.2285198-7-anilkaushikwireless@gmail.com>
References: <20261022151130.2285198-7-anilkaushikwireless@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The 'subflow retry, close while connecting' test in
  link_failure_tests() feeds the server a FIFO (`server_in`) that nobody…
- [Low] In the 'subflow retry, close while connecting' test,
  link_failure_tests() ignores the return value of the first…
- [Low] The second new test leaves the FIFO and its writer process behind
  if the script exits abnormally.
- [Low] The relative-counter waits take their baseline only after the
  asynchronous event has been triggered.
- [Low] The new 'subflow retry, close while connecting' test builds its
  FIFO path with `srv_in=$(mktemp -u)`, which picks a name but creates…

--

selftests: mptcp: join: validate subflow retry after link failure

This patch adds two mptcp_join.sh tests for the subflow-retries limit. The
first test uses nftables to drop the client packets from one subflow
address until the subflow is closed and re-created, for the additional
subflow and then for the initial one. The second test closes the
connection while a subflow is being re-created and checks the netlink
events, with the server input taken from a FIFO that is never written.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index c3ccce96b45b1..58a48f50ba152 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

[ ... ]

> @@ -2151,6 +2158,183 @@ wait_attempt_fail()

[ ... ]

> +sf_retry_after_block()
> +{
> +	local before ack_rx

[ ... ]

> +	if ! nft_drop_from "${1}"; then
> +		fail_test "unable to drop the packets from ${1}"
> +		return
> +	fi
> +	if ! wait_counter_inc "${timeout_poll}" $ns2 "MPTcpExtMPJoinSynTx"; then
> +		ip netns exec $ns2 nft flush chain ip filter OUTPUT
> +		fail_test "subflow from ${1} not re-created"
> +		return
> +	fi

[Severity: Low]

Is the MPJoinSynTx baseline read too late here? wait_counter_inc() calls
slowwait_for_counter() in net/lib.sh, and that function reads the baseline
when it is called:

tools/testing/selftests/net/lib.sh:slowwait_for_counter() {
    ...
	local base=$("$@")
	slowwait "$timeout" until_counter_is ">= $((base + delta))" "$@"
}

By then the drop rule is already installed. With tcp_retries2=3 the
subflow is closed after about 3 s. If the shell is descheduled long enough
for the subflow to time out and be re-created before the baseline is read,
the wait expects a second MP_JOIN SYN that never comes. The test then
reports "subflow from X not re-created".

The "close while connecting" test has the same ordering for the drop rule
and its MPJoinSynTx wait. So do both initial MPJoinAckRx waits, which start
after the background run_tests is launched.

Would it be more robust to read the absolute counter before installing the
rule, or before launching the background job, and poll for that target?
The TCPSynRetrans wait does not look affected, because a late baseline
only means waiting for more retransmissions.

[ ... ]

> @@ -2585,6 +2769,69 @@ link_failure_tests()

[ ... ]

> +	# close the connection while a subflow is being re-created
> +	if reset_with_events "subflow retry, close while connecting" &&
> +	   continue_if has_subflow_retries && init_nft_filter; then
> +		sf_retry_init
> +		# The server sends nothing, but does not close its side: the
> +		# client has nothing to read, and the connection stays
> +		# established.
> +		local srv_in srv_in_pid
> +		srv_in=$(mktemp -u)
> +		mkfifo "${srv_in}"

[Severity: Low]

Can another local user race with this? mktemp -u only picks a name in /tmp
and creates nothing. The result of mkfifo is not checked.

Suppose a symlink or a regular file is created at that path before mkfifo
runs. mkfifo fails with EEXIST and the script carries on. The root
redirection below then opens the path with O_WRONLY|O_CREAT|O_TRUNC, which
follows symlinks unless fs.protected_symlinks or fs.protected_regular is
set. The mptcp_connect server, run as root, also reads that path as stdin
through do_transfer().

The rest of mptcp_join.sh uses plain mktemp. Would it be safer to create a
directory with mktemp -d, make the FIFO inside it, and stop the test if
mkfifo fails?

> +		sleep 600 > "${srv_in}" &
> +		srv_in_pid=$!
> +		{ timeout_test=600 test_linkfail=131072 server_in="${srv_in}" \
> +			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
> +		local tests_pid=$!

[Severity: Medium]

Does the server ever read from the MPTCP socket in this test? When
server_in is set, do_transfer() starts the listener with the FIFO as
stdin. copyfd_io_poll() only makes peerfd non-blocking, and a freshly
accepted socket reports POLLOUT, so the server ends up here:

tools/testing/selftests/net/mptcp/mptcp_connect.c:copyfd_io_poll() {
    ...
		if (fds.revents & POLLOUT) {
			if (winfo->len == 0) {
				winfo->off = 0;
				winfo->len = read(infd, winfo->buf, sizeof(winfo->buf));
    ...
}

It then blocks on the silent FIFO until it is killed.

MPTCP only grows the receive buffer from the read paths, through
mptcp_rcv_space_adjust(). So the server window would close after about one
initial rcvbuf of data, which takes a fraction of a second at 2x4mbit.

By the time MPJoinAckRx has been polled and nft_drop_from 10.0.3.2 has
run, is any data still in flight on the 10.0.3.2 subflow? That seems to go
against the comment above sf_retry_init():

    # machine, and the blocked subflow always has data in flight.

If that subflow is idle, it only times out (tcp_retries2=3) when the
MPTCP-level zero-window probe from mptcp_sendmsg_frag() and the TCP probe0
timer happen to land on 10.0.3.2 rather than 10.0.1.2. The scheduler makes
that choice. Otherwise retrying stays 1, chk_no_sf_connecting() reports "no
subflow re-created before the close", and join_syn_tx=2 chk_join_nr 1 1 1
fails.

In this state the client can neither read nor write. Could it also leave
copyfd_io_poll() with "poll timed out" after timeout_poll and close the
connection on its own, racing with kill_client()?

The first test does not seem to have this problem, because its listener_in
is the regular file $sinfail.

> +
> +		wait_counter_inc $((timeout_poll * 4)) \
> +			$ns1 "MPTcpExtMPJoinAckRx"
> +		local retrying=1
> +		if nft_drop_from 10.0.3.2; then
> +			wait_counter_inc "${timeout_poll}" \
> +				$ns2 "MPTcpExtMPJoinSynTx"
> +			retrying=$?
> +		fi

[Severity: Low]

Should the result of the first wait_counter_inc() be checked here?
sf_retry_after_block() checks sf_from() before it blocks anything. Here,
nothing confirms that the initial MP_JOIN subflow is established before the
drop rule is installed.

That wait can time out, for example when creating the 128 MB files in
run_tests() takes too long on a slow debug kernel. The rule can then be in
place before the SYN of the original join. MPJoinSynTx goes up because of
that original SYN, and retrying becomes 0 even though nothing was
re-created. mptcp_pm_kernel_retry_check() does not retry a subflow that
was never fully established.

The test still fails later in chk_join_nr, chk_no_sf_connecting or
chk_evt_nr. The messages would point at the retry or close logic, though,
rather than at the precondition that failed.

[ ... ]

> +		mptcp_lib_kill_wait ${srv_in_pid}
> +		rm -f "${srv_in}"

[Severity: Low]

Are the FIFO and its sleep writer left behind if the script exits
abnormally during this test? They are only kept in local variables, and
they are only released on this normal path.

The EXIT trap cleanup() removes cin, cout, sinfail, sin, sout, cinsent,
cinfail, tmpfile, the event files and err. cleanup_partial() only handles
$capout and the namespaces.

The script may be interrupted before the listener has opened the FIFO.
That is likely while run_tests() is still creating the 128 MB cinfail. In
that case the forked shell stays blocked in open(O_WRONLY) and never exits.

sf_retry_init() already creates cinfail and sinfail up front "for
cleanup()". Could the FIFO path and the writer pid also be global, so that
cleanup() handles them as well?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022151130.2285198-1-anilkaushikwireless%40gmail.com
