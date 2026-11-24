Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557666;
	b=Mi+X42a5kNzkienRazN3FTZf9UxD802xMaynwHjkXISqpRC6R0MSSNaltNWSZLlBGCpL
	 mjGPygL9vCn1uBccKEUdUDzNagHvEVzsRlocFaV/46PASat5buNfQzGH0ek1cYA9hTDcn
	 dgRRlHhjC4EUgsGQ81EgTodaKJ4lQ+t4wHQYj1APyGuW5ImK+GUcy18l2I3ZfxtQuRpvJ
	 4iu84Y/mQ1YN+qd/Ft4Qg3KypH/kfi77bGVTWSXVzuSoiPnb7QvoqWz9cjp523vu0VAyo
	 oogMnJ+Qci3xd2/INGsE7FxFBblJjd/SAN9qjyz/8DwY2LZYrg+bhxhILZt8cmtteTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557666;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=NC8NjKXPPOZb89SBcxp2L8Kabw77plC0RF/TOei9Alo=;
	b=pA1vFS9uCGKIXzMno2usEqQW0At45osjqMdKO9Qj6wDxT+n+9yvuGy6K2s02V8sq26JN
	 Tmdss2EJxh8MiABccqZbnf/yO1nZojG7Yl4kxrqPr2XBsiD8e5we1EPF0ZtEW6esPZ3of
	 rYQnm0YbOJ7xfCP5c8J/fqxmNoZos9YvvajCN7wXOriNX0TBiXmSL2RF0Z0ZQ9s/+DPvX
	 rZfPvx2/5KT6YQIH4TvEz1dliC/5haGc2WHNUfDFwiEHrvhf9MvCg2MQWTvp8TxgcFEo1
	 Lb3OC+QEGmoupGj/y2aZm8enqSwHFuKEtnCoZ7QF67/vnZrDAOyKJbpKYdJsKKxzkUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yl5Fjbpq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D777B606A323
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yl5Fjbpq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F13A1F008B2;
	Tue, 24 Nov 2026 22:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557666;
	bh=NC8NjKXPPOZb89SBcxp2L8Kabw77plC0RF/TOei9Alo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Yl5Fjbpq9NS1BT8L2LNTnylxMG9uL+2NHL3pw1bo51xGqiSUJ3pWC6KZen8njEMVE
	 7tmShPDu7MUjbD6GyI24ubvkdeWMnreIA1ogYpHAfTmboNlkSZom3NjR99v6f3wGov
	 Sg37Njb+ACTXublwOWAG4qXLokX1mDonO6HVmsK1Q1JRReVne2+tLKLuKi9aVKtBsX
	 Pij9uPPhjmbtlkQURs46+k081HMGtxy1/e8lUJxQpR13qaK5n91OFR98zPEISjt2YU
	 yY7ymPjHyG06SIlacUqnuVovGtTeemh/Za3tU8ld7FXjBUndyEHOxgnjcbyosmY1QV
	 MBSWOxOPd0v9A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:24 +0100
Subject: [PATCH mptcp-net v3 07/50] mptcp: wake up blocked senders when no
 sf left
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-mptcp-cmason-fixes-v3-7-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2404; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=potabgVVuKyV53rWviiJ5aw/44XrcNt/e+Efyw6woVc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOH7ffDJ7iUTAdMV/Mw5bXH8/Kz/tiKnsyV/+ZqpJb
 VoVPaaTO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYSHsHIsMi+2+M3X9aaGuvY
 zjhzP/YPcyalGft/2pUdEmgw00iVm+Gv/K1e3eKd7BatLhmxj32f1K97ev2KXpvsZlb/ooo6w2B
 mAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When an MPTCP socket moves to TCP_CLOSE because its last subflow is
closed, after the close timeout or not, sk_shutdown was not updated, and
no error was set in most cases. A thread blocked in send() was then
never woken up for good.

Set SEND_SHUTDOWN in these cases: no more data can be sent. The blocked
send() then returns EPIPE, as a send() called after the close timeout
already does. Reporting another error first, e.g. ETIMEDOUT as TCP does
after a timeout, would change the behaviour seen by the applications:
this is left for net-next.

This was reported on GitHub, with a reproducer: the only subflow dies by
RTO, and send() was never woken up, while it returned ETIMEDOUT after a
few seconds with TCP. With this patch, send() returns EPIPE after the
subflow timeout (like TCP) and the close timeout (by default at 60
seconds). This is also validated with new Packetdrill tests, with the
close timeout, and with a reset received in CLOSE_WAIT. Without this
patch, send() stayed blocked in both cases:

  close_timeout_blocked_send.pkt:24: runtime error: exiting while a blocking system call is in progress
  close_wait_reset_blocked_send.pkt:25: runtime error: exiting while a blocking system call is in progress

Fixes: 27e5ccc2d5a5 ("mptcp: fix dangling connection hang-up")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/648
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for issue #648 reported on GitHub
---
 net/mptcp/protocol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bbb28f778d81..d54ca367fc39 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2814,6 +2814,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		} else if (sk->sk_state != TCP_ESTABLISHED ||
 			   msk->in_accept_queue) {
 			mptcp_set_state(sk, TCP_CLOSE);
+			WRITE_ONCE(sk->sk_shutdown,
+				   sk->sk_shutdown | SEND_SHUTDOWN);
 			mptcp_close_wake_up(sk);
 		} else {
 			mptcp_start_tout_timer(sk);
@@ -3330,6 +3332,7 @@ static void mptcp_worker(struct work_struct *work)
 		mptcp_do_fastclose(sk);
 		mptcp_for_each_subflow_safe(msk, subflow, tmp)
 			__mptcp_close_ssk(sk, subflow->tcp_sock, subflow, 0);
+		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | SEND_SHUTDOWN);
 		mptcp_close_wake_up(sk);
 	}
 

-- 
2.55.0

