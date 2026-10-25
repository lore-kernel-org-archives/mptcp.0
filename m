Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792899657;
	b=o2oOqjmDOr1ARMHmbHPUAwJVjKFvsBl3Lwo+eJHbNYZPluY7CgcgUKgR9TtkDzPA1gay
	 ZuUkcs5SBIWobXsHv5cv/1I7UojxWqDpMc/peWXVtjOMMqINlLZp6FUOkZcgtceUR8Q8S
	 cocpg8f6dlt6jqcJJ/iuT67C4/TzK4n6VVpSpN8D6X0o05dU6bIpzTYNTtT1bGfj92G0L
	 0BqTJv2Fr4rlftUG/iwLbcW7EWjhuQFZ99s3XDcainwNHtGp/4p3wubMnAx601D+jOLhC
	 CCnrgcoXFadg7Qh3NHbjGReFrOQ07le8Fv1rHNESifJonN/hMkyB+Bhnuie4Me/M6bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792899657;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=+LsZfoj0hgxigZs766yoV7Yxz48rmom0RCG/r6XILPw=;
	b=X20FRJLK373lvAIj/ZqInQ6hUeWqwKoKwx95bMppbYZLzPa/FK8aPsQroTP5lyKwdgZL
	 z6KsFEk89JDFiWqLtheTDFRANf3jcI8vUP5DOcf36Sshdo7C2EM3Hq/gf4/4F1+gO+asB
	 ySuk1m2Cfmj9EXR/4D4RKkbKaRFQE51sWZRr5V1DJtr80S7i9ABtgMMEzFxEo8o1pB0h7
	 dlZqk3BR3ClrtAP2YPYhoLuYycbLpeAKXM6KC7y02e99NHR/CMvIM4/LZoWIxntoF0jec
	 YgA+QU0YM0jNvIWr+ZbRiNhPZX2yeNHQ/MAJd44lyigkKFlhJB9GLWlJkiGJYPb95zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Rn3/WM6U";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD35606A31A
	for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 03:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rn3/WM6U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422DD1F01825;
	Sun, 25 Oct 2026 03:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792899656;
	bh=+LsZfoj0hgxigZs766yoV7Yxz48rmom0RCG/r6XILPw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Rn3/WM6U58trCpI2zl8DMiOJf1pbm6WcUe2/o3vBwodncOpZHIbHibbh0abIo4rN0
	 1WJ9cTaJMLpiZuRdL4rhIlb9Gi1c3zCGBZw/MueGXnijeIovXVp27PLc6etoJ7P/pz
	 mYkfVlOGEVjxQWZ0LUdIS8n8m2GMxvscaW2pdb3jbnsYzErXtzKXs5DhQB9Le+umnv
	 mb1w6mE2I3oqGN7Lg3FDgNxdRhswLl9GaK5JeFYYLyP7G/7tbpv5Ia7M03ePHIUyVC
	 vzr78F3sPnP3IoEO9FhA9Tg9uwMwOH9BC26YPwoERXzLaCNwoqAZcRJJ4+6kcogBVW
	 C2dYeYPUWAo9g==
Subject: Re: [PATCH mptcp-next v2] selftests: mptcp: sockopt: echo until EOF
 on partial reads
From: netdev-bot+sashiko@kernel.org
To: quanyeyang@proton.me
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sun, 25 Oct 2026 03:40:55 +0000
Message-ID: <179289965578.3132.14505074087260563831@kernel.org>
In-Reply-To: <20261023-fix-mptcp-issue-639-v2-1-14a3d3746d2d@proton.me>
References: <20261023-fix-mptcp-issue-639-v2-1-14a3d3746d2d@proton.me>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This is an incomplete fix: connect_one_server() on the client
  side still has the same partial-read bug that the patch fixes in…
- [Medium] The commit message's account of the pre-patch failure does not
  match the pre-patch code.
- [Low] selftests: mptcp: process_one_client() passes size_t to PRIu64 in
  xerror()

Pre-existing issues:
- [Low] The patch did not introduce this problem, but it rewrote these
  exact argument lists.

--

selftests: mptcp: sockopt: echo until EOF on partial reads

This commit changes process_one_client() in the mptcp_sockopt selftest so
the server echoes data in a loop until read() returns 0, retrying short
writes. The accumulated nread/nwritten counts replace the single read and
write sizes in the existing sockopt checks.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/639

> The client keeps reading until it has the full length and only then
> closes the socket. The two sides wait on each other and the test
> hangs until SIGALRM.

[Severity: Medium]

Does this match what the old code would do? Before this patch,
process_one_client() ran this after the partial echo:

	/* wait for hangup */
	ret3 = read(fd, buf, 1);
	if (ret3 != 0)
		xerror("expected EOF, got %lu", ret3);

The client had already queued all len bytes with one write(). Once the
remaining bytes reached the server, this read() would return 1 and the
server would exit through xerror().

That closes the socket, so the client's read() returns. Both processes
would be reaped well before alarm(15).

A mutual hang seems possible only if the remaining bytes never reach the
server's receive queue. In that case the new loop would block in the
same way here:

	n = read(fd, buf, sizeof(buf));

and the client would keep waiting for len bytes.

