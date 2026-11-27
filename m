Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809728;
	b=NWHIpQMaaP48q45JzE76hSiW0Ga1J3c01pw0F3tLGLhqEdjVntyMmlhcq/fbfH1MBzcz
	 37m0jMhJo1Jj2s1UafmDcOgLdQu/MTT32ODD2c3n/eHaV5vwjrycm3nylYM8oYIMTObVa
	 OVzWjERDsSVksatXxZdj81pXWmPdlnKDa6rZxXn4yw5IfoXxh8Qdubz5F2np3I7dUd+VC
	 //ioTmxMoADfUMVozTf8z0z+5VMJ0K4zNxWiVwh+1NR7sC0wOhw8vcWQcpiVF06Q8lpxF
	 OCd0KeREByXGvG/y3EPd89DPVwVZfOBeLZSeGz0cBo4c4sKNTyh5TUYiCqHrpRJW1qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809728;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=kLEaLsTlkv5wAzTYKtoeUXAeAkQkCXjM77iRRkeVrd4=;
	b=Zhq79b90nKihPCcdvBk6sB5pq6/T4CCC9F6NxuK5+XV20q3yDRXOrXF50bkqMx4FQO1o
	 oraQnZbvoEyubJ06jy/bnTefDYmd7Cyg5M1CQ6w/LCWxjitR7oIlV3ZtMZig3zpa0wslq
	 qbT94qG0UpgNEbogtDRjPZPOSRcae3GUgYWyUyC1RlUmFpjisXaMjBd6BIjf0OPNaFqGT
	 Zfts4T/hKfEGtsR7gULIs2jj7ZpfNwu7qr/OXmUkBAhry4gAFEhiWJ9If0GuBSh8kau8v
	 n0qVvZJTvsEdtk1o1jUtGELObtlHXJSPFIB6OoIBPLhIWdwG/MjyOVplgtPKwJrEAyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ADYOjv+b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090E7606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ADYOjv+b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB8A1F00893;
	Fri, 27 Nov 2026 20:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795809727;
	bh=kLEaLsTlkv5wAzTYKtoeUXAeAkQkCXjM77iRRkeVrd4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ADYOjv+bNUtCigeq1TOib2zEl/7b5W+68nhCjicVJ2og8d7LRsGnBslzMqepYFmGs
	 jmnfs2jog+pq+Q+Hi1NrHMfI5XXA1J7mHwwLt9z6INhirDe0vB8l7e9DmuBu0ungHE
	 wN6CeqJP0ycqDyxbopk5sF9jOVN1nAV86+rMxlxI1sFbtjRP0ybgeKBA7zp9PS197J
	 V54YcC3u3GwoQrshBhWVcbLWE0iKxr1M/7i+4R4xcdgzwfXMN7w0afssZ5aCrMLn0S
	 e1wcPhtDxLNR5ImMJ4L0LnhB/BECdLj8oHbaG1DZX6q1iNvVAiolFtS155otArwd8s
	 hkOVuXlT0u6tg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 27 Nov 2026 21:01:29 +0100
Subject: [PATCH mptcp-net v4 05/20] mptcp: send the DATA_ACK after moving
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
Message-Id: <20261127-mptcp-cmason-fixes-v4-5-3f393ea8c48d@kernel.org>
References: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
In-Reply-To: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3813; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Hj8cCNdpipwhWs67QBkJuyiSZHS4BJA3OjmFiuWFV1g=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLI5H66yXmy4XnjtBMVTTrLvhRcHf7ZYdV/8uX6Cb+qXG
 Xq8CpwMHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABPhOMjwv+rAp5bjvyYdfxxv
 py6z7LD59aLHLnr9x5a/n9mYeERUbiUjw6GrK8x2Lmio9arP3h1+7suT9ebBh5/23/wbYnZWPyp
 Cjh0A
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

Note (Clashiko on v2 and v3): with several subflows, no DATA_ACK is
scheduled if the last subflow cannot send ACKs: only a spurious
retransmission, as before.

Note (Clashiko on v3): when this delayed ACK is sent by its timer, TCP
adapts its ato as for its own delayed ACKs: sending this ACK at once
would send more ACKs.
---
 net/mptcp/protocol.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f600e9cdc500..bde512c60feb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2411,10 +2411,21 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
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
@@ -2422,6 +2433,9 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
 		list_del(&skb->list);
 		*delta += skb->truesize;
 
+		/* NULL if the subflow has been closed */
+		if (skb->sk)
+			ssk = skb->sk;
 		moved |= __mptcp_move_skb(sk, skb);
 		if (list_empty(skbs))
 			break;
@@ -2433,6 +2447,9 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
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

