Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793302168;
	b=huTEI3s9CriB5HN/Jo+IKMVAqZFQmD03f6gZa2WxmEUq0MSu50YCTfpKAga270dBWxgH
	 b7Y0MOHmCozyIFuaIlEXzG7eaKHLdqSGYhqxDdPF6hGY9wDQvfjcEUzyX5gndhGppEL51
	 WvnwPPN/6zhllSJTx7S9p5CWx9Ek7yJIjGXqe+/XV0l1eXbh4BowsjbFnSA/c+DR8dNOK
	 BsZOXnsyi2l7VdsrYXz0Fz5ZnkBNeUFm4m5CkNGH72pP50Lc8hBDqTvu8le12yZ9LXshO
	 2Q83QH399LGTh4KXL2dbVcexFXB8v0LBsa6hauAq9oQGBW+ddALKrqmr1NL0hYp4dBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793302168;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0xYhz1zRtcmXTNjEkoU33iXhLg8D0Yc0dflTZmAexoU=;
	b=GxOO+3TgRuLeo9/jmFqpRvdlNzz3wxTW630aYsky/dVzIeJLxbgoMfbtKm6vM6vBiPhm
	 3RNi+i895anu2wbMQY/rH1yLZWt57JRWEFScM70tN8Mvqcr/ZVVVkHtGqDu9Rj/0rqM0b
	 A2LqcZE+SF0XQDfXkIrjt/FdEPdSwwyrmm4hhpaFcz9RGFH7LmqbObvihg4i/w39gpYri
	 ByPPRocD/FSw4kdJJEgnG5RQ+2jK5ReD4kNb5SX4z2oGp4sT3EvD03uKhadQEogMv6h0X
	 AG0Y1Xxehyhw7hw/AQsj6P5theB0nvH2dRUdLYqNPpMtGoPzyUljiO/yFQ/CUXwUpDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eAAWeqJW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F390C606A31E
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 19:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eAAWeqJW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA4B1F01824;
	Thu, 29 Oct 2026 19:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793302167;
	bh=0xYhz1zRtcmXTNjEkoU33iXhLg8D0Yc0dflTZmAexoU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eAAWeqJW1xPnVoK2y4LZNuf/CbdmiWhUzzXt66vE0FrVMtzG3hCMi+fjzJ8wBoAMf
	 gUMlNNWor/8V0+qbt88PpS55QIwn2pCkZqXy4AIMm0WBQvMFDjOHOReGhq08GKGr4E
	 2d4E5oaIKeg5I7sdNqCpkLpBDrHcLdRWdpN17Al5I5GOBwceK1ZoWYdns/nu+P3U8D
	 5IpdYhhVk7y7V9yDrWkAm6fe01tEkaE3xVTjnVQjgk+pQYCJJOeK6C1Wj/R5Wm0/US
	 RiGkz68Z/rjy+O7RyIeFc1bykle5e3NnPdWR49Rz18WCDlLQJMRzCsbVaOkoTUEIAS
	 YpESTmh4f58Kg==
Subject: Re: [PATCH mptcp-next v12 6/6] selftests: mptcp: join: validate
 subflow retry after link failure
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 29 Oct 2026 19:29:27 +0000
Message-ID: <179330216728.3132.3885186232625700124@kernel.org>
In-Reply-To: <20261028054143.3222998-7-anilkaushikwireless@gmail.com>
References: <20261028054143.3222998-7-anilkaushikwireless@gmail.com>
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

- [Medium] The second test ('subflow retry, close while connecting') can
  lose the SUB_CLOSED event it checks, because nothing waits for the…

--

selftests: mptcp: join: validate subflow retry after link failure

This adds three mptcp_join.sh tests for the subflow-retries limit. The
first re-creates subflows after their packets are dropped with netfilter.
The second closes the connection while a subflow is being re-created and
checks the netlink events, and the third checks that the only subflow is
not re-created.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index c3ccce96b45b1..2b847d90674ea 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

[ ... ]

> @@ -2585,6 +2792,125 @@ link_failure_tests()

[ ... ]

> +	# close the connection while a subflow is being re-created
> +	if reset_with_events "subflow retry, close while connecting" &&
> +	   continue_if has_subflow_retries && init_nft_filter; then
> +		sf_retry_init

[ ... ]

> +		local fc_before
> +		fc_before=$(fastclose_nr $ns2)
> +		kill_client
> +		chk_no_sf_connecting "${not_ready}" "${fc_before}"
> +		mptcp_lib_kill_group_wait $tests_pid
> +		kill_events_pids
> +
> +		join_syn_tx=2 chk_join_nr 1 1 1
> +		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 1
> +		# the re-created subflow, closed with the MPTCP socket
> +		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2 error 1

[Severity: Medium]
Can the SUB_CLOSED event checked here be lost before the event listener
writes it to $evts_ns2?

kill_client() makes the client close the MPTCP socket. The msk is still
established at that point, so __mptcp_close() calls
mptcp_close_retry_subflows(). That function emits the event and then
destroys the SYN_SENT subflow right away:

net/mptcp/protocol.c:mptcp_close_retry_subflows() {
    ...
		if (sk->sk_state == TCP_ESTABLISHED &&
		    !subflow->close_event_done) {
			subflow->close_event_done = true;
			mptcp_event(MPTCP_EVENT_SUB_CLOSED, msk, ssk,
				    GFP_KERNEL);
		}
    ...
		__mptcp_close_ssk(sk, ssk, subflow, 0);
    ...
}

chk_no_sf_connecting() returns as soon as no syn-sent socket is left.
After that, only fastclose_nr() and mptcp_lib_kill_group_wait() run before
kill_events_pids() stops the listener through mptcp_lib_kill_wait():

	kill -SIGUSR1 "${1}" > /dev/null 2>&1
	kill "${1}" > /dev/null 2>&1
	wait "${1}" 2>/dev/null

pm_nl_ctl installs no signal handler, so SIGUSR1 kills it immediately.
capture_events() only prints an event once its select()/recv() loop has
received it. If the listener has not been scheduled yet, any event still
queued on the netlink socket is dropped.

Could this make the SUB_CLOSED check fail now and then on loaded or debug
kernel CI machines? Waiting for the expected SUB_CLOSED event to appear in
$evts_ns2 before calling kill_events_pids() would avoid this race.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028054143.3222998-1-anilkaushikwireless%40gmail.com
