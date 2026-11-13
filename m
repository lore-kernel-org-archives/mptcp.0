Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563934;
	b=0twcolQrATr+/3FshXWaZ3nOk4OTx//b7PXguEow3Hczo+Jg56NvuEDwlY1JfRj8zybH
	 hINyOVMkjY86+nNE8YqXeFd0nBrsnDRObadHZungd7K264h74dHcCDsk7/0kpJ7nZj3eG
	 xEi7/NfMQjByyJajeS4H1pe+/LfJxdzLoKNPDykys+GliuldEN2cf4CDsfb9EJ6NcSC0G
	 87AFO0H3sYaa5xZA1Z2hXZY5cwhuw0z7mxJYZxtfi+6wEWHBlC2g3aIOJcxPE+ClZv9bM
	 99PRuQEMVlbJq2nncA/ekh+A7Zx5xJEK3gDbr7lZ01TACqSqG0gPGk9/dQSLV4nNcMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563934;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OPjoxduqZzmd7ahkHmj7hjSn658/nJ6CC+7kI5cnp5o=;
	b=fnlGEzx0cW+TOyzpYcypEHWfDApWJO039xpArSTCHo2N+JlVvCDmAkw934XvUIT2pGr0
	 DoarohFJoxkYmtAuyTR+3r152OqAypoCWjvdofGED76Axr1+2FlmlFysRS53W+PQYsAAJ
	 UlOJMBYNJRHfcB1n8RPiDOnPs8tbDAXUUDhzbP2z254mkvysFg3FTo+czroA9jAynu1GN
	 l+MCLdA0f/UkXW+ng27EvYEspisacfWrcPmWBp7nSxQP/aUkMwtq3CQ6bw7Qhu9+j1jpH
	 PipiXekHrs/NGoYdv1cC+d+/zxjiBFLZofxqs7OP3squkuxEqW0laa5PcjR0Z4yxXuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J8QHw8y+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FFD606A323
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J8QHw8y+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014161F000C5
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 09:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794563934;
	bh=OPjoxduqZzmd7ahkHmj7hjSn658/nJ6CC+7kI5cnp5o=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=J8QHw8y+GWAVQsnP6NI4JsTleEqqDjWBZOnZz2WkmMhrkLWshibKeG3nS1MK7LLh/
	 zttr0MF/6n/mEKubqcSmlXHTmcIyR5WushaSbKS5nbkFuMxo6J4XF/BaXn7tYddkvw
	 npN7ZGpSdDKwFWNMpuag9jMlcNIL03oWWj0URXce6bi3On4YaAZOOD/S24mwBRYiU+
	 kI1XXERzw2lscmjBjpdGnXcwK8C0sQ+ipV0hM0eLeX/73oMEpTxpZLH2ycsRen9nXy
	 OBVizDoz9Q/E+6zqIXxlJzaG11WmyQy3jVxqDr/qSq3uED6etipmJfzGyuTXMWhcjy
	 7LmCSJ26eN82w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v26 1/8] mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint
Date: Fri, 13 Nov 2026 17:58:40 +0800
Message-ID: <e288e463e3eed170694151450d5508e9df97e497.1794563432.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794563432.git.tanggeliang@kylinos.cn>
References: <cover.1794563432.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Fix mptcp_inq_hint() to compute available bytes using mptcp_data_avail()
(bytes_received - bytes_consumed) instead of ack_seq minus the head skb's
map_seq.

On passive TFO connections, the TFO skb has map_seq set to -skb->len.
Without the removed __mptcp_fastopen_gen_msk_ackseq() to adjust the TFO
skb's map_seq, mptcp_inq_hint() computes "ack_seq - map_seq = iasn + len",
almost always >= INT_MAX, causing SIOCINQ/FIONREAD and TCP_CM_INQ to
report INT_MAX. This also breaks receive buffer autotuning, as
mptcp_rcv_space_adjust() uses mptcp_inq_hint() to measure consumed data.
The bogus hint prevents mptcp_rcvbuf_grow() from being called until the
entire TFO skb has been read.

Using mptcp_data_avail() avoids this by tracking bytes directly. This
change also affects non-TFO connections after DATA_FIN: with N bytes
unread, both SIOCINQ and TCP_CM_INQ now report N instead of N+1. This
differs from TCP, which reports N+1 because the FIN consumes a sequence
number. The EOF hint of 1 is preserved for the empty-queue case when
the socket is closed or shutdown.

Fixes: f03afb3aeb9d ("mptcp: drop __mptcp_fastopen_gen_msk_ackseq()")
Co-developed-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 50de5cedfd0f..f2644e7a6a05 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2404,22 +2404,16 @@ static bool mptcp_move_skbs(struct sock *sk)
 static unsigned int mptcp_inq_hint(const struct sock *sk)
 {
 	const struct mptcp_sock *msk = mptcp_sk(sk);
-	const struct sk_buff *skb;
+	u64 hint_val = mptcp_data_avail(msk);
 
-	skb = skb_peek(&sk->sk_receive_queue);
-	if (skb) {
-		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
+	if (hint_val >= INT_MAX)
+		return INT_MAX;
 
-		if (hint_val >= INT_MAX)
-			return INT_MAX;
-
-		return (unsigned int)hint_val;
-	}
-
-	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
+	if (!hint_val &&
+	    (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
 		return 1;
 
-	return 0;
+	return (unsigned int)hint_val;
 }
 
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-- 
2.55.0

