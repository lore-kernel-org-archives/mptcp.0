Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792431980;
	b=FMtSNFNBHFJ0JPFE9EtGQVsSsKB1xlejYOVoF04zrddg0rI5ZYmzgjs+/Lp4sRsQKmKQ
	 YvpE+FVdIPIaw9sdFrRF28CaY5mZDTeRWDWL8qMkZ7jzyj2h5by0+Ag9nuQxmnPv53bYs
	 aKc/xPobzBVOhUfsDO6uamQNme/sbSyNrlumSYMe6tUw803VZO0JTRxI5lGRmjsbQOJrN
	 6MBjeh1ACUWA1BaqxMIyzn0zFMxEyqlxEces5Ftp6Fh6BZKk62T03Djmlwoh7nMBtEQEW
	 Mk10l3engWB2ARQ2hRIjTzZQltiMysQUr+bcwaM0rwMciUb1O+zCSkTDSlqDC63BJAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792431980;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=D9aHnwGL6FY6QcYOpQR9sYy0Z9eIPJd69W1MjJAcdBU=;
	b=WmYW9fRPS6ZqO0+fR/zSl9ZYVeeOhT01i6ypG8b1tjz9FFqgd2n1qM4c7rXDUSjUJZdF
	 Ou34MPQwFtLWHcPpTJ7wLJTO87bwSmWq07F64XXWdAmqUQVrZttWpGqfYBFXMFfvgAkoN
	 n2HgksjF9gh8pz0rCu3fUUDk/uI+iDQ+PQ0IWVALiQoihF7BVNdzSEhiwK8B5eXqE7eER
	 zeJPEMG5a0U+Vj0bx2UxQctQ2j8ns28zEWKNNaINuienF37My/gzg/xlCOw7pAGQadUXL
	 w11ePBQCikUAcgX026oLJPCHjtQ20STmvr0NNMTxjZcEwNIILonCrp4K21cbvBNTXrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VG17gzsN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55439606A33C
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VG17gzsN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27811F000CB;
	Mon, 19 Oct 2026 17:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792431980;
	bh=D9aHnwGL6FY6QcYOpQR9sYy0Z9eIPJd69W1MjJAcdBU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VG17gzsNbQKPowv4RmSo0BgAuWGbz9K0V4JPGz1eF0q6jbMAvFSBTqV+xYP9/pbkV
	 GsU7Ba550PKIvnoSXnpu8hASrS0bk2T5g93a82JxYYjVtkFj1wig+VvWyYeDuQGYEQ
	 Z8sdNeqfYyUy1y672X1wnwtuK/ULDyc09epndOZICSTtpMYEwtT0txowXY6Vq4nFNI
	 380pqMwtyM6jc38DFKO3WHcK40eRmN2b7siOBPet5RNJ9uK1CMpZFt58pwLZV9u/4X
	 v4F9zsH7XUDQF2AZStVA38wmr355E/hqfo4JrBx/s78LEZJarEiEMhFfBohpfKr8MI
	 cfPfKZbBGlf+g==
Subject: Re: [PATCH mptcp-next v6 6/6] selftests: mptcp: join: validate
 subflow retry after link failure
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 19 Oct 2026 17:46:19 +0000
Message-ID: <179243197932.3133.1635647280837164563@kernel.org>
In-Reply-To: <20261018041748.1655711-7-anilkaushikwireless@gmail.com>
References: <20261018041748.1655711-7-anilkaushikwireless@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In link_failure_tests(), the new "subflow retry after link
  failure" block empties the shared input files at the end (`: >…
- [Low] In sf_retry_after_block(), the drop rule is flushed (`ip netns
  exec $ns2 nft flush chain ip filter OUTPUT`, line 2225) before…
- [Low] sf_retry_after_block() decides whether the subflow was re-created
  by comparing the local address:port strings from `ss` before and after…

--

selftests: mptcp: join: validate subflow retry after link failure

This adds a test to link_failure_tests(). It uses nftables to drop the
client packets from one subflow address until the subflow is closed and
re-created, and lets them through again once the new SYN has been
retransmitted more times than tcp_syn_retries allows. This is done for
the additional subflow and then the initial one. The test then closes
the connection while a subflow is being re-created, checks the netlink
events, and empties the big input files at the end.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index f4d8afaeda4f3..d4b4146cbd64b 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2151,6 +2151,111 @@ wait_attempt_fail()
>  	return 1
>  }
>  
> +# $1: timeout in seconds ; $2: ns ; $3: counter ; $4: increment, 1 by default
> +wait_counter_inc()
> +{
> +	slowwait_for_counter "${1}" "${4:-1}" \
> +		mptcp_lib_get_counter "${2}" "${3}" >/dev/null
> +}

[ ... ]

