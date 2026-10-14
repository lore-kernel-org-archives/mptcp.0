Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5329838F656
	for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791963112; cv=none; b=clZT5DQrRZ7ZPVogyhTVuilXLWPOLIIbwgZM1etnAIu0wHp96Q4G2xCPbN0X7e2P3BeWGdutRR30733h+R80G0Woau8jF2tCzkpEDmY69gyy7HTUl609iKBXY3Y+J54vIXmQaKQfxIv2y/HUPNGTKriwkpCXhEvOyWrYnXfWUcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791963112; c=relaxed/simple;
	bh=dlwnEDR195uB/e6+xTC+0uRv5na+J7gaefHrqGjE9SE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QpWWNjKwQIuQEIAfe0Hwk+38EG8EZ741CmwvhSswqakmHgsIGBHaNamPtlTBusosl4JlJgAvimXpYNKvyis0wIQY9wUB0XeDWXg1kyhmeoEUyLJefQ3BfoI6pm8kEHJsxtU0eKUNb+diG0GHPEbMU1wqN83JsmSElyyQG+jsGFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcZfu2Q2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcZfu2Q2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141151F000FF;
	Wed, 14 Oct 2026 07:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791963111;
	bh=FE/Djia86sLgXfhMou6jaUgmwgzwJBVV1JzFEEFFL1c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dcZfu2Q27oc5bJNQ646lH/C207qwuB8mmbGXmIZdhrwnMJdYY0ByYzCUK5OKnt1pE
	 iiC7wa4qVDY6hTAjHerejZb+qei87O0vpJV53EtVkUhnvVw5HgIcNtsazL7pb2Zj+R
	 plaZxK3Kyl1RE7H3nu7TJ6fpiw5QoPK4TUGPkKHebI8Jy9Z2K5JQ9vO2wZeFy4OPfC
	 B+UwtGpJjm/IDTdpXWEMGHfoJ++5YjW39mbLvMBKZaz/R12SAEpsxM5Esx7led0rIN
	 mT0t3GrKlI0QZcQNbYSIcZSTL+eeiS0UeBV1UeoPHIQXDTa1cJgPtShTSbtP++lqPY
	 PH7wUU6hmcdrQ==
Subject: Re: [RFC PATCH mptcp-next 1/3] selftests: mptcp: connect: retry
 write() on EAGAIN
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Wed, 14 Oct 2026 07:31:50 +0000
Message-ID: <179196311060.3135.4021591990609174199@kernel.org>
In-Reply-To: <20261012171740.464517-2-anilkaushikwireless@gmail.com>
References: <20261012171740.464517-2-anilkaushikwireless@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit fixes a user-visible selftest failure but carries no
  Fixes: tag.
- [Low] The new `if (errno == EAGAIN) continue;` in copyfd_io_poll()
  jumps straight back to poll() with no retry limit, no backoff and no…

--

selftests: mptcp: connect: retry write() on EAGAIN

With this patch, copyfd_io_poll() in mptcp_connect goes back to poll()
when write() fails with EAGAIN, instead of treating it as fatal. The
reason given is that the MPTCP send buffer can shrink after poll() reports
POLLOUT, for example when a subflow is closed.

> Assisted-by: LLM
> Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>

[Severity: Low]
Should this patch have a Fixes: tag?

The poll loop was added in commit 048d19d444be ("mptcp: add basic
kselftest for mptcp_connect"). Since then, copyfd_io_poll() has treated
an EAGAIN from write() on the non-blocking peerfd as fatal. That commit
already calls set_nonblock(peerfd) before the loop, and it added the
perror("write") / return 111 exit.

The window described in the commit message also exists in the current
tree. __mptcp_close_ssk() ends with:

out:
	__mptcp_sync_sndbuf(sk);

This recomputes sk_sndbuf from the remaining subflows only. Existing
cases in mptcp_join.sh (remove and link failure) also close subflows
mid-transfer, so the problem does not look limited to the new test.

Documentation/process/coding-assistants.rst also asks for a Fixes tag
on bug fixes made with an assistant.

Could this get a Fixes: tag for 048d19d444be, or for the kernel change
that first made the sndbuf shrink reachable? It might also be a candidate
for -net.

If the failure only shows up with the new test in this series
("selftests: mptcp: join: validate subflow retry after link failure"),
could the commit message say so? It would also help to say which test or
CI run hit the failure, and how often.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index 178d98d91fea2..5bcebc7218647 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -711,6 +711,14 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
>  
>  				bw = do_rnd_write(peerfd, winfo->buf + winfo->off, winfo->len);
>  				if (bw < 0) {
> +					/* POLLOUT does not guarantee the next write
> +					 * will not block: the MPTCP send buffer can
> +					 * shrink in between, e.g. when a subflow is
> +					 * closed. Wait for more space.
> +					 */
> +					if (errno == EAGAIN)
> +						continue;

[Severity: Low]
Can this loop spin forever and never reach the poll_timeout check?

The continue goes straight back to poll() with no retry limit, backoff or
deadline. do_rnd_write() returns as soon as write() fails, so its
usleep(200000) calls are skipped:

do_rnd_write() {
    ...
	bw = write(fd, buf, do_w);
	if (bw < 0)
		return bw;
    ...
}

The sndbuf shrink case from the commit message looks fine. In that case
mptcp_check_writeable() re-runs __mptcp_stream_is_writeable(), so poll()
blocks until mptcp_write_space() wakes it.

But mptcp_sendmsg() can also return -EAGAIN on a non-blocking socket for
reasons that poll does not check:

mptcp_sendmsg() {
    ...
			if (!mptcp_page_frag_refill(sk, pfrag))
				goto wait_for_memory;
    ...
		if (!sk_wmem_schedule(sk, total_ts))
			goto wait_for_memory;
    ...
}

One example is when tcp_mem is over its hard limit:

1. __sk_mem_raise_allocated() calls sk_stream_moderate_sndbuf().

2. It then fails the charge when wmem_queued + size < sk_sndbuf.

3. If only a small part of winfo->len is left and most queued data has
   been acked, every write() of that tail returns EAGAIN.

4. Meanwhile mptcp_check_writeable() still reports POLLOUT.

A memcg charge failure, or any mismatch between poll writability and
sendmsg, would end the same way.

poll() then returns at once on every pass, so the case 0 "poll timed out"
path never runs. The tool busy-loops until mptcp_lib_wait_timeout kills
it. Before this patch it failed right away with "write: Resource
temporarily unavailable".

Would a bounded retry count, a short backoff, or a deadline based on
poll_timeout keep the watchdog and its diagnostic working?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012171740.464517-1-anilkaushikwireless%40gmail.com
