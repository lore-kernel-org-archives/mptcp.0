Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216261;
	b=iiVrrhT++7CYIMDmpEg9KrG2jPo3i6HOHiTSDHaYToKhgFiEQ2+IO1DegtUxCKJp9nTd
	 iKt7Zq2GAnfYv0r+X0OlbXSJpofU94C2O+QRd6dQCLFDpa5/zPZUp/euO7jFM9Vj+faQa
	 tUB8/NzQvHkEUxAUWFFf9IA5mkNW95aciLvgLT2wBbTi0gHivDxTXLmfHz5DmmFj/tlvz
	 cM9Nl+csrx4DdN7S8WONh5oWxVcB34naYEIRykCidmBnESN/QCn87xuIj9+H/xl4OE1fx
	 LetrE5pMybpf24adx5VXhe22r7JbOCjRk1R4XjpENuE0g64uO1ZVqhCINgrRCvQB7jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216261;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=l35yA2Z9ObORN8hZwHVDCw9GGIE6GOf+Q2lxZP3cdyk=;
	b=ClFWlGS/xTcYOVZA26SUoZ7hN6RE47V1MeXVnflAIZnjEUHMqRtSIpE6sZw6AAEPNqAm
	 lYdk/+MbsuXC/TjRhd2t7cwEGNnFi+D3EWhceZaJjdKmUFtwLfHwau5ZoM5vKgRAED+ts
	 HPhGi8syBzjoH1WXqwQzPwZGJxMkhrD3XMnc9z3XQfUk0JSW7LLQmWgbhre5hN3X+/XKa
	 oUb/LhRC1ERc4CeU8PnSPWwcOAGET8bWnfnTcGPMkgM4uRIc3a1KM8v9bfaE7oLjRw/ba
	 5pzSQ5MNEvDWrFSgZ03yaRWKRKJc6SLU2ro05DMxWKVpyU+pH3EMcSlt7ccHR609BqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HJ4noAgG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E86E606D80A
	for <mptcp@lists.linux.dev>; Mon,  9 Nov 2026 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HJ4noAgG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CB11F008A1
	for <mptcp@lists.linux.dev>; Mon,  9 Nov 2026 09:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794216260;
	bh=l35yA2Z9ObORN8hZwHVDCw9GGIE6GOf+Q2lxZP3cdyk=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=HJ4noAgGfT0YOF6Mj5vmnhJtn5WW4oLwbwa2mFKtqzVZhST5TCaOaZQrpd5q+unst
	 eaRE4esL3CdY9ETweE2Q/7qQ7/py2UknvoqtAUrVVKJTyyjFwAn6OyhIzilFaj4VDp
	 NRcQvryGfJAHzy37WFvzQkFmWScvMyMJ6gfMdEVmAOV3tt+59K8FvrjBl0qHI3F6a/
	 e41g4vYsURoE+TOkVk+IR7zU/CZLg/RaJTYAt8vygwlaRcF8cbQ/M8g8xTWb0qJKV7
	 pDORSeI05lqGhgf5akp7CviB2Ybr+EEOm0U/Oo5mRS64Y9Pnvf+d0NpQGGDuF2IbPf
	 hEi5fNMnTAMzw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v24 1/8] mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint
Date: Mon,  9 Nov 2026 17:24:03 +0800
Message-ID: <3965b9beff100e81b43980484fd1c8d9297274ff.1794215614.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794215614.git.tanggeliang@kylinos.cn>
References: <cover.1794215614.git.tanggeliang@kylinos.cn>
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
report INT_MAX.

Using mptcp_data_avail() avoids this by tracking bytes directly. This
change also affects non-TFO connections after DATA_FIN: with N bytes
unread, SIOCINQ now reports N instead of N+1, aligning with TCP's
SIOCINQ behavior. The EOF hint of 1 is preserved for the empty-queue
case when the socket is closed or shutdown.

Fixes: f03afb3aeb9d ("mptcp: drop __mptcp_fastopen_gen_msk_ackseq()")
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

