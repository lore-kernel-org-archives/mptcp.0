Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795563045;
	b=fDlfRc843NxZ8Wx45akJft6b+Lk0Jk37KdonyjQqEw5wNMJQbJo+WuxixcG+n460Cg6g
	 QeKDuIs5DZizcLskfaRsvr5gdLQ0pRiO3R4/HEh6ZCSqmGeKXF85B5g8s2d/elQ0pGeDe
	 qT/b2wualeKmw5hplDYUl/1lspF+ZbmRvKD3Io5Gwuyi8yvj0Hb3FNHxGbp7M/PGzoSqU
	 nhwfHewz2WzVdair+agrDWFftRCrrHSu0LfMm2ZtMSLoho6qrL7zdL3sZT6CmukB8E+LW
	 lJl4vBMromxDqueuYB1hxrYMTchgQ+XOahaD/+lpBHyuIAo4B6jC6uRLzE5auurzkUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795563045;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=LIG5ugrfPBzX0yhaNnUKDtZ/5tjxw6qkLJ8kof+gcjE=;
	b=jR8mrwkDtcDyVtZAHJfBfx+Om7bDvwTeX35JIKjubuP+7hrYSLqnsVQcA8oKWsz+QSRs
	 XUgW7SUJ0+kHL3M1Nt7hfj1NWzWqTimdQX43zDw8oXnHn2DmLxBWoXWGW4gBhem9qtwYu
	 Zzqek0rpfC+JaD4fTWr/ip06BSR6OY+rhtmMndDFrTN+5uePd2sPXvY+Wyi6cSZBjXTHy
	 FCy2wU1VAivSVPzrjAUNmFhKtY1ezedFxvwATMYsFxpZcnyF8SHZo4Hrsc5WyquHV3q7S
	 8usy8+sS0OTekaqX69mIibUjSQ5XI3DZenghCJoeh6w134b8ijL0kAda8T2Larz9idQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jOILQEfC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15936606A680
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 23:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jOILQEfC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694F41F000F0;
	Tue, 24 Nov 2026 23:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795563044;
	bh=LIG5ugrfPBzX0yhaNnUKDtZ/5tjxw6qkLJ8kof+gcjE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jOILQEfCnUdiAKBWaYwNuKkkUSrjkQlC32jy7vCY0XCmFFdqo9YD2KfXwfds+cEKB
	 AxTZLYFZIRZxnfdcoH8aSpeakRsSXVV6mS/YVrls/BO2RriaIXhnMPrJq9c2203JXQ
	 UVnuzuJ5VfEZNcVHTqzBiUFdV3bpn7ZiNZysOmpBXSc2EREURtzdoknayGK5qNZTL8
	 WgwWBowr8L5QmIpAS8l933C8+idmoJhOOWpAWBdfZqMpIcN/1y/VxdX7oZwr1OuEsY
	 M4nF5rypL2ZkloeuA1Y1lHrBtNh9QrgqN3msKtXtX7Hod0htK2Rr1ZXcsH3RrxnoSQ
	 lqB1aX4bWH2kQ==
Subject:
 Re: [PATCH mptcp-next v8 6/7] selftests: mptcp: connect: add zerocopy io mode
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 24 Nov 2026 23:30:43 +0000
Message-ID: <179556304397.3133.5986898017753720348@kernel.org>
In-Reply-To: <9d10433a1bc453357a5994906ff3029f0e1f76a1.1795421388.git.tanggeliang@kylinos.cn>
References: <9d10433a1bc453357a5994906ff3029f0e1f76a1.1795421388.git.tanggeliang@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In tools/testing/selftests/net/mptcp/mptcp_connect.c,
  wait_for_completions_zc() does not actually check that MSG_ZEROCOPY…
- [Medium] mptcp_poll() in net/mptcp/protocol.c sets EPOLLERR only when
  READ_ONCE(sk->sk_err) is set.
