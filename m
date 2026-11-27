Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809724;
	b=5jgHogQgElUrP9q2HniMDsMNF3bQW30FiQxLXQSnVUimMajzEhjjemOM7X3OZfwdKVLX
	 wPeRHufrgjWNqHaa3ZgvmJ2VF8FTBYwFDmOzWtlo8UE/4DdJBG6N7Ad0d/V6RO8N5HiD/
	 h6ZrVji+qhUX5CewJhiA7RqAdfpMFtTAAHdCWLgNGtN5DrQXAcl6MrlveMjHzQGU2sdPp
	 Iw32R2mxrzhdcHBQUS5hUQMc9kvhztkXvAmdLU+duTMW4HtufSTyPKORtdWioKJZGQvCT
	 oe/tulQS6n4LbQfEWPuV0u8HTcDP6zhkPr9SOB1AOZ/B2B+niwmFLq2/sObXCsATXMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809724;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=t8c0Gp1d9jidIUotLfMCElvSL/aKKOmmYXVxFCbJ24k=;
	b=wzUYmRzbsd3SbbslDrLsOdj2Ux5Dx+BM23NqeUayY84CRrZsB4lTxk848VP3GzrpAcWH
	 6qNCYvDEWhwsQ112uErcm3u5KFDvFf2AUgi0MNQaw7sQaAnlzIu35XVifGxyAzXjBsP8s
	 a46QmDUuSzPgLE+AiN8ngPuFuu0Y5poJM7x/G7iQB+5cZg20zpOFjLikosL08b/n8rwlm
	 Rz1kbp8DLSLi0OOvB/Ry6+OViAGSUQMLCXuOGJEARKLlFAGPa1BFt6vekGbopfL8tetrl
	 TOxJ2om4dKyavrEvM0SWKli63LaNDKU2Fyadhpk7wttzwimDzk8CpWfQnmrwlATGokw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GONr80vf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C7F606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GONr80vf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA3B1F00897;
	Fri, 27 Nov 2026 20:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795809724;
	bh=t8c0Gp1d9jidIUotLfMCElvSL/aKKOmmYXVxFCbJ24k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GONr80vfyikhWN4+RUZLYYkf/84JDih2r7epRNOVJ1pY4tdMp8qIYvVcSYP0KOXs2
	 rm54XIyyUlDO0uq4mKmf7puJ0Nj8gP04RX0DcNCSy10yMib25UQacOUt0/l95qjzOl
	 BxY5b0YkV0HunpwoggL5lLJtOuPCOI347V7JZbE7GfgHvRFONAw2QEjcv9vsLLepw+
	 dfcYZQiRdO356E6fXiFR/oxQHHVutlEuGV4KaN7KuKkZ4K8j5Y5zZj/C0PHc96fMA5
	 rPUEn9ppEOptJx7rkgCRsuLKjCu3aMRNpwA3C6CzuSCVfVYKrOwd5jY1YIVwQ431Gw
	 SjfkRaDZmXcPw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 27 Nov 2026 21:01:26 +0100
Subject: [PATCH mptcp-net v4 02/20] mptcp: keep the first byte after a
 simult connect
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
Message-Id: <20261127-mptcp-cmason-fixes-v4-2-3f393ea8c48d@kernel.org>
References: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
In-Reply-To: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2873; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Vut6hbFGo4X1PzLVpIzFK8mFG8HH7iXUf4WNvrsxlp4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLI5Hy6faPSM1/tjklV0oNqVJYbRDJKtq3feTrBj95gsI
 7qK63lORykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwERs1zAyfNBOenKZr5plq5/4
 lp7T/5sFROzPZM+WTI7fxNxV6JVmxMhw9MbXkCc7X166bcVZZrIuefGBe1V+gjIBEhF7OYrW3xT
 mBQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A simultaneous connect leads to a fallback to TCP, decided when sending
the SYN-ACK from the SYN_RECV state. The received data is then mapped
with dummy mappings, based on ssn_offset, the peer's ISN, normally set
by subflow_finish_connect() when receiving the SYN-ACK. But here, it is
only called on the next packet, received in ESTABLISHED: its sequence
number was then used as ssn_offset, and the first received byte was
dropped.

Set ssn_offset when sending the SYN-ACK after a simultaneous connect,
and only take it from a SYN in subflow_finish_connect().

This issue has been reported by Sashiko, while reviewing another fix,
and confirmed with a new Packetdrill test: after a simultaneous connect,
10 bytes are received. Without this patch, only 9 were read:

  simult_connect_data.pkt:24: runtime error in read call: Expected result 10 but got 9 with errno 115 (Operation now in progress)

Fixes: 2834f8edd74d ("mptcp: cleanup fallback dummy mapping generation")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue spotted by Sashiko

Note (Clashiko on v2 and v3): ssn_offset is not set if the crossed
SYN-ACK cannot be built: theoretical, it needs a simultaneous connect
and an allocation failure.

Note (Sashiko on v2 and v3): an MP_JOIN subflow established by a
simultaneous connect is now reset by the previous commit.
---
 net/mptcp/options.c | 5 +++++
 net/mptcp/subflow.c | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 34eb70298bac..0d73d02cad86 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -474,6 +474,11 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 	 * in mptcp_established_options_mp()
 	 */
 	subflow->snd_isn = TCP_SKB_CB(skb)->end_seq;
+
+	/* simult connect: the peer's SYN-ACK will not set ssn_offset */
+	if (unlikely(sk->sk_state == TCP_SYN_RECV))
+		subflow->ssn_offset = tcp_sk(sk)->rcv_nxt - 1;
+
 	if (subflow->request_mptcp) {
 		if (unlikely(subflow_simultaneous_connect(sk))) {
 			WARN_ON_ONCE(!mptcp_try_fallback(sk, MPTCP_MIB_SIMULTCONNFALLBACK));
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ddf1c3b92db2..d485326980ca 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -591,7 +591,9 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	subflow->rel_write_seq = 1;
 	subflow->opt_ack_seq = tcp_sk(sk)->snd_una;
 	subflow->conn_finished = 1;
-	subflow->ssn_offset = TCP_SKB_CB(skb)->seq;
+	/* simult connect: not a SYN-ACK, see mptcp_syn_options() */
+	if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)
+		subflow->ssn_offset = TCP_SKB_CB(skb)->seq;
 	pr_debug("subflow=%p synack seq=%x\n", subflow, subflow->ssn_offset);
 
 	mptcp_get_options(skb, &mp_opt);

-- 
2.55.0

