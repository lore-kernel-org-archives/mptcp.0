Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF81B29BDBF
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 05:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792127515; cv=none; b=JtuYexLzoe7TwRXlHuOD/dsDEXK+jMPD3MgYN2ubw4QGPY/sT2pPfJx5KQbppXrJtM/SR/8aIpH/M57NN5lzD1qWLVN7PiJCnKF1Ziei9Ij+5Ne2PMkjIPn7I/qeQ7noUX4qIazOabm+BOUjxbS1W1F+XHdCYFm2o90jmDAXsKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792127515; c=relaxed/simple;
	bh=ThaiiFouCx80ZhckSJma8mMy7TRbZAWQQaux8C1uJz0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p1OCFELQO0EshERC87EkMv7GshwhdPTH2KdsXHqUHY1bCrS7JMQrotP4uOBAXEecamIw4KuDEFrJVoD2NMnSGj7jJfFanNqoMWibO6Soismw1ddIuctY+2tOm5cPZSLEDHLgI2TREKfYPP5x1PuIBUd3Sh+5HQ/7D9YYOLAR3ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcexD1ze; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcexD1ze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBFA1F000C4;
	Fri, 16 Oct 2026 05:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792127513;
	bh=Y+7BqsQeicGR3EduiiEF+blDvjAEAdPk3G3UuWWeXcg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mcexD1zeuw7tfZjMP46jN1+kZyeaOKEaC3/Wk/R4eupN4er1kkapXZyMaXPC3MmFZ
	 1WYexYakwzk1UnRCSv+ryhEzhYEpqgs10bgyX5+u5IaUd/0SCPsoktxMGz+XvnIFtX
	 PvMj2XK/oA6KTuz1fB4jblwRDZfUVG5tkv3UrI/lTSzTDxoJ1Dsxnu7MJQJyNmttc0
	 p/8ha0ZOsbh/8zIympUV8PEiNiPQWkROQrsINgPju5z4Rkb3IvAWAQBW7KyIvWy40E
	 8j3oAXYREfNZkJpnaHb5/npGBs4IONp4U7vuBk/V7HQ7EnVYrF7D0xi4e5pCgwGUmT
	 yRvyyS9nIClKQ==
Subject: Re: [RFC PATCH mptcp-next v3 1/3] selftests: mptcp: connect: retry
 write() on EAGAIN
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Fri, 16 Oct 2026 05:11:52 +0000
Message-ID: <179212751285.3135.6193959615773234178@kernel.org>
In-Reply-To: <20261014143349.768138-2-anilkaushikwireless@gmail.com>
References: <20261014143349.768138-2-anilkaushikwireless@gmail.com>
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

- [Medium] In copyfd_io_poll()
  (tools/testing/selftests/net/mptcp/mptcp_connect.c), the new EAGAIN…
- [Low] In copyfd_io_poll()
  (tools/testing/selftests/net/mptcp/mptcp_connect.c), `eagain_ms`…

--

selftests: mptcp: connect: retry write() on EAGAIN

In copyfd_io_poll(), this patch stops treating an EAGAIN from write()
after POLLOUT as fatal. The loop sleeps 1ms and goes back to poll().
It still gives up once the EAGAIN count exceeds poll_timeout.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index 178d98d91fea..03fff859e4d1 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -638,6 +638,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
>  		.events = POLLIN | POLLOUT,
>  	};
>  	unsigned int total_wlen = 0, total_rlen = 0;
> +	int eagain_ms = 0;
>  
>  	set_nonblock(peerfd, true);
>  
> @@ -711,6 +712,20 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
>  
>  				bw = do_rnd_write(peerfd, winfo->buf + winfo->off, winfo->len);
>  				if (bw < 0) {
> +					/* POLLOUT does not guarantee that
> +					 * the next write will not block:
> +					 * the MPTCP send buffer can shrink
> +					 * in between, e.g. when a subflow
> +					 * is closed. Wait for more space,
> +					 * but not forever: poll() does not
> +					 * check every cause of EAGAIN.
> +					 */
> +					if (errno == EAGAIN &&
> +					    ++eagain_ms <= poll_timeout) {

[Severity: Medium]
What happens here when poll_timeout is -1? The -t option parser in
main() turns any non-positive value into the "no timeout" value:

	case 't':
		poll_timeout = atoi(optarg) * 1000;
		if (poll_timeout <= 0)
			poll_timeout = -1;

With -t 0 or a negative value, the poll() call at the top of the loop
waits forever. But the first EAGAIN from do_rnd_write() sets eagain_ms
to 1, and 1 <= -1 is false.

Control then falls through to perror("write") and return 111. That is
the same fatal exit this patch is meant to remove.

Would a condition like (poll_timeout < 0 || ++eagain_ms <= poll_timeout)
fit the intent better? A separate finite cap would also work.

The in-tree scripts all pass -t ${timeout_poll}, so only an explicit
non-positive -t hits this.

> +						usleep(1000);
> +						continue;
> +					}

[Severity: Low]
Does eagain_ms actually measure milliseconds? It goes up by one per
EAGAIN and is compared with poll_timeout, which is in milliseconds. But
each retry goes back to the top of the loop, and this call gets the full
timeout again:

	switch (poll(&fds, 1, poll_timeout)) {

That iteration can also handle POLLIN with a blocking do_write() to
outfd before the next write attempt.

So each counted retry costs at least 1ms plus timer slack and syscall
overhead. If poll() blocks before reporting POLLOUT, a retry can cost up
to a full poll_timeout.

The counter is reset only after a successful write. Iterations that only
see POLLIN neither increment it nor reset it.

The in-tree scripts pass -t 30, which allows 30000 retries. That is
about 31-35 seconds when POLLOUT is reported right away.

If poll() blocks between EAGAINs, the total can go past the harness kill
timeout in mptcp_connect.sh:

	timeout_test=$((timeout_poll * 2 + 1))

The tool is then killed from outside and never prints its own write()
error.

The commit message says "If EAGAIN lasts longer than the poll timeout,
still fail". Could the bound track elapsed time, for example with
clock_gettime()? Alternatively, the variable could be renamed to show
that it is a retry count.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014143349.768138-1-anilkaushikwireless%40gmail.com
