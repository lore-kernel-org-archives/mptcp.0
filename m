Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4648B1CFA2
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 00:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792368946; cv=none; b=Q0v99WM1odFtQDtFqB6/5yLtsuJbWgIssjBOV+PMBs2Bk/aGuRYXhaf9YmWCAp4afCdoztMdnKQMe8MQYVLiKv8HtDWo0B6YAlyKR/TZ2vM6ZDVbhOXnC2mSslAIXZ4ULU6exhMV2yOYirD7ZGozUoMQTVp8U3l26FG4ww0g208=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792368946; c=relaxed/simple;
	bh=W3XNDta7Jo/XuzL2rnxfqP23pYm6nOfYXCh17GpJonM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mI/PRXEfwB1HqnKxOjx3sqxCMpaMCgYboWBJSCUEQyGHu12I5E+8TDTqC8d2LQMe0s4p/JO/IwZ4H4gBTiJcpBGfhO5MKq6WZgQu6jGntlHG3rRFMmJTtLD2+O6Fa8IT1uBKeU2C+EiPPD3WSlI/agRQzLxEW472HRgN7I+9y1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4MV80cT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4MV80cT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92391F000C4;
	Mon, 19 Oct 2026 00:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792368945;
	bh=LjqTt6X5ta9rS1ebh3shhi+z0DaKgNCSSJfWC4UHy9o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=n4MV80cTL9jSJ7a7SKG2j7EhZfSNY5okPltejNJiIFNcYy/7GQhtPWJrXROf5kEno
	 tiX0ui3Gplzh8Jr3Bv29AYos+6Sm1AFqrR+bPonECnpVKEcJZbcSfshSDc0vKMNx8t
	 YwXR9zF7gQaqudGLlmU9JlOwzeB4S9BmYNMrSVj4hr6kUzCv9ynaK+l34y6Z8FavzO
	 2UGxA7K78Q+J0L53bqeRFMoGGiSjpLwBR/03bO6fOmkryajbc/xnXkKjwPEO2SyFzT
	 RbNIdC0bw0HJxIzEyyxeK/aKLefDMiAZDW2L/jQVXG11HRzBWYnaVi52//m+bAt8lT
	 u6iQOIhKIejBA==
Subject: Re: [PATCH mptcp-net] selftests: mptcp: sockopt: echo until EOF on
 partial reads
