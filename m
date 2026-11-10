Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305511;
	b=jACRWJPFMtFuyCRJEM+kmCiyaNfOLWLhJzr2eY0iF6IjVoleLHB3/fF6kAlk2DuaH9JB
	 E8GbgGc1rh96JWD8i3F5I034bgSZqUubtRkQl0Duj2LdUYT4oXyaC9GCXsIsjO0mU4rhx
	 XixdMRhFMMPxGVo1rO+GoWn3o07I0Pf4hfLnwwkn4VQXJHlNGks5lF6gFMC2gkIZn1aCa
	 HuWkHiXIw31ZiKUXHXAnF2POt0uhyeGyMUfAzZFrD+UfMpA6C354pL/S5MeEfLMNcImyr
	 yL1cRdQhy06CJ65unDnzTlgVEsoQnQiAwm8d6fit70nxmxHSioeJAG4cnITi1IY647A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305511;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=izxWmwuAcYspgelSkIAUyDfqt3f4x4kyer12QO2nI+s=;
	b=wo9/mSD99X4TsJf3jApqfhnjyq1/CNO1K424UfHgAOOeCQp5zeVHsnDV3szuR9bW940p
	 Vk2/rx5qAFvdCOWqGP1Djb92D1F8a1imBEDuO6uSuLPYHOP7trCd2Ml+r4d/q8pndJwjD
	 FMoszvxrC7XW68OYAolzHFouGMb+gLy8G6i/H7u7tS/jDRlLrzg06xLxsSkFK3YriLCD8
	 1ZYnEf0ZabCQDus28FfCNM+jDv+Gs5KEPTkm0+56psHEwy8KCbLsZsmP/jRtrwIcipPne
	 s77e6AnPbEKcy7Rj9wiLdK4QjEx5fzQpGwqZf0KhICWvI+BaGSVr9CFijPpz3VvjwSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l4S1IDSk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AA0606C5D7
	for <mptcp@lists.linux.dev>; Tue, 10 Nov 2026 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l4S1IDSk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DBD1F008A2
	for <mptcp@lists.linux.dev>; Tue, 10 Nov 2026 10:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794305511;
	bh=izxWmwuAcYspgelSkIAUyDfqt3f4x4kyer12QO2nI+s=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=l4S1IDSkyDitZBIyFevhERyct2ZJAxifTr5D9iMXbc7B/GdRhhO1co9Q8ijHJG5V5
	 +fidWB52EiDYNtakH+9ayCZ06NrrC/8BqEspABJMqxJsBUkZgpSEtcHMsQZHiB0ZnI
	 cj/jrO9Mn9R15vp6/yQOi72RJU0yJKSOOIpw/t/Ov5j6Q2UZenWzR4r+DfVt7xT3PO
	 /E1PpqmFMTIvlOVDnJyivLK+/tW22IGrxl+9ADQ7mQGDnbckxcb23BMl6+hEedYhBT
	 oNJc58zYfypGzmFwPZceRIKs/T+YPwCmEoMWyQgAimjpIPLnPNtXE+uO9scI/kVf5j
	 wkQXm+bU3lFgg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v25 1/8] mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint
Date: Tue, 10 Nov 2026 18:11:40 +0800
Message-ID: <ff754c69824fa566626bd37287f696c39afa7ec4.1794304840.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794304840.git.tanggeliang@kylinos.cn>
References: <cover.1794304840.git.tanggeliang@kylinos.cn>
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
unread, SIOCINQ now reports N instead of N+1, aligning with TCP's
SIOCINQ behavior. The EOF hint of 1 is preserved for the empty-queue
case when the socket is closed or shutdown.

Fixes: f03afb3aeb9d ("mptcp: drop __mptcp_fastopen_gen_msk_ackseq()")
Co-developed-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 02a4f479d9d8..fc4ffa326317 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2402,22 +2402,16 @@ static bool mptcp_move_skbs(struct sock *sk)
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