- [Medium] selftests: mptcp: undersized msg_control buffer in
  drain_errqueue_zc()
- [Low] Author/Signed-off-by mismatch.
- [Low] The zerocopy mode changes how the existing -T and -S options of
  mptcp_connect behave.
- [Low] The comment in mptcp_recvmsg() (net/mptcp/protocol.c) says '/*
  MSG_ERRQUEUE is really a no-op till we support IP_RECVERR */'.

--

selftests: mptcp: connect: add zerocopy io mode

This adds a zerocopy I/O mode to the mptcp_connect selftest. The mode
enables SO_ZEROCOPY and sends the input file with sendmsg(MSG_ZEROCOPY).
It then drains completion notifications from the socket error queue,
polling up to a timeout.

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the Author line uses geliang@kernel.org and the only
Signed-off-by uses tanggeliang@kylinos.cn. checkpatch.pl reports this as
FROM_SIGN_OFF_MISMATCH.

Could the From: address be changed, or a matching Signed-off-by be added?

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index 178d98d91fea2..b93c73c5a2016 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c

[ ... ]

> @@ -1000,6 +1002,180 @@ static int copyfd_io_splice(int infd, int peerfd, int outfd, unsigned int size,
>  	return err;
>  }
>  
> +static bool process_cmsg_zc(struct msghdr *errmsg)
> +{

[ ... ]

> +		serr = (struct sock_extended_err *)CMSG_DATA(cm);
> +		if (serr->ee_origin == SO_EE_ORIGIN_ZEROCOPY)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool drain_errqueue_zc(int peerfd)
> +{

[ ... ]

> +	while (!found) {
> +		errmsg.msg_controllen = ctl_len;
> +		if (recvmsg(peerfd, &errmsg, MSG_ERRQUEUE) < 0)
> +			break;
> +
> +		found = process_cmsg_zc(&errmsg);
> +	}

[Severity: Low]
This loop depends on recvmsg(MSG_ERRQUEUE) returning zerocopy completions
on an MPTCP socket. However, mptcp_recvmsg() in net/mptcp/protocol.c still
says:

    /* MSG_ERRQUEUE is really a no-op till we support IP_RECVERR */
    if (unlikely(flags & MSG_ERRQUEUE))
        return inet_recv_error(sk, msg, len);

The earlier patch in this series, "mptcp: add MSG_ZEROCOPY support", makes
__msg_zerocopy_callback() queue notifications on msk->sk_error_queue, so
this path is no longer a no-op.

Should that comment be updated as part of the series?

> +
> +	free(ctl);
> +	return found;
> +}
> +
> +static void wait_for_completions_zc(int peerfd)
> +{
> +	struct pollfd pfd = { .fd = peerfd, .events = POLLERR };
> +	struct timespec start, now;
> +	int timeout_ms = 5000;
> +
> +	if (cfg_time > 0)
> +		timeout_ms = cfg_time;

[Severity: Low]
Is -T meant to double as the completion wait timeout? It is documented as
the expected runtime of the whole transfer.

With -T, a late completion can use up the whole budget, and copyfd_io()
then fails with "transfer slower than expected". Without -T, the same case
passes silently after 5000 ms.

do_sendmsg_zc() also waits whenever size > 0, even when sendmsg() failed
and nothing was queued:

    if (size > 0)
        wait_for_completions_zc(peerfd);

In that case mptcp_sendmsg() calls net_zcopy_put_abort(), uarg->len drops
to 0, and __msg_zerocopy_callback() skips the notification:

    if (!uarg->len || sock_flag(sk, SOCK_DEAD))
        goto release;

As a result, the error path always stalls for the full timeout.

Separately, copyfd_io_zc() always does:

    set_sndbuf(peerfd, size * 2);

This overrides any -S value already applied through
"if (cfg_sndbuf) set_sndbuf(fd, cfg_sndbuf)" and locks SO_SNDBUF, so -S is
silently ignored in this mode.

Should this mode keep cfg_sndbuf when it is set?

> +
> +	clock_gettime(CLOCK_MONOTONIC, &start);
> +	for (;;) {
> +		long elapsed_ms, remaining_ms;
> +
> +		if (drain_errqueue_zc(peerfd))
> +			break;
> +
> +		clock_gettime(CLOCK_MONOTONIC, &now);
> +		elapsed_ms = (now.tv_sec - start.tv_sec) * 1000L +
> +			     (now.tv_nsec - start.tv_nsec) / 1000000L;
> +		if (elapsed_ms >= timeout_ms)
> +			break;
> +
> +		remaining_ms = timeout_ms - elapsed_ms;
> +		if (remaining_ms > 200)
> +			remaining_ms = 200;
> +		if (poll(&pfd, 1, remaining_ms) < 0)
> +			break;
> +	}
> +}

[Severity: Medium]
Will this poll() ever be woken by a zerocopy completion on an MPTCP
socket?

mptcp_poll() in net/mptcp/protocol.c sets EPOLLERR only from sk_err:

    if (READ_ONCE(sk->sk_err))
        mask |= EPOLLERR;

tcp_poll() also checks the error queue:

    if (READ_ONCE(sk->sk_err) ||
        !skb_queue_empty_lockless(&sk->sk_error_queue))
        mask |= EPOLLERR;

Since "mptcp: add MSG_ZEROCOPY support" earlier in this series,
__msg_zerocopy_callback() queues completions on msk->sk_error_queue
without setting sk_err. The poll-for-POLLERR pattern described in
Documentation/networking/msg_zerocopy.rst therefore never wakes up on
MPTCP sockets.

Here each poll() sleeps its full 200 ms cap before the next drain, which
does not happen with TCP. Because the loop drains again unconditionally,
the test also cannot catch the missing POLLERR.

Should mptcp_poll() check sk_error_queue the way tcp_poll() does?

> +
> +static int do_sendmsg_zc(int infd, int peerfd, size_t size,
> +			 struct wstate *winfo)
> +{

[ ... ]

> +	while (sent < size) {
> +		iov.iov_base = buf + sent;
> +		iov.iov_len = size - sent;
> +
> +		ret = sendmsg(peerfd, &msg, MSG_ZEROCOPY);
> +		if (ret <= 0) {
> +			if (ret < 0) {
> +				perror("sendmsg MSG_ZEROCOPY");
> +				err = 1;
> +			}
> +			break;
> +		}
> +		sent += ret;
> +	}
> +	if (sent != size)
> +		fprintf(stderr, "sendmsg short: %zu/%zu bytes queued\n",
> +			sent, size);
> +
> +	if (size > 0)
> +		wait_for_completions_zc(peerfd);
> +
> +out:
> +	free(buf);
> +	return err;
> +}

[Severity: Medium]
Does this check that the zerocopy completions actually arrived?

wait_for_completions_zc() returns void. If no notification arrives before
the timeout, do_sendmsg_zc() still returns 0 and the test passes.

When a notification does arrive, drain_errqueue_zc() stops at the first
one. process_cmsg_zc() only checks ee_origin, and nothing compares the
[ee_info, ee_data] range with the number of sendmsg(MSG_ZEROCOPY) calls
made above.

mptcp_sendmsg() allocates a new uarg for each call:

    ubuf = msg_zerocopy_realloc(sk, len, NULL, false);

A short sendmsg() return therefore produces several IDs, and only the
first is waited for. That can happen on a signal, on SO_SNDTIMEO, or on a
partial copy followed by an error.

Could a kernel regression where completions never fire, or fire only
partly, go unnoticed here? The data still arrives intact, so the test
would pass.

On the timeout or partial path, free(buf) runs while skbs or dfrags may
still reference the pinned pages. Is that safe? A later malloc(), for
example on the next -I iteration in listen mode, could reuse the memory
and overwrite data that is still in flight or queued for retransmit.

The commit message says:

    The completion notification draining uses batched polling to handle
    large transfers that may generate multiple completion events across
    different TCP segments.

The loop accepts the first event, or none at all.

Should the test track the expected ID range and fail if it is not fully
completed before the timeout?

[ ... ]

> @@ -1014,6 +1016,180 @@ static int copyfd_io_splice(int infd, int peerfd, int outfd, unsigned int size,
>  	return err;
>  }
>  
> +static bool process_cmsg_zc(struct msghdr *errmsg)
> +{
> +	struct sock_extended_err *serr;
> +	struct cmsghdr *cm;
> +
> +	for (cm = CMSG_FIRSTHDR(errmsg); cm; cm = CMSG_NXTHDR(errmsg, cm)) {
> +		if (cm->cmsg_level != SOL_IP && cm->cmsg_level != SOL_IPV6)
> +			continue;
> +		if (cm->cmsg_type != IP_RECVERR &&
> +		    cm->cmsg_type != IPV6_RECVERR)
> +			continue;
> +
> +		serr = (struct sock_extended_err *)CMSG_DATA(cm);
> +		if (serr->ee_origin == SO_EE_ORIGIN_ZEROCOPY)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool drain_errqueue_zc(int peerfd)
> +{
> +	size_t ctl_len = CMSG_SPACE(sizeof(struct sock_extended_err));
> +	struct msghdr errmsg = {};
> +	bool found = false;
> +	char *ctl;
> +
> +	ctl = malloc(ctl_len);
> +	if (!ctl) {
> +		perror("malloc ctl");
> +		return false;
> +	}
> +
> +	errmsg.msg_control = ctl;
> +
> +	while (!found) {
> +		errmsg.msg_controllen = ctl_len;
> +		if (recvmsg(peerfd, &errmsg, MSG_ERRQUEUE) < 0)
> +			break;
> +
> +		found = process_cmsg_zc(&errmsg);
> +	}
> +
> +	free(ctl);
> +	return found;
> +}
> +
> +static void wait_for_completions_zc(int peerfd)
> +{
> +	struct pollfd pfd = { .fd = peerfd, .events = POLLERR };
> +	struct timespec start, now;
> +	int timeout_ms = 5000;
> +
> +	if (cfg_time > 0)
> +		timeout_ms = cfg_time;
> +
> +	clock_gettime(CLOCK_MONOTONIC, &start);
> +	for (;;) {
> +		long elapsed_ms, remaining_ms;
> +
> +		if (drain_errqueue_zc(peerfd))
> +			break;
> +
> +		clock_gettime(CLOCK_MONOTONIC, &now);
> +		elapsed_ms = (now.tv_sec - start.tv_sec) * 1000L +
> +			     (now.tv_nsec - start.tv_nsec) / 1000000L;
> +		if (elapsed_ms >= timeout_ms)
> +			break;
> +
> +		remaining_ms = timeout_ms - elapsed_ms;
> +		if (remaining_ms > 200)
> +			remaining_ms = 200;
> +		if (poll(&pfd, 1, remaining_ms) < 0)
> +			break;
> +	}
> +}
> +
> +static int do_sendmsg_zc(int infd, int peerfd, size_t size,
> +			 struct wstate *winfo)
> +{
> +	struct iovec iov = {};
> +	struct msghdr msg = {
> +		.msg_iov = &iov,
> +		.msg_iovlen = 1,
> +	};
> +	size_t sent = 0;
> +	ssize_t ret;
> +	void *buf;
> +	int err;
> +
> +	err = spool_buf(peerfd, winfo);
> +	if (err)
> +		return err;
> +
> +	buf = malloc(size);
> +	if (!buf) {
> +		perror("malloc");
> +		return 1;
> +	}
> +
> +	if (read(infd, buf, size) != (ssize_t)size) {
> +		perror("read input");
> +		err = 1;
> +		goto out;
> +	}
> +
> +	while (sent < size) {
> +		iov.iov_base = buf + sent;
> +		iov.iov_len = size - sent;
> +
> +		ret = sendmsg(peerfd, &msg, MSG_ZEROCOPY);
> +		if (ret <= 0) {
> +			if (ret < 0) {
> +				perror("sendmsg MSG_ZEROCOPY");
> +				err = 1;
> +			}
> +			break;
> +		}
> +		sent += ret;
> +	}
> +	if (sent != size)
> +		fprintf(stderr, "sendmsg short: %zu/%zu bytes queued\n",
> +			sent, size);
> +
> +	if (size > 0)
> +		wait_for_completions_zc(peerfd);
> +
> +out:
> +	free(buf);
> +	return err;
> +}
> +
> +static int copyfd_io_zc(int infd, int peerfd, int outfd, unsigned int size,
> +			bool *in_closed_after_out, struct wstate *winfo)
> +{
> +	socklen_t len;
> +	int on = 1;
> +	int err;
> +
> +	set_sndbuf(peerfd, size * 2);
> +
> +	len = sizeof(on);
> +	if (setsockopt(peerfd, SOL_SOCKET, SO_ZEROCOPY, &on, len)) {
> +		perror("setsockopt SO_ZEROCOPY");
> +		return 1;
> +	}
> +
> +	on = -1;
> +	if (getsockopt(peerfd, SOL_SOCKET, SO_ZEROCOPY, &on, &len) ||
> +	    on != 1) {
> +		perror("getsockopt SO_ZEROCOPY");
> +		return 1;
> +	}
> +
> +	if (listen_mode) {
> +		err = do_recvfile(peerfd, outfd);
> +		if (err)
> +			return err;
> +
> +		err = do_sendmsg_zc(infd, peerfd, size, winfo);
> +	} else {
> +		err = do_sendmsg_zc(infd, peerfd, size, winfo);
> +		if (err)
> +			return err;
> +
> +		shut_wr(peerfd);
> +
> +		err = do_recvfile(peerfd, outfd);
> +		*in_closed_after_out = true;
> +	}
> +
> +	return err;
> +}
> +
>  static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, struct wstate *winfo)
>  {
>  	bool in_closed_after_out = false;

[Severity: Medium]
Is ctl_len big enough for what ip_recv_error() and ipv6_recv_error()
write into the control buffer?

Both emit IP_RECVERR/IPV6_RECVERR with a payload made of struct
sock_extended_err followed by the offender address, either struct
sockaddr_in or struct sockaddr_in6. On 64-bit that is a CMSG_LEN() of
48 or 60 bytes. CMSG_SPACE(sizeof(struct sock_extended_err)) is only
32 bytes.

As a result, put_cmsg() sets MSG_CTRUNC on every MSG_ERRQUEUE read
here. The sock_extended_err part survives the truncation, so the plain
case works, but only by accident.

The problem gets worse when timestamps are enabled. Both
ip_recv_error() and ipv6_recv_error() call sock_recv_timestamp()
before put_cmsg().

With -c TIMESTAMPNS, apply_cmsg_types() enables SO_TIMESTAMPNS_NEW.
The 32-byte timestamp cmsg then fills the whole buffer and leaves
msg_controllen at 0. put_cmsg() drops the IP_RECVERR cmsg entirely,
but the error queue skb is still consumed.

process_cmsg_zc() never sees SO_EE_ORIGIN_ZEROCOPY, so the
notification is lost. wait_for_completions_zc() then keeps polling
until the timeout, and the test still passes.

Should the buffer be sized for the full errhdr with a sockaddr_in6,
plus room for any timestamp cmsgs? A fixed array with headroom, like
the control buffer in do_recv_completion() in
tools/testing/selftests/net/msg_zerocopy.c, would do.

Checking MSG_CTRUNC in errmsg.msg_flags would also make this kind of
truncation visible instead of silently losing completions.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795421388.git.tanggeliang%40kylinos.cn