From: netdev-bot+sashiko@kernel.org
To: quanyeyang@proton.me
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 19 Oct 2026 00:15:44 +0000
Message-ID: <179236894433.3133.2023724514413325674@kernel.org>
In-Reply-To: <20261017-fix-mptcp-issue-639-v1-1-0554d07ab8f8@proton.me>
References: <20261017-fix-mptcp-issue-639-v1-1-0554d07ab8f8@proton.me>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete: the segmented-payload case still fails.
- [Medium] The commit message describes a failure the old code could not
  produce.

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but the xerror()
  calls in process_one_client() pass `ssize_t` values (`ret + 1`,…

--

selftests: mptcp: sockopt: echo until EOF on partial reads

This commit changes process_one_client() in the mptcp_sockopt selftest.
The old code did a single read() and write(), then a one-byte read to wait
for hangup. The new code loops on read()/write() until EOF and passes the
accumulated byte counts to the existing sockopt checks.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/639

> process_one_client() used a single read() and write() before waiting
> for hangup. A SOCK_STREAM read() can return a short count when the
> payload is segmented, so the server echoed only part of the data and
> then blocked on FIN.
>
> The client keeps reading until it has the full length and only then
> closes the socket. The two sides wait on each other and the test
> hangs until SIGALRM.

[Severity: Medium]
Is this description of the old behavior accurate?

In the old process_one_client(), the server did this after a short first
read and the partial echo:

	/* wait for hangup */
	ret3 = read(fd, buf, 1);
	if (ret3 != 0)
		xerror("expected EOF, got %lu", ret3);

By then connect_one_server() has already written all len bytes, since it
calls xerror() on a short write. So the remaining bytes reach the server,
read(fd, buf, 1) returns 1, and the server exits through xerror().

The server is a separate forked process. When it exits, its socket is
closed and the client's blocked read() returns. That is a quick failure,
not both sides waiting on each other until the alarm fires.

The old read(fd, buf, 1) could only block forever if the rest of the data
never arrived. In that case the new read() loop would block in the same
way.

If issue #639 really shows a timeout, is the root cause somewhere else?
If not, could the commit message describe the failure as the "expected
EOF" error instead of a hang?

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> index b6e58d936ebe5..5e1ec33368590 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c

[ ... ]

> @@ -648,23 +648,27 @@ static void process_one_client(int fd, int pipefd)
>  	ret = write(pipefd, "xmit", 4);
>  	assert(ret == 4);
>  
> -	ret = read(fd, buf, sizeof(buf));
> -	if (ret < 0)
> -		die_perror("read");
> +	ret = 0;
> +	ret2 = 0;
> +	while ((n = read(fd, buf, sizeof(buf))) > 0) {
> +		if (!ret) {
> +			assert(s.mptcpi_rcv_delta <= (uint64_t)n);
>  
> -	assert(s.mptcpi_rcv_delta <= (uint64_t)ret);
> -
> -	if (s.tcpi_rcv_delta)
> -		assert(s.tcpi_rcv_delta == (uint64_t)ret);
> +			if (s.tcpi_rcv_delta)
> +				assert(s.tcpi_rcv_delta <= (uint64_t)n);
> +		}
>  
> -	ret2 = write(fd, buf, ret);
> -	if (ret2 < 0)
> -		die_perror("write");
> +		w = write(fd, buf, n);
> +		if (w < 0)
> +			die_perror("write");
> +		if (w != n)
> +			xerror("short write");

[Severity: High]
When the payload is segmented, the server now sends the echo as several
write() calls. Can the client still fail in connect_one_server() in that
case?

The client read loop adds up total, but then passes ret, which holds only
the size of the last read() chunk:

	total = 0;
	do {
		ret = read(fd, buf2 + total, sizeof(buf2) - total);
		...
		total += ret;
	} while (total < len);
	...
	do_getsockopts(&s, fd, ret, ret);

For a plain read(), mptcp_recvmsg() uses a sock_rcvlowat() target of 1.
So if the echo arrives as n1 and then n2, the client can return n1
without waiting for n2. That leaves ret equal to n2, which is less than
len.

do_getsockopt_mptcp_info() then checks:

	assert(s->mi.mptcpi_write_seq + w == i.mptcpi_write_seq);

Here w is n2 but write_seq has advanced by len, so the client aborts.

Without that assert, do_getsockopt_tcp_info() would still fail. It
compares tcpi_bytes_sent and tcpi_bytes_received (both len) against n2,
never matches, and ends in xerror() after the retries.

Before this patch the echo was a single write(), so ret == len usually
held. Should connect_one_server() pass total (or len) to do_getsockopts()
as part of this fix?

>  
> -	/* wait for hangup */
> -	ret3 = read(fd, buf, 1);
> -	if (ret3 != 0)
> -		xerror("expected EOF, got %lu", ret3);
> +		ret += n;
> +		ret2 += w;
> +	}
> +	if (n < 0)
> +		die_perror("read");
>  
>  	do_getsockopts(&s, fd, ret, ret2);
>  	if (s.mptcpi_rcv_delta != (uint64_t)ret + 1)

[Severity: Low]
This is a pre-existing issue, not one introduced by this patch. The
xerror() calls that follow pass ssize_t values to PRIu64 conversions:

		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64 ", diff %" PRId64,
		       s.mptcpi_rcv_delta, ret + 1, s.mptcpi_rcv_delta - (ret + 1));

ret2 and ret are passed the same way in the mptcpi_bytes_sent,
mptcpi_bytes_received and mptcpi_bytes_acked messages.

On 32-bit builds ssize_t is 32 bits, so will these messages print
garbage values? The declaration of ret and ret2 is being rewritten
anyway. Could they be cast to uint64_t in these calls, or declared with a
64-bit type?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261017-fix-mptcp-issue-639-v1-1-0554d07ab8f8%40proton.me
