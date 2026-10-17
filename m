Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB113AB288
	for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 21:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792271238; cv=none; b=HZ67ST6NSPqrpdB3qpQO8ewSqcR/DYUdG7ES3dI54zpiGy7aEBtgKFfUz72flFzIXQmX4LZOXQK9Cr9Ye3DOMrN1sqy8L1VarJD27cXLLW/jnXOZiTDHyLPGBh9aFesDH6+Yt9IXp2+w+ii0faRasELlWZUnw/fZL+q+PDdcJXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792271238; c=relaxed/simple;
	bh=/cFvYLS8+mcejx5oDVkmMc/80+IXmHV3QbfJIdA88Yg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NsvWNs2hHiFhtIjb5oICqSON2j5RBJhDKW1D1aTk2YooFlWiGFXWaAXLCRId++9lHL76HrJBiNOo8rQZKeen+SGtaHWLtsY3nKkJxL/V2donKX3XIFn6Mg5ayYBTyUCyVPk8Hg480jiAAMYrt+VZ47h2Z5fLmXBd4DNYP1BFt3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLVMZiJJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLVMZiJJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D021F000C4;
	Sat, 17 Oct 2026 21:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792271236;
	bh=BfsqYIUNf/gNTFEB2kHVozB2AzxyGkoWkWoq3oFIzRU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YLVMZiJJlOwj7Tzf0c78e2dBNt/lHMgxDR4ZS2p9Tnh/9DHu+G0IcEmuHDgvS+U6u
	 tTEmIEj0wJHJkkSYiRAfnq3jXhIecVaziFJfB6xRxyqHILyvpiMtCRDq+AF2wPbkNs
	 6KC24UIUIhbmYz8MeAJ0Z1tD7AqrSKLSCCNJsBNAwiBPyQR9x+/AS+T5XkCWe6hTvP
	 QSENOEsWsDfjH1nylqdZsjmLfHWm33ddtZ74GrDdAJLpEgQSWHt8P/3JbI62e1TKsg
	 zvS1/YQSFXCqBJIFlLtQYrq1WOT0gj1H4Ez5qGKJiAE+EWD62mB0WZCdVzPVAlkF5s
	 LY0C6pHXnh0Ug==
Subject: Re: [PATCH mptcp-next v4 1/3] selftests: mptcp: connect: retry
 write() on EAGAIN
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sat, 17 Oct 2026 21:07:15 +0000
Message-ID: <179227123571.3133.16573987329985425813@kernel.org>
In-Reply-To: <20261016055010.980819-2-anilkaushikwireless@gmail.com>
References: <20261016055010.980819-2-anilkaushikwireless@gmail.com>
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

- [Low] In copyfd_io_poll()
  (tools/testing/selftests/net/mptcp/mptcp_connect.c), the new comment…

--

selftests: mptcp: connect: retry write() on EAGAIN

This patch changes copyfd_io_poll() in mptcp_connect so that a write()
failing with EAGAIN no longer ends the transfer. The tool sleeps 1ms and
goes back to poll(). When a poll timeout is set, the number of retries is
capped by the poll_timeout value.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index 178d98d91fea2..b9fd0bdab7486 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c

[ ... ]

> @@ -711,6 +712,21 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
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
> +					    (poll_timeout < 0 ||
> +					     ++eagain_cnt <= poll_timeout)) {
> +						usleep(1000);
> +						continue;
> +					}

[Severity: Low]
This isn't a bug, but is the "but not forever" part of the comment
accurate in every mode?

main() turns -t 0, or any negative -t value, into poll_timeout = -1:

	case 't':
		poll_timeout = atoi(optarg) * 1000;
		if (poll_timeout <= 0)
			poll_timeout = -1;

When poll_timeout is -1, the condition above never looks at eagain_cnt.
If write() keeps returning EAGAIN while poll() keeps reporting POLLOUT,
copyfd_io_poll() loops forever with a 1ms sleep on each pass. That is
the case the comment says it guards against.

The commit message ("If a poll timeout is set, still fail after as many
retries") and the v4 note ("no limit when there is no poll timeout,
-t 0") suggest this is intended. The in-tree callers all pass
-t ${timeout_poll}, so the selftests never take this branch.

Could the comment say that the limit only applies when a poll timeout
is set?

> +
>  					/* expected reset, continue to read */
>  					if (cfg_rcv_trunc &&
>  					    (errno == ECONNRESET ||

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016055010.980819-1-anilkaushikwireless%40gmail.com
