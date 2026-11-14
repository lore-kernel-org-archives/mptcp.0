Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794664871;
	b=RQ51HYqFLiVa3gEdzf/neRVXGysgcSv5mSCMgv0i+AN5HH4KAXtMWMjKZtbExanJrnu9
	 dOz/CSlSqoVhbyPBi39rwwd7JWMgxyV4cp82vtQyalJbwMRKz8k9GvPkD7+562pDzutb6
	 n1yiKMpZVKtIq9i7sMD9Hi3d5QpRbHbw3T1dg9kcpM1NMjUdbdXHQTdSs9CiN65cH263k
	 tGr9sTuaK1yqJHDR789YcVMjSKQQAUUymulhSsfB9Ze7t6KfreTmEze9AMaaFgy4McreN
	 tiUd/+i9S1W0Go+U9nNQj7g+69ECdJS6pc3iXinKpauu59GrcI4tLq1AOmPBMcqD7rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794664871;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OPjoxduqZzmd7ahkHmj7hjSn658/nJ6CC+7kI5cnp5o=;
	b=X+/1vmOFk8D7eetLA6DS3JW9FMhGdSJbkNJAPjL9/DejoD5MfXBZ6xmd3pCmRuiFvK/m
	 Fitd1aqU50FIv0FLs+ighzWhBvgiqDPsy7FHVKqXYtTj0USgZLWatP+47Q96hKPzIv/RD
	 MnMB8idYkzFAHY38k0FZtPdQYJFJOph7awKldMnJewwG1rwSqQHh03Lj8pYb5rY54iS3n
	 y4G4nA+mCRBeTIFevqDMow/bn4+XAJwb5vlTyVrzqfPWH6277o9t5cEzSV1mPIi7eXCsu
	 ybYrw9vRpxXlPvoJ6nmjNOTqMRbq6X2AyBaAhJBbr0bnmxbryiaRXTExHoDMrS2YmaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SgZgzHCF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62E1606A327
	for <mptcp@lists.linux.dev>; Sat, 14 Nov 2026 14:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SgZgzHCF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF2B1F000C7
	for <mptcp@lists.linux.dev>; Sat, 14 Nov 2026 14:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794664871;
	bh=OPjoxduqZzmd7ahkHmj7hjSn658/nJ6CC+7kI5cnp5o=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=SgZgzHCF7MqnmU2cfwzV+BF3PX+12n5p4ECBZy1LoQztBrbk1JdUZJ4xzAL4JE2yr
	 q0OE1Rguw5Y+AtDyiOAygs766tvXj/vPhYuwrClpcnAXgbtn21UkvXgI+W6VuWJr3s
	 Yz7YJu4TbQWSgZwzLkX7qty//o1uXHArtQZhkF57mfTa2WhaoOl+5wlyu0rZRVdnms
	 /ogktZb7Z99dDPVz8zdFi1tE9Y9ijeHRYyj7+Ku4lWqnRhzzX6Wo+DfwrGf+WJaV0x
	 10d+NC84dBvCZ8cGRrkU9PJejCzghnQv+sQ9rhBXnHqN2gmkxEXfsLCfRJxq7lbPwb
	 PSRW9u4GAoFVw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v27 1/8] mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint
Date: Sat, 14 Nov 2026 22:00:57 +0800
Message-ID: <0d1bfee6213106144f29abe96298b691ec01ec68.1794663678.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794663678.git.tanggeliang@kylinos.cn>
References: <cover.1794663678.git.tanggeliang@kylinos.cn>
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

