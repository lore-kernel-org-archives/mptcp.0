Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793472142;
	b=ZJ/BRaqCv6hm6JDsOW7DxQnzwtYIbPg5yVJKokH+xE8/nV9LbKbmGq1Wx7w3pG1Nj29K
	 Kf17CnqdqyRkiPdE8zJSnliLDy0NPLsNN6BPaYv1yVIe+VFMCQQ4hwDMUmCYyOt4jz1XM
	 8cZVTc0JFuOI2KZZPN0cda59bzKtpfP1lb/zvpzBLmx3fT2KlYqEr2mJOcq3MQZlkHn09
	 IzBvY5t74ufB869Lg8/2TCmSiON/MmhZ1oMQz9bTOy+5OOXB0e0lu2dxENysx5A8i+1/0
	 E3XaIsvGd/AEV8hA0RjIBgyMRY92rSRzlR5lZ7GBQ8d5g2TIUCUZqW9mNOLDZNUOozA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793472142;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1cIq722CUUfSjYcb4U5EGo+QkDtPUwxUl/b8OXNJrnY=;
	b=LNyY9LYHi4/+S+WgBzIXBeVtnvrO/scBfxseGkUzjsl/ixa6n5JZJUpGyn2arUHF8eIv
	 OzO1Pis8kyPFCD+GhbiLmp9BLsswNrHFfsA/Gg3KA2EEYRXOZarSvFyzvvPeqQ3+XzTCQ
	 LUwkRuh2YgHqIkSVxZRaAmfukCwSVX5+X/oLa3k0tYikDlel8pP6BJ/ESvX/gMlIrZr8y
	 zTqPW2u8X7sqT3LSuu6QlRrefyQewn1mhHHZYEy85436udeSvwH/lTiLxhC+ZrUeS878I
	 VLmglO8vdhiol2QpiGYNYF5aEeCM09Aa3G/ZnLrwHR83ZXPyZW3MHb+9/2W2sRlkU4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQvvlwse;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF63F606A31A
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 18:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQvvlwse
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598541F0093A;
	Sat, 31 Oct 2026 18:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793472141;
	bh=1cIq722CUUfSjYcb4U5EGo+QkDtPUwxUl/b8OXNJrnY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IQvvlwseQsMoCSujrncJuFsFkY9Q9s2/LeYxt7Cy9yZPhaSl8P4U0fG0l4vC1fjwK
	 Vzx+XrYQ/IY/EIeYcooFYaH0PNulk1kawq08MQHe5piMWfypxIcICKB7m5eqbk49ML
	 xrVQe4gtXfCT3zjGIkV75jgpOqQdK3Qa9a4GHMe5NtzMiuR0HLItZub8rjPh/tTXMN
	 9GimOV7ZpQ8uya9GzHwssZBlQOwJ133AR8h2vvTdq/7ssnPKnSNCjDVaioGSl+w9H9
	 w+2Tx4sSiW2eskKOXStBYkq7U65Vj50XwfVvbbuJmR0pF7pXoOclGBs1RMKXqfE4Ql
	 722qjB0KEvnIw==
Subject: Re: [PATCH mptcp-next v13 6/6] selftests: mptcp: join: validate
 subflow retry after link failure
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sat, 31 Oct 2026 18:42:20 +0000
Message-ID: <179347214093.3128.5261056836000020778@kernel.org>
In-Reply-To: <20261030050727.3534304-7-anilkaushikwireless@gmail.com>
References: <20261030050727.3534304-7-anilkaushikwireless@gmail.com>
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

- [Medium] The first new test, 'subflow retry after link failure', can
  fail on a correct kernel when mptcp_join.sh is run with -C.

--

selftests: mptcp: join: validate subflow retry after link failure

This adds three mptcp_join.sh tests for the subflow-retries limit. The
client's packets are dropped with nftables until a subflow is closed and
re-created. The tests then check re-creation from the same address,
closing the connection while a subflow is being re-created, and that the
only subflow is not re-created.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index c3ccce96b45b1..00190a9ffc124 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

[ ... ]

> @@ -2585,6 +2792,133 @@ link_failure_tests()
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
> +		if wait_counter_ge $((timeout_poll * 4)) \
> +		   $ns1 "MPTcpExtMPJoinAckRx" 1; then
> +			sf_retry_after_block 10.0.3.2
> +			sf_retry_after_block 10.0.1.2
> +		else
> +			print_check "additional subflow"
> +			fail_test "no additional subflow before the blocks"
> +		fi
> +		mptcp_lib_kill_group_wait $tests_pid
> +		kill_events_pids
> +
> +		join_syn_tx=3 chk_join_nr 3 3 3

[Severity: Medium]
Can this check fail on a correct kernel when mptcp_join.sh is run with -C?

In this test server_in is not set, so both $cinfail and $sinfail are
128 MB and the transfer goes both ways. mptcp_lib_kill_group_wait()
stops that transfer while data is still moving, and only after that
does chk_join_nr() run.

With -C, init_partial() sets validate_checksum=true, and chk_join_nr()
then does:

	local rst_nr=${join_rst_nr:-0}
	...
	if $validate_checksum; then
		chk_csum_nr $csum_ns1 $csum_ns2
		chk_fail_nr $fail_nr $fail_nr
		chk_rst_nr $rst_nr $rst_nr

With an expected count of 0, chk_rst_nr() fails on any non-zero
MPTcpExtMPRstTx from the server:

	{ [ $rst_tx -eq 0 ] && [ $count -ne 0 ]; }; then
		fail_test "got $count MP_RST[s] TX expected $rst_tx"

Killing a busy bidirectional transfer looks likely to produce MP_RST
from the server. The client is receiving all the time, so its msk
probably has unread data at SIGTERM. That leads to:

__mptcp_close()
  mptcp_do_fastclose()

On the server side, mptcp_check_fastclose() then calls
mptcp_send_active_reset_reason() on every subflow not yet in TCP_CLOSE.
That includes stale subflows left over from the client subflows that
timed out.

The server's own fastclose, or tcp_close() with unread subflow data,
has the same effect. mptcp_established_options() adds MP_RST to each of
these RSTs when there is room, and mptcp_established_options_rst()
increments MPTCP_MIB_MPRSTTX each time.

Would setting join_rst_nr for this check, or skipping chk_rst_nr when
the transfer is killed, avoid a spurious "got N MP_RST[s] TX expected 0"
failure with -C?

> +		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 3
> +		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2 error 2
> +		sf_retry_cleanup
> +	fi

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030050727.3534304-1-anilkaushikwireless%40gmail.com