> +sf_retry_after_block()
> +{
> +	local before after
> +
> +	before=$(sf_from "${1}")

[ ... ]

> +	# tcp_syn_retries=1: one more retransmission than allowed
> +	if ! wait_counter_inc "${timeout_poll}" \
> +		$ns2 "TcpExtTCPSynRetrans" 2; then
> +		ip netns exec $ns2 nft flush chain ip filter OUTPUT
> +		fail_test "SYN from ${1} not retransmitted enough"
> +		return
> +	fi
> +	ip netns exec $ns2 nft flush chain ip filter OUTPUT
> +
> +	if ! wait_counter_inc "${timeout_poll}" $ns1 "MPTcpExtMPJoinAckRx"; then

[Severity: Low]
Can this wait miss the MP_JOIN ACK it is waiting for?

The drop rule is flushed before wait_counter_inc() reads its baseline.
slowwait_for_counter() in net/lib.sh only reads the baseline when it is
called:

tools/testing/selftests/net/lib.sh:slowwait_for_counter() {
	...
	local base=$("$@")
	slowwait "$timeout" until_counter_is ">= $((base + delta))" "$@"
}

The re-created subflow keeps retransmitting its SYN on its own timer
(mptcp_pm_kernel_retry() sets icsk_syn_retries). If a retransmission
lands between the nft flush and the nstat read, the handshake can finish
and MPTcpExtMPJoinAckRx can go up before the baseline is taken.

The wait would then need one more MP_JOIN ACK that never arrives. It
would time out after timeout_poll and report "re-created subflow from
... not established", even though the subflow came back.

With exponential backoff, the next retransmission is about 4 seconds
away, so this only happens if the script stalls. Would it still be
more robust to read the counter before the flush and poll against that
saved value?

> +		fail_test "re-created subflow from ${1} not established"
> +		return
> +	fi
> +
> +	after=$(sf_from "${1}")
> +	if [ -z "${after}" ] || [ "${after}" = "${before}" ]; then
> +		fail_test "no new subflow from ${1}: ${before} -> ${after}"

[Severity: Low]
Is the address:port string always different for a re-created subflow?

The retry binds with port 0:

net/mptcp/pm_kernel.c:mptcp_pm_kernel_retry_check() {
	...
	retry->local.addr.port = 0;
	...
}

__mptcp_subflow_connect() then passes this address to kernel_bind(), so
the kernel picks an ephemeral port. The old subflow was also bound with
port 0. It released its port when it reached TCP_CLOSE, and the retry
check runs at that point, so the allocator can hand out the same port
again.

If that happens, this reports "no new subflow from 10.0.3.2: X -> X",
even though the MPJoinSynTx, TCPSynRetrans and MPJoinAckRx waits above
have already shown that a new subflow was established.

The odds are low, roughly 1 in 14000 per run for the 10.0.3.2 case.
Could the check rely on the MPJoinAckRx wait and an established subflow
being present, instead of comparing ports?

[ ... ]

> @@ -2585,6 +2690,65 @@ link_failure_tests()

[ ... ]

> +		join_syn_tx=4 chk_join_nr 3 3 3
> +		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 3
> +		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 3 error 3
> +
> +		# big files: empty them, the next tests write their own content
> +		: > "$cinfail"
> +		: > "$sinfail"
> +		: > "$cinsent"

[Severity: Medium]
Does the comment "the next tests write their own content" hold for the
test_linkfail=1 and test_linkfail=2 callers?

The files are emptied, but cinfail and sinfail still hold their paths.
For those modes, run_tests() only fills the files when the variable is
empty:

tools/testing/selftests/net/mptcp/mptcp_join.sh:run_tests() {
	...
	elif [ "$test_linkfail" -ne 0 ] && [ -z "$cinfail" ]; then
	...
	elif [ "$test_linkfail" -eq 2 ] && [ -z "$sinfail" ]; then
	...
}

Only the test_linkfail > 2 branches always rewrite the files.

The default order isn't affected, because this block is the last one in
link_failure_tests(). However, the getopts loop adds one entry per
option and doesn't remove duplicates:

	tests+=("${all_tests[${opt}]}")

So "mptcp_join.sh -l -l" runs link_failure_tests() twice. On the second
run, the test_linkfail=1/2 subtests would send 0-byte files and leave
$cinsent empty. chk_stale_nr() would then fail, and chk_link_usage()
would divide by zero:

	local tx_rate=$((tx_link * 100 / tx_total))

Reordering the groups, or adding a test_linkfail=1/2 case after this
one, would cause the same failures. Would it be better to remove the
files and reset cinfail and sinfail, or to have those branches check
[ ! -s "$cinfail" ] instead?

> +	fi
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018041748.1655711-1-anilkaushikwireless%40gmail.com
