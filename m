Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600616;
	b=yFBoC79j5J8voOsjyio5Y27TgWtDVfJCD+hNXhxLaTVzhyPEMDJNY6FLwJ7H5kxNpwrK
	 TG7Zi3wQnfcDDKEvMQ0fksrjmo15MfzFE4ZVtlVxB6psTt9CzpgJObZeyk8gLaL4SGD30
	 lzCg4N57bK21oZ+U9tYNtJF+5bBUTqZ4ZEFtDimneHnPCAJI99J/tED88UehnKUYRxrTy
	 RzRwx7mzeeH4eyT7GYaQxDSPjEf3iDU/o5VbbVnh1pDmPTClApfnycx2Xz8CpMBsfi/CL
	 VS6uaWUUxKwP7VY350qa3mzPHHOj5JuUxn7oXhIg3ScNmeVLB90m8S8awFZ0EiPXwCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600616;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=L5Eayrtw8N35HVeH5BztZx1Eg5ELU2FIMHy1YK/Q8ks=;
	b=2H5iP/fJyNdebFxHqXZfrV+3Sr1xBGaK+V1a9SmJLqNE+HmQUR0ME06eWt5DTQFOj/AZ
	 RNc8NC5CWJUY3WRkRQCjyuJwkp6I2M9Wx8N2dG6MXgq811u4r5pVOOtE3Su2Ok9vx3EN3
	 dICnlhaAlkMvf41yQkhU0QVXWvCQp7iF7DqzfflefUv648KeCUgnWBSsPchLdQQDzWlKJ
	 rr9BkPn6jsJ1SzYn/0OJqL8Q+Fmn+VXnlOVBdZONpTI+DjbeGwEVlfbhpDbmuW/gU7OME
	 9wqgT7DXfgJwuPoPbHvC9zeDwH/409UpjYq9EAlpL0pDb2CxeyUngswec6KZHkh2P1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nwe+XBUN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453F2606A319
	for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nwe+XBUN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98A81F000C1;
	Wed, 21 Oct 2026 16:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792600615;
	bh=L5Eayrtw8N35HVeH5BztZx1Eg5ELU2FIMHy1YK/Q8ks=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nwe+XBUNMHv/+u78UdloA82cpuJLSJ4VK2+9a4A2WOwCv16peb48akYq1Kpuv7keE
	 uqbevRzJj4u6/vEncFYcX9Qr+oazOr7rqqP4+Bmnc1cMuKa7WYoGF/x92f/kCoF6eM
	 Zg/dgNQuRb5hs7nabisfED4q7asqu6u3De/iHLnIoJV8hk6QTdt8D95RVfhq0ooE2t
	 fktSrEezydWLGyoCJFQ4gHMbkMIrccFU3wOHcwac3NMKXmWjr5CNmvZRnDhMc+ZAOE
	 tBpZdG0uFjLYsnOczfq2j2orKNYWw/mX2MDtQxFULjktUGtO+dudyu6IjIIq+hy+DU
	 X+cv9HDRYOGRA==
Subject: Re: [PATCH mptcp-next v7 6/6] selftests: mptcp: join: validate
 subflow retry after link failure
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Wed, 21 Oct 2026 16:36:55 +0000
Message-ID: <179260061526.3133.1559971650588338889@kernel.org>
In-Reply-To: <20261020031711.1896660-7-anilkaushikwireless@gmail.com>
References: <20261020031711.1896660-7-anilkaushikwireless@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The last step of the new test is meant to cover a specific
  kernel path: msk close while a re-created subflow is still in SYN_SENT.
- [Low] In run_tests() (mptcp_join.sh:1138-1140), the comment above the
  cinfail branch still says '# create the input file for the failure…

--

selftests: mptcp: join: validate subflow retry after link failure

This adds a link failure test case to mptcp_join.sh for the
subflow-retries limit. Netfilter drops the client packets from one
address at a time, and the test checks that the subflow is re-created
from the same address. At the end the connection is closed while a
subflow is being re-created, and the netlink events are checked.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index f4d8afaeda4f3..a99cee39da63e 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1137,7 +1137,7 @@ run_tests()
>  		make_file "$cinfail" "client" $size
>  	# create the input file for the failure test when
>  	# the first failure test run
> -	elif [ "$test_linkfail" -ne 0 ] && [ -z "$cinfail" ]; then
> +	elif [ "$test_linkfail" -ne 0 ] && [ ! -s "$cinfail" ]; then

[Severity: Low]
This isn't a bug, but the comment above still says the file is created
on "the first failure test run". With [ ! -s "$cinfail" ], the file is
now regenerated whenever it is missing or empty. The sinfail branch has
the same change.

The new test depends on this, because it empties cinfail and sinfail at
the end so that later tests write their own content.

Could the comment be updated to match the new condition?

[ ... ]

> @@ -2585,6 +2696,65 @@ link_failure_tests()

[ ... ]

> +		local retrying=1
> +		if nft_drop_from 10.0.3.2; then
> +			wait_counter_inc "${timeout_poll}" \
> +				$ns2 "MPTcpExtMPJoinSynTx"
> +			retrying=$?
> +		fi
> +		mptcp_lib_kill_group_wait $tests_pid
> +		chk_no_sf_connecting ${retrying}

[Severity: Medium]
Does this teardown actually exercise mptcp_close_retry_subflows()?

mptcp_lib_kill_group_wait() sends SIGTERM to every descendant. That
means both the ns1 listener and the ns2 connector are killed while the
128 MB transfers are still running in both directions.

If the client has unread data when it is killed, __mptcp_close() takes
the fastclose branch:

net/mptcp/protocol.c:__mptcp_close() {
    ...
	if (mptcp_data_avail(msk) || timeout < 0 ||
	    (sock_flag(sk, SOCK_LINGER) && !sk->sk_lingertime)) {
		...
		mptcp_do_fastclose(sk);
		timeout = 0;
    ...
}

The msk then becomes TCP_CLOSE. Next,
__mptcp_destroy_sock()->mptcp_destroy_common() calls __mptcp_close_ssk()
on every subflow, the SYN_SENT one included.

If the server has unread data instead, it sends MP_FASTCLOSE over the
unblocked 10.0.1.x subflow. On the client, mptcp_check_fastclose() then
moves every subflow to TCP_CLOSE.

In both cases, no_sf_connecting() in chk_no_sf_connecting() would pass
even if mptcp_close_retry_subflows() were removed or broken. The check
can only tell the difference on the non-fastclose path. On that path,
without the helper, the SYN_SENT subflow would stay until the 60 s msk
close timeout, which is longer than timeout_poll.

Is there a way to make sure the close here takes the non-fastclose path,
so that "no subflow connecting after close" really covers the new
helper?

> +		ip netns exec $ns2 nft flush chain ip filter OUTPUT
> +		kill_events_pids

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020031711.1896660-1-anilkaushikwireless%40gmail.com
