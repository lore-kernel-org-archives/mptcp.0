Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8151F7260D
	for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 01:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792199966; cv=none; b=ZXywRWjhg3Jg1MOFsmgE5M7Z0aDj1euJaABGQHT7MlIpcaP/AFp4O+2rvfEeJf/JNXPvykVhfrYSI0G5vvQ1u9UkVq3TjxEsl5x0x+y2vt60NpNoyu19w4DJjGakqBvgV1dhzF8sqxork2PmZqlZwgV8GRazHqdQ5/44bqaUCAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792199966; c=relaxed/simple;
	bh=ffrMVfDlzOztloGEZvefHddlXwC21DAAzidflSVEOVg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W1XbbasTq0kNPkVmCoERXg6gSWVtWUpswdxmfsUN0OP9t+NCXBHdYLHerMaOoTduu1OyEv26zKIMfJfMnbtGvbkpzD8qpH2t3bOrQ/rHpWn+IQJwteetWvgagDV+rd4BcT6W5PxTGqPMkaoBoXExWh8UZyTISPQpSwzSQBWJdsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTmZFWfj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTmZFWfj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88AC1F000C4;
	Sat, 17 Oct 2026 01:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792199965;
	bh=jgFqvLl7mL88E3xCmp+9jgLXD2wChUDd9vaQu+uNPTc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JTmZFWfjZmchepLNBoJxfj6ewATRV5+Nl59NFVlzLB/R0JvOdF1uf4wM5tZ79cYZ+
	 8fIcP4k0MdTCQdG8NEpPwfmzq/1ksv4wtZZia/Hw7pXz71H9d51yKHHsSr2a97MXjI
	 QCyGkBXA2hBST+ZfMq1lZtqm46a6Qm3LsjKgfaNK3mePlMBhbRrmBsLdhOSO4ceK5z
	 HBMr74BUsM+PrBQD8VS5YUYuQEo4PpBe8SqxjnI69tIwOMC4pgnB7j7TEVHhGMe+Ut
	 D1EwaU7tF+tVTDFIQl6AqMR/XJyp5vHRsAnMUF+lf3ToytMpU317PnhRmce+OXV1OU
	 X39Z7aMhVdJQA==
Subject: Re: [PATCH mptcp-net] selftests: mptcp: sockopt: pass total bytes to
 do_getsockopts
From: netdev-bot+sashiko@kernel.org
To: quanyeyang@proton.me
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sat, 17 Oct 2026 01:19:24 +0000
Message-ID: <179219996445.3135.17949387714487378147@kernel.org>
In-Reply-To: <20261015-fix-mptcp-issue-638-v1-1-5de999ad601c@proton.me>
References: <20261015-fix-mptcp-issue-638-v1-1-5de999ad601c@proton.me>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message describes a failure path that the old code
  cannot reach.

--

selftests: mptcp: sockopt: pass total bytes to do_getsockopts

This changes connect_one_server() in the mptcp_sockopt selftest so it
passes the total number of echoed bytes to do_getsockopts(). Before, it
passed the return value of the last read() call. The commit message
says the partial value made do_getsockopt_tcp_info() time out.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/638

> do_getsockopt_tcp_info() then compared the subflow TCP counters
> against that partial size, polled until timeout, and failed the
> test. Use the total instead.
>
> Fixes: ce9979129a0b ("selftests: mptcp: add mptcp getsockopt test cases")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/638

[Severity: Medium]
Is this the failure the old code actually hits? In
tools/testing/selftests/net/mptcp/mptcp_sockopt.c, do_getsockopts()
runs the MPTCP_INFO check before the TCP_INFO polling:

static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
{
	do_getsockopt_mptcp_info(s, fd, w);

	do_getsockopt_tcp_info(s, fd, r, w);
	...
}

do_getsockopt_mptcp_info() then asserts on w:

	assert(s->mi.mptcpi_write_seq + w == i.mptcpi_write_seq);

s->mi is saved by the first do_getsockopts(&s, fd, 0, 0) call, which
runs before the write. Once write(fd, buf, len) returns len,
mptcp_sendmsg() has moved msk->write_seq forward by len, and
mptcpi_write_seq reports that value. The client only sends DATA_FIN at
close(), which comes later.

Take the old code with a split echo, where the last ret is less than
len. Doesn't this assert fail and abort the process inside
do_getsockopt_mptcp_info()? If so, the code never reaches the sleep(1)
retry loop or the "tcpi_bytes_sent ..., want ..." xerror() in
do_getsockopt_tcp_info(). The selftest Makefile does not define NDEBUG,
so the assert is active.

The code change itself looks correct. With total == len, both the
write_seq assert and the tcp_info counter checks pass.

Could the commit message describe the assert failure in
do_getsockopt_mptcp_info() instead?

Is the Closes: tag also accurate? Suppose issue 638 reports the
timeout xerror() from do_getsockopt_tcp_info(). Then the mptcp_info
assert must already have passed, which means w == r == len. A partial
read would not be the cause, and this patch would not fix that issue.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-fix-mptcp-issue-638-v1-1-5de999ad601c%40proton.me
