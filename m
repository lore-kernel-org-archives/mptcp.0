Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794963945;
	b=dUg2EsG0idj7/DzgCh35okiC+JuK4ougqsMu3ddE/soujWV3KqejpOrQtn6TYPtaGnxp
	 AayTsqRuEFGvmqt2N8v4JpYMbQ5wmgi40JfcO5FkCNBhjfqMXUw5MCxXLlhPBXsf3ulO4
	 7pNVZAOg+N0L83avznlaDkUQFfgcOq4/rJIi1VufGRRlq+BSwH1+XD29FwDiwxxiVcMeO
	 ZQq4U/h5CWcODvM3ImA6DxESz/+S1l2yItWnfwjLhaHV179Y3PAdjEzNWMX1H0NNOa/7u
	 Dx2FAAru+YlCEjk44fW+0siDJ2DD4+M2ZGy6GGvWPFBIcM7jeP6ZvEfoANGzo95yvaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794963945;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=v2nkuwYn3oiD2moq5FQ88PmPLHInWp97rg6w6Mq3hZw=;
	b=gqJMetXDCM2Q5axcdcy/kHLbOJJ+bbBRUDsc+/XqJb+THrIm4bZPkaZKxOpyPSqPmQCT
	 vjUszDoc3zQBeQtzu/vlJhW5N2X2yLXQCuAyE9jkaIlvqTpwymV3xnGfXT4HIGz5cKXSU
	 1wC82cn9Ck+jKbmMTcHnGD7NWFr+7J1f6GCXjKrDTwxYj0EUwqvFQuUDtZxiLTz+akgBD
	 E80+dHMhP5HR3Yv8G4hUFPdJ7QH4WaDtEk9bAyGGBeMyXnNWiKLpjoq1hVsC9nKzuGE9e
	 vV/c07kyUxTvTtAZgwt3bpU4D3s/vBTK9hUTyR7Nrn5XyTTMPG5jeneychaYlwnnpUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L0lshEBh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36B5606A31C
	for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 01:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L0lshEBh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CC81F000C7;
	Wed, 18 Nov 2026 01:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794963945;
	bh=v2nkuwYn3oiD2moq5FQ88PmPLHInWp97rg6w6Mq3hZw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=L0lshEBheFKKk1//y3TXfYt3DY7N3eL4ZSfH1V2HHmdT6BexkhtvGUj/+2n+ljZLK
	 jtCdroZaJwkPtDqBRHeKFZJaltdgY/M4j4ZvnDMsOHq+LY7dXBhsDw7i3TpvQipIm4
	 wprje2NGNVo/IcDHC8MF7Uyd0b4FoUAYqA3GayB5QIKgn+cmO/yAiNqVgIMzGXdeYR
	 b9RLeXF3ChnmGEM4+m8G6Q0WjZ1R2l4oXYG9glC6jyjlN2Wjs35jSOIYbu+7Tz/NFC
	 6Sa8+kabID+6UiGqSu3V+9Cx2u5LdUPfqUctbcuilakAsESK5JipX0p6/UYiFegk4C
	 VK0rGq0KH1KYg==
Subject: Re: [PATCH mptcp-next v8 2/7] selftests: mptcp: connect: check TFO
 SIOCINQ overflow
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Wed, 18 Nov 2026 01:05:44 +0000
Message-ID: <179496394474.3133.5669457989174147035@kernel.org>
In-Reply-To: <297fb247e71d06c3c496de844410be5dd0dd1fd0.1794826541.git.geliang@kernel.org>
References: <297fb247e71d06c3c496de844410be5dd0dd1fd0.1794826541.git.geliang@kernel.org>
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

- [Medium] The commit message says that when waiting for the remote key
  times out, the test skips the SIOCINQ check instead of failing.
- [Low] The commit message for "selftests: mptcp: connect: check TFO
  SIOCINQ overflow" does not mention the kernel fix this test checks for.

--

