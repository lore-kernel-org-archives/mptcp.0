Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811149;
	b=fZe6FeU7BUUIFCs6F7IjUUlKcK5zzxSaHV6M1ZS3U9+uEOqLGj8E2znaC8qSndqSoiPc
	 Q4Pl3v95URvsdrG0dN5Lfo7MZgm/JWZutxwKRxFIih6sb03xAj1j4MJHjvWRvERD6jxJ/
	 nTzGqxOWXhIBAFYyyT0bWP4tDCYcTEcuZRlBacK3wkl/CQtEqbcSIVIhd9DFO7+WHwldF
	 6sD3UKIOjXKXh2BWS6LHc45O01Owq3aWEaC4UdFP7d+f7vTmhk6kfTQpD6yklirgmUQZa
	 eFLjM6oRsuDBQsoVkHHQDaECofQiZLbmRnXagOpa+yCw5HZCRxFh4wbLw8+ANwDmBxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811149;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OPjoxduqZzmd7ahkHmj7hjSn658/nJ6CC+7kI5cnp5o=;
	b=tPSH1BPt3bNySTVbkGmewLOVW1pVFrA1iLJlAo2w7xKTCOZS+ByxCghHajZO5F19ejLO
	 aZkRwrQ5D+DeInJERcxkIWZv2mh1lIHFyGxdSkXKfLIfkozqIEy1AxmP/rVwLkMz94bt0
	 2drmR3AsuGLtfYgFi8uPPzMdkq07IQUosqlkdN1jkfKu+s+1kklXrfIAut7w/DHxTMNV4
	 Tj8WKXWGnGBRm0SpDC8V2Gjy6g0Ucr3pIuALIlRKVyKGMbvTaBd7LE0aYGRJkCn/CYtMv
	 Uv8a49v+kg7GkkxJ3KWOC39EqRsar0182GEt8kq/RARurj4f939Lw+LO5pSBTL82Yjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ffcNbosJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDE6606A323
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 06:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ffcNbosJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264FA1F000C4
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 06:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794811149;
	bh=OPjoxduqZzmd7ahkHmj7hjSn658/nJ6CC+7kI5cnp5o=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=ffcNbosJPzhAgemOi9k6Dtyov3mSy5bQ9xE7BddOh+MRsDYw0jMBrSKPmMIiR7EH7
	 4T9Peh0arkoBJmpjYVT7feGg7yfyDgrSBtaDEI42DLuzZ4jsDvYRHaV5gZHlgExYo0
	 wNESyTyXfRHfGV+jFx63BmsN+sp+MVNjzoQdmrNyQmG9q9o2Uyd7kez2sMYsRhpt7w
	 35/owgL72bj7qWKRKPTpGgbbiIIAI1P3EsKAHuAlv5USrahFcycJ0hSb/AS/7AqRYP
	 dsCoJBg/pldy44MS5aMHkxqYM3WOE8ldpGB1T8LVd7BOjwF/TTp85Gz38Cwtyj3Lib
	 N3/ulBxY90Fdg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v28 01/11] mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint
Date: Mon, 16 Nov 2026 14:38:54 +0800
Message-ID: <ebac8e12800293fe7cfc0f2b5f88109b34df6d06.1794810809.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794810809.git.tanggeliang@kylinos.cn>
References: <cover.1794810809.git.tanggeliang@kylinos.cn>
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

