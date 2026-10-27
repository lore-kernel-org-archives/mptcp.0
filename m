Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793145157;
	b=wxrf4OLN4rs+zbWHylOIlkAUItgplaUm4I38GaTQ9MpFFKexkZOgfaXA3KeIWnrpFQt8
	 8LeOS+EnUOj8F4QBCzAQLdaMXWcEPYowlRbnK9rXBsKi/lgFte942pU6ax62LMRuDbbp7
	 yyi9mLxSOtE2KgjEpWy8J62I09MYlI9z+9kxYQrMD+mSZBnZo6P7JZQR567YZ8HXpt2eW
	 ls9neb2B5jbYC26C9xbhq893PlAiz71AxaRsX8d+Kr6MMoYS0KdATc9kYlRj/41DfqBzG
	 2srDZ57zEYiSS6ldCbpstVFmOIIhm4XGEeVwLJ2FWXZBf3moLgOHcsbx1jMQdi9NU2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793145157;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=pUCzFosTrlyVZrZZurgD2y8USfw0mbxRoHJGlY5bk2s=;
	b=dCFhgl/FIOzyxiLikMsTB3vajGnBdiznDDbEi+7+UgJhIMpoW54MVq7L6iIIZceFXxCB
	 iSqgZZ29MhwasC1LXUDrZU8j7+N87zmBy63UpO/TOv2c3z2k3apyLNUT5gPxQLwvder8t
	 HOTF/RN7/8meLdRZSjGAyEAL0k91SMjria9t+Wnmn30SQBPm7xOVvY341Rtdhg229xfNp
	 kRn0zXygZseASgvbs+5XFfUKl79ufhQUrzPC9puzi4CGQVxQ4BojA/aDPqRezf0CTLpwH
	 qUMcPnnEb5/EF2pJDKQe1ybh71PDKaArSN6JX9SPjVPxwbqRV450v5vS4AvrEaE0Gmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KsEKjdI6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00973606A31A
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 23:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KsEKjdI6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879ED1F01825;
	Tue, 27 Oct 2026 23:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793145156;
	bh=pUCzFosTrlyVZrZZurgD2y8USfw0mbxRoHJGlY5bk2s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KsEKjdI67qY5UEXdLy5djB0zvIdzrJxYZZhV3xDY0KvJ34QNFwG5Xa9DtipWoxPeR
	 HOp/16bmN8scHzMmm4tserdKMUooXdOBy5PI8z8rbX8UAnC6hTiLeMWDA7lGSXtpPv
	 7SY44DGJsIEm94zmY0JYZwRzxVoIhYGYi+a/ivqkqcDHrq8/0N5Iz9VEWSWWjz3Tbv
	 rEOn9Z2mD4i/mMe/VWD3YtQvm2yY3/XWzT3SYMLJguZwQghB1P3d71riWQNqm4R7ff
	 7/J/Ey/JvsMkCwZMafIS8bkKtlQ5HrecMIGcCVO//XMN21RyT4Z0D3iDMH4/jsUoUA
	 aW42LRSBHzTuA==
Subject: Re: [PATCH mptcp-next v3] selftests: mptcp: sockopt: echo until EOF
 on partial reads
From: netdev-bot+sashiko@kernel.org
To: quanyeyang@proton.me
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, kuba@kernel.org
Date: Tue, 27 Oct 2026 23:52:35 +0000
Message-ID: <179314515592.3132.10881107486581218854@kernel.org>
In-Reply-To: <20261026-fix-mptcp-issue-639-v3-1-165485982827@proton.me>
References: <20261026-fix-mptcp-issue-639-v3-1-165485982827@proton.me>
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

- [Medium] The commit message gives the wrong cause for the failure it
  fixes.

--

selftests: mptcp: sockopt: echo until EOF on partial reads

This commit changes process_one_client() in mptcp_sockopt.c to echo data
in a loop until read() returns 0 and to retry short writes. The totals
are kept in nread/nwritten for the existing sockopt checks. Those totals
are also cast to uint64_t for the PRIu64 format strings.

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
Can a short read in the old process_one_client() actually cause this
hang?

connect_one_server() sends all len bytes with a single write(). len is
at most 4094, so it fits in the server's 4096 byte buffer, and a short
write is treated as an error:

	ret = write(fd, buf, len);
	if (ret < 0)
		die_perror("write");

	if (ret != (ssize_t)len)
		xerror("short write");

So if the server's first read() returns fewer than len bytes, the rest
of the payload is already queued for the server. In that case the old
1-byte "wait for hangup" read would return 1 instead of blocking:

	/* wait for hangup */
	ret3 = read(fd, buf, 1);
	if (ret3 != 0)
		xerror("expected EOF, got %lu", ret3);

The server would then exit through xerror(), and the client's read loop
in connect_one_server() would hit "unexpected EOF" or a reset. That is a
fast failure, not a hang until SIGALRM.

In the old code, the only way to reach the mutual wait described here
seems to be a short echo write. In that wait, the client is still
expecting bytes and the server is blocked in the 1-byte read. ret2 was
only checked for a negative value:

	ret2 = write(fd, buf, ret);
	if (ret2 < 0)
		die_perror("write");

The new loop handles both the short read and the short write, so the
code change itself looks fine.

Could the commit message be updated to describe the actual cause of the
hang?

Also, the hang in issue 639 might have had a different cause, such as
the unchecked short write or a stall on the receive side. If so, does
the explanation as written still support the Closes: and Fixes: tags?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026-fix-mptcp-issue-639-v3-1-165485982827%40proton.me
