Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557708;
	b=NGeXvlFBpYZE9lwUkG2WlbOlBjBgfVvdAMyi890+g5s/R5sFtMWyAgbuinYaxs/DeKHf
	 sPx/7F+up5pqQ3cmYz5pxyjubw8g3BlMbndy2uNf/ZB7bJMxBKbydEukdObd4mULem9Xv
	 psp6UxNcenVScDMyQ6/rck5E6lXFLYrcNrMrJPGEvoYdgqQprBFEkfdYkImuTrxZe+BVD
	 fU47OphennpRQwiVdCUYEIxA9BuaYcM+sw8QEit7O81hsiPn+Id4G5WBFMCCBjojfw4lc
	 9BZ/zRA9yBp00Xu8GssOJk7jblyam7mQGyGE9CwhMeDPznqR1QWXNX+1bolx9QvB/2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557708;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ZpOH4Fv0iQliZDk/hpYObcdBoFRQuJbom8BzxrjY7wc=;
	b=T+zJaZvRRy1pclHaLPSUx6mahKGsopMcadrUJREG73XEsiDecJz2fJSHKnItRdryLnyA
	 92h442ENV7A4mB6Wc1QjGH1XdhbOmFO0Hifb2ECnFfpOv9NLUqn7RbQUTB5Ah7f/uzEQg
	 udgXAz6q6SrtAo56kCiwmzMNNDH9O3Pdfnk/JyijRofZXY/dt/LJYyoEx5Wb9IB2NOqmk
	 Bbde7b01F/t82Y+Lf3n0LB5/Gv623BUNocd5h0sO9d1Ijjl99tYb3pkAHCbI308apWUru
	 B2SPJLnI7APwdjzRM3oARLgdbFDTkj103BQ/5JBV//WebggAeHS8tBPVPzA+HWUdr4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L9qyOEpi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CE4606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L9qyOEpi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08351F000C4;
	Tue, 24 Nov 2026 22:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557707;
	bh=ZpOH4Fv0iQliZDk/hpYObcdBoFRQuJbom8BzxrjY7wc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=L9qyOEpiXTiGOtuy81gCRQtY6NKROOwyY2jFn+1UJ3mVidgZ3byv0B+lPpIzDsGyK
	 RqNG8TntPBYpZNwW05EkSPjt+z6e8fpwBIDLaOmBXQbwPhUeKg9yykhzNQzwZtPOw4
	 YeV0Zln5Wc7OzRDzMX0uQlQeLEN2XhDBehVbPso5WwrQnuzjcbBDFPDYkvqwWOqNYB
	 ypZHWRWyrkzQI4J7EuMIrvtIZg+Cy6v2gwEX2PQTrx+9UVC2fKhglm7dtCdraX7jdm
	 cRzPVQ9FbGmZa9dAJbfdRJ6qDF/99pUkB5clyTsGyq5m+MONEFn/bvkvNetcUcxr2i
	 lEdQUYrAXTNSw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:57 +0100
Subject: [PATCH mptcp-net v3 40/50] mptcp: send the DATA_ACK after moving
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-40-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3639; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mCEn3srhu+73Lm6vdJ8Kvg3rYeSLemVd72+UgVNtutg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOAW6L9lmdzxe+Gf6Cqts/YX3dFjd5kTOnWBW9aot6
 ALDn81POkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbyyIzhN3vO94NrUzmlWybm
 Hz1TfJD9zeX1z9Sb3r7+9YJFf8dsj9cM/9P2x74P7a+2WbrdQXWjfU1mRseFH/ubM6bvf2LRVjg
 llw8A
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

Note (Clashiko on v2): with several subflows, no DATA_ACK is scheduled
if the last subflow cannot send ACKs: only a spurious retransmission, as
before.
---
 net/mptcp/protocol.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0ff84d9684f1..2f89719e8454 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2417,10 +2417,21 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
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
@@ -2428,6 +2439,9 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
 		list_del(&skb->list);
 		*delta += skb->truesize;
 
+		/* NULL if the subflow has been closed */
+		if (skb->sk)
+			ssk = skb->sk;
 		moved |= __mptcp_move_skb(sk, skb);
 		if (list_empty(skbs))
 			break;
@@ -2439,6 +2453,9 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
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

