Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415550;
	b=S9sT55gORTGnAkqqwRtCeFkw/mlhSV3C4fONTivINzqlkzZw2IebgUiDbheGt7UmsKWV
	 2RBkYkPz4zwE86dbeYBxFwDLwXj2dvUPegnVCtBnTyhLVYEASsfRT7Yq0x+3XLD/rR2Yv
	 DKEtJDINqhKkGf2VIQ5qer7P6FaZPG7II4ZeqDqcLelelUWtM3as/3KWZmSGUdVqFS2SG
	 sq6VGMnyhgrY7hABTg/Z0yY3mDCjYBB871uBg33KOB2DpONKe7H0ITZeBXPiNytUCXlmY
	 twfHYG2PF4rYbEx1VHp8a/T7i7NlSaYdhW0CS+QuGefI3doYlAevIGP56HH5auwFdSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415550;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=F/GZR6mAJ+7ZmFx5zcuDaK4Qn1RDGI3ZI/3lv7Eqers=;
	b=i3JYOqY6+QUfd/qbaqhDpcAbrcXGqyUmeOG/jGQkU0Kmnl1yz7PWVtzVBpT1eV5lq5dF
	 K5dHicm2RR58FJUpnHviQRCAv5rZ/yMWy0UUoW7wtvAzREFWc6QOZW57y1VLUTyMlYk1i
	 jjlPadFGKJEFOeHQy+hcpi2FixxpCyGqDNELukxQ4895yK4vv4nXWK5E5/9r6MhvsA0ZI
	 E+PrYkkjRR0+Bvn/Uql5BNc2WwMOR7a9IAuYr0X9YfL3AWwYhPqXYZHGe0dYepaDqP3bP
	 H2kNIX67hUpwpXPdIc567Px6h6g/0pPzlpP+LD9a7VS4dKoNYwXpuQHOIpv/7P8jtJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KykW40Nv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7806C606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 06:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KykW40Nv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCE01F000C0;
	Mon, 23 Nov 2026 06:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795415550;
	bh=F/GZR6mAJ+7ZmFx5zcuDaK4Qn1RDGI3ZI/3lv7Eqers=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KykW40NvM6RPD6d0sr6xWcVGO4ywrYPGBCP9ETWdB9b6uibAVMAzpzQM1tdp8ffzW
	 n3SwBy3ersNSZ+vGi++3rWc5SN5aQkNTl4uR7lW/pNOHiswIWmzab2c49BkUZ9oe6y
	 7W7Hh1YViEW/4fOdFA2lg3D4aRnIy3ToL2jHUA6xVX11EtVDJ2/OTfQ40DD0+g4y4d
	 7n07k/dDFGyTZZn/fz9QngUyvXpm0As8rt6X5ONFxsrLK6Wk1Hy7knovMMGJ4BadAt
	 QRSgoYdZglMSfcTPA5cBoXh1aGBINXU9dVyrjX1O1HqS47gEBkGka5qzheyEiGB35h
	 YMsPc9KW9ym9g==
Subject: Re: [PATCH mptcp-net v2 22/62] mptcp: no sf left: process pending
 MP_FASTCLOSE
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 23 Nov 2026 06:32:29 +0000
Message-ID: <179541554976.3133.9470417903882322773@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-22-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-22-00327fd1de1f@kernel.org>
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

- [Medium] The commit message describes a symptom that an earlier patch
  in this series has already removed.

--

mptcp: no sf left: process pending MP_FASTCLOSE

This patch calls mptcp_check_fastclose() in __mptcp_close_ssk() before
the MPTCP socket moves to TCP_CLOSE. That path runs when the last subflow
is closed while the socket is not in TCP_ESTABLISHED. The goal is to
handle an MP_FASTCLOSE that arrives after the worker has already run
mptcp_check_fastclose(), which is otherwise ignored once the socket is
closed.

> When the last subflow is closed while the MPTCP socket is no longer in
> the ESTABLISHED state, e.g. in CLOSE_WAIT after a DATA_FIN, the MPTCP
> socket moves to TCP_CLOSE. But this subflow could have been closed by
> a reset carrying an MP_FASTCLOSE, not processed yet: if this reset is
> received while the worker is running, after mptcp_check_fastclose(),
> and before __mptcp_close_subflow(). At the next run of the worker, the
> MPTCP socket being closed, the MP_FASTCLOSE is ignored: no error is
> reported, and SEND_SHUTDOWN is not set. With data still to be sent,
> poll() then reports EPOLLHUP, but neither EPOLLOUT, nor EPOLLERR.
>
> This issue was causing the "fastclose test" subtest from mptcp_join.sh
> to be flaky: after the DATA_FIN from the client, then its MP_FASTCLOSE,
> the server, still having data to send, was killed after the timeout,
> with its MPTCP socket closed with RCV_SHUTDOWN only (-->):

[Severity: Medium]

Is "SEND_SHUTDOWN is not set" still accurate at this point in the series?

The earlier patch "mptcp: wake up blocked senders when no sf left" already
sets it in the same branch of __mptcp_close_ssk() that this patch changes.
These are the context lines around the new mptcp_check_fastclose() call:

net/mptcp/protocol.c:__mptcp_close_ssk() {
    ...
		} else if (sk->sk_state != TCP_ESTABLISHED ||
			   msk->in_accept_queue) {
			mptcp_set_state(sk, TCP_CLOSE);
			WRITE_ONCE(sk->sk_shutdown,
				   sk->sk_shutdown | SEND_SHUTDOWN);
    ...
}

With SEND_SHUTDOWN set, mptcp_poll() reports EPOLLOUT:

		if (shutdown & SEND_SHUTDOWN)
			mask |= EPOLLOUT | EPOLLWRNORM;

The next write then gets EPIPE from mptcp_sendmsg():

	ret = -EPIPE;
	if (unlikely(READ_ONCE(sk->sk_err) || (sk->sk_shutdown & SEND_SHUTDOWN)))
		goto do_error;

Can the server in the fastclose test still time out with only the earlier
patch applied?

The server is started with "-f -1", which sets cfg_rcv_trunc. In that
case copyfd_io_poll() in mptcp_connect.c treats EPIPE as expected:

					if (cfg_rcv_trunc &&
					    (errno == ECONNRESET ||
					     errno == EPIPE)) {
						fds.events &= ~POLLOUT;
						continue;
					}

If so, the server would exit normally instead of being killed with exit
code 143. The RCV_SHUTDOWN-only state ("-->") in the quoted ss output
also seems to come from a kernel without the earlier patch.

On top of the earlier patch, the remaining change from this patch seems to
be what mptcp_check_fastclose() does for the pending MP_FASTCLOSE:

  - sk_err set to EPIPE or ECONNRESET
  - SHUTDOWN_MASK and sk_error_report()
  - the token destruction
  - the DATA_FIN and backlog handling

Could the commit message describe that effect instead? It could also
claim the flaky subtest fix only if the subtest still fails with just the
earlier patch. Both patches carry the same Fixes: 27e5ccc2d5a5 tag, so
the current wording may give stable backports the wrong idea about which
patch fixes the selftest.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f%40kernel.org
