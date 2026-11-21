Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254186;
	b=CLyvQd3XO4QWW12SywaXCtHYmUkmjQk/C0k/wOIpQwroHnDxSFjzIqtMcvAS1xK74bbt
	 MSJ9K7f/9kZuDmRtZcm7uf2OHsZvrnFfOHfsJYHRNWGkGD296EPD1Hi812Ta9pHOvn5vs
	 kAeWvVaZireKcr0tMZwFGc3gjxSzh4AHvxHyj17jAfBD15eydHBQDS5N/gZeR+QrgNLWD
	 OrsBc0Oe+UbwDjgapo/lxJ2kmgLhw3VvEUfkxJvIcm+22EtUvYqMB18GL/yKpu6o3uvHk
	 B1GXmTSqPh5b6zIYoRqdcueJ2gvjTkyolwrDnaEBZj2dldDfhHP0Ad8bPkUY0Jc1OXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254186;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=YeBVQTlULxZ+VysUsWpzZV8IcgJjGInxQK4cTxrei0k=;
	b=kSQFahjheBxOmlS/c1s9irOTwWiPMW8CsH0vgs7a8ULxrC1w8nxL37WS3zaYkhV/3XwU
	 3hPybCaK9G32G5qDunLmOiB+VlKkTYe3lLFAejdjrlCm4bjR7UTSlyYWOr+VzwEnPVyi3
	 cVM/xjv4XPESA1aFxA3fY4JUiRwcYGgH1wVnD7tlATFQeyUuMsuYObHlbz6Rl83G6V0d2
	 tW6E2CrNsM92sx5+EJi7190ekmhGkrLrxgTLiARg0Kf0gUKbFGrCes0nZ+QUH8q2MkH/L
	 uX3OFu1A/xSD6sO6O56fngoY1Dm+/fCHNJbRirWiu0JCTjVreKwdAc10rKOW+fX3sYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o055SqLp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4D6606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o055SqLp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DFA1F000C0;
	Sat, 21 Nov 2026 09:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254186;
	bh=YeBVQTlULxZ+VysUsWpzZV8IcgJjGInxQK4cTxrei0k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=o055SqLp3lo0eEqp5+DU3nCWyVpZHBqjGP3rIUGjWRU9IuSXElfPx3KiKnjgLC6lB
	 R36leGfdszSazEcjINCJslps+O+BJ1L+51WzOX9uiqUDBVYZ8sqXVml8/H25FQhA7v
	 N1ddD9VQnjyMpV2mbucqU2p2Ez+gkeReghgOUXsp3S3TNu94yAn/yHEIC6xCrv+ab8
	 UiAB3//QoyJSpcH3dD670QTuAWLRfFKSBRwlY/Y25n+JUgOc8HoFK/XSCIxo1NXUa7
	 kLJc625ViKftfuFco5u/sRFQFbIJma2Fd2AOAxe0MGqhjXXso28K1s9KuJ7xw3B4zG
	 t5OshqaDAsajw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:52 +0100
Subject: [PATCH mptcp-net v2 54/62] mptcp: send the DATA_ACK after moving
 the backlog
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-54-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3482; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=AOaeVHbFI86p0bDj0vPuzhKg/u2uir41AnqgxAVQsro=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ0ws5uB9xPStTFYlKau8y6X5SuG+Z6qcn9bdOG+3YW
 tTDKO3cUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMBGpVIb/0Z1XRZ6ypNwyTP50
 b97LZNck/s+9+7Kr3W4Y64uYPMr7x/CLWfRVdOdDp/Zl7B1hd389OZfvP4tp7c3llWyL2n3WXjr
 DBgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The data received while the MPTCP socket is owned by the user is put in
the backlog, and only moved to the MPTCP socket later. The TCP ACK sent
for this data then carries the previous DATA_ACK, and after having moved
the data, an updated DATA_ACK was only sent if a TCP ACK was still
pending, for more than one MSS.

If the peer had nothing else to send, it then didn't get the new
DATA_ACK, until another ACK was sent, e.g. when the reader frees enough
space in the receive buffer. Its MPTCP retransmission timer could then
fire, and the data was retransmitted for nothing at the MPTCP level.
Such a retransmission also prevents a later fallback to TCP, after an
MP_FAIL: this was causing the "Infinite map" subtest from mptcp_join.sh
to fail from time to time, with an unexpected MP_RST.

This behaviour has been introduced by commit bc68b0efa1bf ("mptcp: move
the whole rx path under msk socket lock protection"): before, this data
was moved to the MPTCP socket right away, even if it was owned by the
user.

To fix this, schedule a delayed ACK on the subflow of the last skb taken
from the backlog, if no ACK is pending there: the new DATA_ACK is then
sent with the next ACK on this subflow, or when the delayed ACK timer
expires. TCP sends its ACK when processing its own backlog, possibly
delayed too.

The root cause has been confirmed with a Packetdrill script and a debug
patch keeping the MPTCP socket lock in recvmsg() while data is received.
Without this patch, the DATA_ACK was not updated after having read the
data:

  error handling packet: Timed out waiting for packet

Fixes: bc68b0efa1bf ("mptcp: move the whole rx path under msk socket lock protection")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue causing a flaky selftest
---
 net/mptcp/protocol.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 992e1832398f..cc438ae46089 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2415,10 +2415,21 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	msk->rcvq_space.time = mstamp;
 }
 
+/* The ACKs of the data put in the backlog carried the previous DATA_ACK */
+static void mptcp_subflow_schedule_ack(struct sock *ssk)
+{
+	bool slow = lock_sock_fast(ssk);
+
+	if (tcp_can_send_ack(ssk) && !inet_csk_ack_scheduled(ssk))
+		tcp_send_delayed_ack(ssk);
+	unlock_sock_fast(ssk, slow);
+}
+
 static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delta)
 {
 	struct sk_buff *skb = list_first_entry(skbs, struct sk_buff, list);
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sock *ssk = NULL;
 	bool moved = false;
 
 	while (1) {
@@ -2426,6 +2437,9 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
 		list_del(&skb->list);
 		*delta += skb->truesize;
 
+		/* NULL if the subflow has been closed */
+		if (skb->sk)
+			ssk = skb->sk;
 		moved |= __mptcp_move_skb(sk, skb);
 		if (list_empty(skbs))
 			break;
@@ -2437,6 +2451,9 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
 	if (!moved)
 		return false;
 
+	if (ssk && !__mptcp_check_fallback(msk))
+		mptcp_subflow_schedule_ack(ssk);
+
 	/* Only the worker can close an orphan, as it must then destroy it */
 	if (!sock_flag(sk, SOCK_DEAD))
 		mptcp_check_data_fin(sk);

-- 
2.55.0

