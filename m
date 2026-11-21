Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254158;
	b=T778XOScFh1ai3XrszvBulkJq0RhrZoPhxWZhZKNIESZ3u293qAr93z8k++x020XoFST
	 WNZFMO7dnz6hpzEW5oZY/H81+G9AnPxulHcPgvNnxcTyHpYRFhWgVZ0IoGodrGfcN36o+
	 YW5OUxSeuEiUrHrUBTbZJH9vpDfHnfjhiEZotIXcb+7KDjrB9HRPgcI2ZBe8bL1TDr601
	 C79tKoPy1lD61ETFk0hYwQC3+WnUJRa9BjDcSJeA6jCUYJ5pbXJyUYyraerdkI+1Etdbq
	 cSlKa43fShySkMxq1r6Kp2VfxYq0PDqm7dLzLDbJf8NU+8LBpvGrQ+ZoTAsxjoyv+uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254158;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=iCyOiyO3GX7stI6Af7iIjWz7YRxMhnfiAq1lpWIEsoA=;
	b=JeyJioQ9bFsV1Bo9HII7yCRUoFjBJ+v6OHj09zR3o5u+QcnFD0wpmxjD2QjpLYc77YNx
	 7edARzIS/iF1ZwRIEXACOqmuPE6KB2s5VJBv2Y4J2ptZ0Uudtug1N6nlzqH64iE2PT02c
	 x2qcQcbuqUEouh9ebFLOfeBI+mPo42wIA8SJWmmkQdEgySmWQXppXbXk9Nv2EjN5k2Q+6
	 z45JApjmHZ4amxiyw6MKg3FpVwD1cyF9OHwoeJSIg+7k1y9WpoGCdUwraAI9Qd5A+ntld
	 L9YCZVUZYn5wEj3TJuWWQHDu63gu2J0H+Neh3w8GEDF6yA0GYL3aCgsvkQIuzV0NWLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VcnlpcEb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1C2606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VcnlpcEb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8631F000C0;
	Sat, 21 Nov 2026 09:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254158;
	bh=iCyOiyO3GX7stI6Af7iIjWz7YRxMhnfiAq1lpWIEsoA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VcnlpcEb1oFBQsnK6zoR///zXgs3OF+NRdgM5j3NdVmMzV4E3fFBc9AjX/S2Pau3P
	 uinofaD4zKuiWP64xvfcmagvbvusy1dWZis7YNCxAgTGSVQA1xP01Hijfp7aY5ZBt8
	 zS67S/ZU7QeezRr3Ave3/mf4OtvlTiX5MTqzHsxpNThXBr9ek9276WOE8biGfGpfXe
	 4Fq4CRPwXaHSfyf9kUAZFYN3jRjCwuj8dkBc8oNCrGPioO2xIy+fE3jcs68b1E0/cA
	 dGJFdsMlW+n8levSxqq9fbnjlLknTbJmMc9CNQAufJqu/hpmG3rG6i6aAjiS+UBcuw
	 30iFAZCzJJY1g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:20 +0100
Subject: [PATCH mptcp-net v2 22/62] mptcp: no sf left: process pending
 MP_FASTCLOSE
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-22-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2767; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=tT+sGwXX7rmEe7G6HE9E63dv7+fcjmt6xZ/8UMl6q/k=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ0yM4Xndr6N0u2bRKvmYbn0Lu3NKZTGpPi+dIfS3U4
 Xsrq36lo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCJ2txn+mSdLJ4Y9kYw4dXna
 g9uNjYofKvwlbYp+BzbOSGo90SQqxcjwTpb9hXKrvcLEK4JJx8I8+H/nKT6VmuG7+cT/ObEvhbb
 zAwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When the last subflow is closed while the MPTCP socket is no longer in
the ESTABLISHED state, e.g. in CLOSE_WAIT after a DATA_FIN, the MPTCP
socket moves to TCP_CLOSE. But this subflow could have been closed by
a reset carrying an MP_FASTCLOSE, not processed yet: if this reset is
received while the worker is running, after mptcp_check_fastclose(),
and before __mptcp_close_subflow(). At the next run of the worker, the
MPTCP socket being closed, the MP_FASTCLOSE is ignored: no error is
reported, and SEND_SHUTDOWN is not set. With data still to be sent,
poll() then reports EPOLLHUP, but neither EPOLLOUT, nor EPOLLERR.

This issue was causing the "fastclose test" subtest from mptcp_join.sh
to be flaky: after the DATA_FIN from the client, then its MP_FASTCLOSE,
the server, still having data to send, was killed after the timeout,
with its MPTCP socket closed with RCV_SHUTDOWN only (-->):

  timeout
  (...)
  mptcp UNCONN 0      0      [::ffff:10.0.1.1]:10121 [::ffff:10.0.1.2]:45220 (...) -->
     (...) bytes_sent:92032 bytes_received:1024 bytes_acked:57344 (...)
  (...)
  [FAIL] client exit code 0, server 143

The root cause has been confirmed with a debug patch keeping the worker
busy while the socket is in CLOSE_WAIT, until the subflow is closed: the
same failure has been seen, with the socket closed in CLOSE_WAIT (8)
with a pending MP_FASTCLOSE, and without error:

  (...) closed with pending events, state=8 rcv_data_fin=0 rcv_fastclose=1 err=0

To fix this, process a pending MP_FASTCLOSE before the close, if the
socket is still in use. With the same debug patch, this subtest then no
longer failed.

Fixes: 27e5ccc2d5a5 ("mptcp: fix dangling connection hang-up")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue causing a flaky selftest
---
 net/mptcp/protocol.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d3a793e96c9c..518321aedd1e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2705,6 +2705,8 @@ static void mptcp_cleanup_ssk_backlog(struct sock *sk, struct sock *ssk)
 	mptcp_data_unlock(sk);
 }
 
+static void mptcp_check_fastclose(struct mptcp_sock *msk);
+
 /* subflow sockets can be either outgoing (connect) or incoming
  * (accept).
  *
@@ -2816,6 +2818,9 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 			mptcp_schedule_work(sk);
 		} else if (sk->sk_state != TCP_ESTABLISHED ||
 			   msk->in_accept_queue) {
+			/* After the close, an MP_FASTCLOSE would be ignored */
+			mptcp_check_fastclose(msk);
+
 			mptcp_set_state(sk, TCP_CLOSE);
 			WRITE_ONCE(sk->sk_shutdown,
 				   sk->sk_shutdown | SEND_SHUTDOWN);

-- 
2.55.0

