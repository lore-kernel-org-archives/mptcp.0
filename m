Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794123449;
	b=nX1bAGaasWSrbpDPY/pU7w1CoFF9aVnsrcTHo68RFXIKkqvVLgK4llvNzSRQYIysTTrd
	 fkhexv1gfeJ/4kPmNzRLgBl/Pmm4QADCWvAXUmAzR4+vP59wAPpMLVZ6L96jxMBvwZFJy
	 E8LRQ+74cb4D3SPXu4sSQdehpqBiZSDd2yVoiEA6T6E3W3SYZ/8Wxntxj+zqfoRsCiw88
	 BeQFd3saAmtZ4x1kLaPePGRNreLW11ZzI55Ai/63hl6Y+7sDyFVdnSrdcG1DgN1hjv2J9
	 VXWH7yB6nziuz0Wbg37U4KqmkPlKO8/hiVGl4pNU2ic6SHYQhyzRE4XqaYdskH5WbiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794123449;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=VCU851nRWedYl9TbemrmtmTCCPajEqRMnp4vEgJIAgg=;
	b=i4rmKROxjvct2mlcRY5m6T0+kSGETtyP6auzJhcgEbHE/qcMcroaj06QiRN/NR/4VuP6
	 1+Du5Vr0d3cgF7Mo7Ltm4l18p6WklrLfZ8WmdJNfQwoQgS/mUvPc39M5/AQ4hritS7+FR
	 yHzEXFgtvRw95KJa4arNzf+xauObW/NQoPc6m7cuMPLBXsku1U5BLJJEsc3pLVcyxMvIO
	 Xmp+P5k1Lukqh/bmqhYwfZc9B/+Hpx8e6L0ymwEz3+ctgNx+Q3MWGnfW3Z03f9d08w91g
	 b9NR56ZQpiVLDWAXG219N/BOpVaut/7HQNAPgFhJViI2RbouczuAl67/V9AH7V0hClA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YUMMG8ct;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AF7606A31C
	for <mptcp@lists.linux.dev>; Sun,  8 Nov 2026 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YUMMG8ct
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B903B1F008A5;
	Sun,  8 Nov 2026 07:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794123449;
	bh=VCU851nRWedYl9TbemrmtmTCCPajEqRMnp4vEgJIAgg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YUMMG8ct+DY8+bw2SXjYHAt1tEfeX9NSQtzgLJfn/jYOOiGTHiu//ugxN6yLfvzDw
	 FpjLip84YrWmiqIgSueSQDnXIgVGHHIwK/cg8fdyjz1I51S39JxofCWRyXvxiRZ/+B
	 BQJ2W+/SkHSiJbhRasJQEba56SufdwfUs8/nDZjQ2t4bmkWRQJwh5Ie87GHTWy8FXw
	 esrXfkkytFsCpxMPepOzB+m3jrzcMzKaONsplKHQ13+P2rVVqJCyvxqmKtKhrAp9/s
	 GrRZ0dSP0zpM1xJTViCKQHOD3y+zFh5uhGkobiJXMRht8FtnYnl7jAiTB5jTEKzaVm
	 bwFUYLVvCqnsg==
Subject:
 Re: [PATCH mptcp-next v23 8/8] mptcp: defer read_sock cleanup to mptcp_worker
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, pabeni@redhat.com,
 kuba@kernel.org
Date: Sun, 08 Nov 2026 07:37:28 +0000
Message-ID: <179412344831.488855.8573212014753143807@kernel.org>
In-Reply-To: <6c5193e14467c5314f9e2195cae90d204abfb951.1793969127.git.tanggeliang@kylinos.cn>
References: <6c5193e14467c5314f9e2195cae90d204abfb951.1793969127.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message says the patch will "Restore the backlog flush
  in mptcp_recv_skb() with a sock_owned_by_user() check".

--

mptcp: defer read_sock cleanup to mptcp_worker

This patch prepares __mptcp_read_sock() for future callers that run in
BH context. When the msk is not owned by the user, it defers
mptcp_rcv_space_adjust() and mptcp_cleanup_rbuf() to mptcp_worker() via
msk->read_copied and MPTCP_WORK_READ_COMPLETE. It also makes the backlog
flush in mptcp_recv_skb() depend on sock_owned_by_user().

> Restore the backlog flush in mptcp_recv_skb() with a sock_owned_by_user()
> check. This ensures process context callers flush the backlog before
> processing skbs, while future BH context callers skip it to avoid
> deadlock on mptcp_data_lock().

[Severity: Low]
Is "Restore" the right word here? In the parent commit, mptcp_recv_skb()
in net/mptcp/protocol.c already flushed the backlog unconditionally:

	if (!list_empty(&msk->backlog_list))
		mptcp_move_skbs(sk);

That flush came in with commit 250d9766a984, and nothing earlier in the
series removed it. This patch only adds a condition to it:

	if (sock_owned_by_user(sk) && !list_empty(&msk->backlog_list))
		mptcp_move_skbs(sk);

So the existing flush is now skipped whenever the msk is not owned by the
user. The wording looks left over from an earlier revision in which the
flush was removed.

Could the message say instead that the existing flush is now gated on lock
ownership? It could also give the reason: BH callers would already hold
the msk spinlock, so mptcp_data_lock() inside mptcp_move_skbs() would
self-deadlock.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793969127.git.tanggeliang%40kylinos.cn