Could the hang reported in issue #639 have a different cause, perhaps in
the client side accounting in connect_one_server() or in the kernel? If
so, is the Closes: tag right for this patch?

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> index b6e58d936ebe5..deb239058e796 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> @@ -638,7 +638,8 @@ static void connect_one_server(int fd, int pipefd)
>  
>  static void process_one_client(int fd, int pipefd)
>  {
> -	ssize_t ret, ret2, ret3;
> +	size_t nread = 0, nwritten = 0;
> +	ssize_t ret, n, w, off;
>  	struct so_state s;
>  	char buf[4096];
>  
> @@ -648,46 +649,53 @@ static void process_one_client(int fd, int pipefd)
>  	ret = write(pipefd, "xmit", 4);
>  	assert(ret == 4);
>  
> -	ret = read(fd, buf, sizeof(buf));
> -	if (ret < 0)
> +read_more:
> +	n = read(fd, buf, sizeof(buf));
> +	if (n < 0)
>  		die_perror("read");
> +	if (n == 0)
> +		goto hangup;
> +
> +	for (off = 0; off < n; off += w) {
> +		w = write(fd, buf + off, n - off);
> +		if (w < 0)
> +			die_perror("write");
> +		if (w == 0)
> +			xerror("write returned 0");
> +	}
> +	nread += n;
> +	nwritten += n;
> +	goto read_more;

[Severity: High]

Does connect_one_server() on the client side still have the same
short-read problem? Its read loop adds the echoed bytes up in total, but
the sockopt check after it passes the size of the last read() chunk:

tools/testing/selftests/net/mptcp/mptcp_sockopt.c:connect_one_server() {
    ...
	total = 0;
	do {
		ret = read(fd, buf2 + total, sizeof(buf2) - total);
		...
		total += ret;
	} while (total < len);
    ...
	do_getsockopts(&s, fd, ret, ret);
    ...
}

With this loop, a short first read() on the server makes the echo go out
in several write() calls. The client is then likely to receive it in
more than one read(), which leaves ret holding only the final chunk.

do_getsockopt_mptcp_info() would then run this check with w smaller than
the len bytes the client wrote:

	assert(s->mi.mptcpi_write_seq + w == i.mptcpi_write_seq);

That assert fails and the client dies with SIGABRT. Without the assert,
do_getsockopt_tcp_info() compares tcpi_bytes_sent/received against w/r
and would call xerror() after its retries.

So the segmented-payload case from the commit message still looks like
it fails the test, only in a different way.

Should connect_one_server() call do_getsockopts(&s, fd, total, total)
instead? The other checks in that function already use total.

[ ... ]

>  	/* be nice when running on top of older kernel */
>  	if (s.pkt_stats_avail) {
> -		if (s.last_sample.mptcpi_bytes_sent != ret2)
> +		if (s.last_sample.mptcpi_bytes_sent != nwritten)
>  			xerror("mptcpi_bytes_sent %" PRIu64 ", expect %" PRIu64
>  			       ", diff %" PRId64,
> -			       s.last_sample.mptcpi_bytes_sent, ret2,
> -			       s.last_sample.mptcpi_bytes_sent - ret2);
> -		if (s.last_sample.mptcpi_bytes_received != ret)
> +			       s.last_sample.mptcpi_bytes_sent, nwritten,
> +			       s.last_sample.mptcpi_bytes_sent - nwritten);
> +		if (s.last_sample.mptcpi_bytes_received != nread)
>  			xerror("mptcpi_bytes_received %" PRIu64 ", expect %" PRIu64
>  			       ", diff %" PRId64,
> -			       s.last_sample.mptcpi_bytes_received, ret,
> -			       s.last_sample.mptcpi_bytes_received - ret);
> -		if (s.last_sample.mptcpi_bytes_acked != ret)
> +			       s.last_sample.mptcpi_bytes_received, nread,
> +			       s.last_sample.mptcpi_bytes_received - nread);
> +		if (s.last_sample.mptcpi_bytes_acked != nread)
>  			xerror("mptcpi_bytes_acked %" PRIu64 ", expect %" PRIu64
>  			       ", diff %" PRId64,
> -			       s.last_sample.mptcpi_bytes_acked, ret,
> -			       s.last_sample.mptcpi_bytes_acked - ret);
> +			       s.last_sample.mptcpi_bytes_acked, nread,
> +			       s.last_sample.mptcpi_bytes_acked - nread);

[Severity: Low]
nread and nwritten are declared as size_t, but these three xerror()
calls pass them straight to an "expect %" PRIu64 conversion. On 32-bit
(ILP32) builds size_t is 4 bytes while PRIu64 consumes 8. That means
vfprintf() in xerror() reads past nwritten/nread and picks up the wrong
bytes for the PRId64 diff that follows.

The diff argument itself is fine. Subtracting a size_t from a uint64_t
promotes the result to 64 bits, so only the bare nread/nwritten
argument is the wrong width.

The mptcpi_rcv_delta xerror() just above already casts with
(uint64_t)nread + 1, so the patch is not consistent here. xerror() has
no printf format attribute, so the compiler does not warn about this.

The old code had the same mismatch with ret/ret2, so this is not a new
problem. But these argument lists are being rewritten anyway, and when
one of the mptcpi_bytes_sent/received/acked checks fails on a 32-bit
machine, the expect and diff values would be garbage. That is exactly
when the output matters.

Could you either cast nwritten and nread to (uint64_t) in these calls,
or declare the two counters as uint64_t? Is it also worth adding a
format(printf, 1, 2) attribute to xerror() so the compiler catches
this kind of mismatch?

[Severity: Low]

This isn't a bug introduced by this patch, but these argument lists are
being rewritten anyway. nwritten and nread are size_t, while the format
strings use PRIu64.

The mptcpi_rcv_delta xerror() above gets a (uint64_t) cast, but these
three calls do not. xerror() has no printf format attribute, so the
compiler gives no warning.

On 32-bit builds, would the expect and diff values print as garbage when
one of these checks fails? The old code had the same mismatch with
ret/ret2.

>  	}
>  
>  	close(fd);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023-fix-mptcp-issue-639-v2-1-14a3d3746d2d%40proton.me