selftests: mptcp: connect: check TFO SIOCINQ overflow

This commit adds a SIOCINQ check to mptcp_connect's server mode when
MPTFO is enabled. The server polls until MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED
is set, with a limit of poll_timeout. It then fails the test if SIOCINQ
returns INT_MAX.

> Wait for MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED using poll() bounded by
> poll_timeout, then check if SIOCINQ returns INT_MAX. Use poll() instead
> of usleep() to detect dead connections via POLLHUP/POLLERR. Add SOL_MPTCP
> fallback definition and handle ENOPROTOOPT/EOPNOTSUPP errors to skip the
> wait for TCP or fallback sockets. Skip SIOCINQ check on timeout rather
> than failing the test.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
Should this commit refer to the kernel fix it tests? The previous patch in
the series, "mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint", has:

  Fixes: f03afb3aeb9d ("mptcp: drop __mptcp_fastopen_gen_msk_ackseq()")

This patch has no Fixes: tag and does not mention that fix.

The new check in main_loop_s() will report "TFO SIOCINQ overflow" on any
kernel that has f03afb3aeb9d but not the fix. Stable maintainers would
need to know that the two patches go together.

Also, the sentence "Use poll() instead of usleep() to detect dead
connections via POLLHUP/POLLERR" reads like a changelog from an earlier
version. This patch does not replace any usleep() based wait. Should that
text go below the --- line?

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index 178d98d91fea2..143d8177b5a33 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c

[ ... ]

> @@ -1176,6 +1180,48 @@ static void maybe_close(int fd)
>  		close(fd);
>  }
>  
> +static int wait_for_remote_key(int fd)
> +{
> +	struct mptcp_info info;
> +	int timeout_ms = 10;
> +	struct pollfd pfd;
> +	int elapsed = 0;
> +	socklen_t olen;
> +	int ret;
> +
> +	pfd.fd = fd;
> +	pfd.events = 0;
> +
> +	while (elapsed < poll_timeout || poll_timeout < 0) {
> +		ret = poll(&pfd, 1, timeout_ms);

[ ... ]

> +		if (info.mptcpi_flags & MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED)
> +			return 0;
> +
> +		elapsed += timeout_ms;
> +	}
> +	fprintf(stderr,
> +		"TFO: timeout waiting for remote key, skip SIOCINQ check\n");
> +	return 1;
> +}

[Severity: Medium]
Can this timeout path really skip the SIOCINQ check, as the commit message
says?

The loop in wait_for_remote_key() is limited by the global poll_timeout.
The client uses the same idle timeout in copyfd_io_poll():

tools/testing/selftests/net/mptcp/mptcp_connect.c:copyfd_io_poll() {
    ...
		switch (poll(&fds, 1, poll_timeout)) {
		...
		case 0:
			fprintf(stderr, "%s: poll timed out (events: "
				"POLLIN %u, POLLOUT %u)\n", __func__,
				fds.events & POLLIN, fds.events & POLLOUT);
			return 2;
		}
    ...
}

main_loop_s() calls wait_for_remote_key() after accept() and before
copyfd_io(). The server does not read or write while it waits.
mptcp_connect.sh starts both sides with -t ${timeout_poll}, which is 30
seconds.

Each iteration counts 10 ms in elapsed, but the poll() and getsockopt()
calls take at least that long. The real wait is therefore longer than
poll_timeout.

Suppose a non-fallback MPTCP socket never gets the remote key. By then the
client has filled the socket buffers or called shut_wr(), and it sees no
more poll events. Won't the client hit its own poll timeout at about the
same time, usually first, and exit with 2? do_transfer() would then report
a failure with "client exit code 2".

That turns the skip into a 30 second stall followed by a client failure
that depends on timing. Would a separate, much shorter limit for the
remote key wait give the intended behavior?

With -t 0 (poll_timeout == -1) this loop never ends. That matches what
-t 0 does for the other polls in the tool.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794826541.git.geliang%40kernel.org
