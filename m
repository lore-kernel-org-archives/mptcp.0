Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826672;
	b=APpfmAxMT+USf9wjZ6mTX+8LJyAQ1j7ClaQx5CT62Lccaq/3pJFq3K/5imDgez1Rj6Jw
	 +I2VbNgdjHNAoe5qeSsYKkrlBnlalDTvFQ1TJPmooPJ5jn+B1egXpUI2CNe6g35f9rZp7
	 kfBcO/LVUQt5otLQuZ1rEQRF5VuTkydUYPvL0A2ztlfNVG6tmlWPbGPNXR0hwxHaLZZvZ
	 7HZlvLUqdtVdKADukO8Q53F/oU+R9TG8q20fksf4BysnShq0uCREbICIt0jD8H9esIkRd
	 og7BVYaiI3W8Tlo4sfzVa+bHcuJLE5Rzq8lOPitdzxfAPtzkNKlBbBbQNpTDOQfBdKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826672;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Hoy39yNhzDeaZpyfhT4Xl0t7Jts1eO/G9YsnX5QQvuw=;
	b=fMYFI9MX3GhIXrLp8YSMGPuanMR4EH5FHScMiRJCSQhu3i+WfbJRR/92ipMimD3Gli1i
	 STQgTboIKrSAAB1//LCqqZZ4/w3LwQ6Td18x9tLb5fZFZh+0S2VRFAlWScDcDfM9Tn8un
	 Br0ebSD9QzUPfPVDh1pzsUNEfhhUXz5VGyghK3nAxOR7pceCu+fohQ3hJgDd1Y+pzz4Is
	 urExoRj6c/JjbQ7CNnSn0CZa2Mw/AxASJVL0fcG8z1v5ZJWcFdzUmYlqmJW05ZdKrHEbZ
	 4nryRiS71gmEjKTptHz9UF2Klt4ODZOmYThsmxjbs8FaCC0AwxV9nMOaZYn7S9xavWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ANkkaMjV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05B2606A32A
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ANkkaMjV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D081F000C6
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 10:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794826671;
	bh=Hoy39yNhzDeaZpyfhT4Xl0t7Jts1eO/G9YsnX5QQvuw=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=ANkkaMjVg+ZPFsnR3jTAeBSfXN/14bDpFCIu4/ecOQEiCsyYhSkKKAqf093mLrWoW
	 Q2i3BtJg5GKieHbloqkImfNuNqWqF+aVbHwIVQUfVFjy3kr+vXpalPhx3ydqP5eeew
	 kslFXp7otvE1vCUWMfJOTDfkQTIo8/kgurNcPS0sifugLpkM2SnwtDwzPEfscKp8PL
	 CEcfxhJY8OOf+kGZcdxPUlydhcwHK9iospM508lJSDNfaIICYIbrPartyUTWFRkKJ/
	 pIHZ50A5YsPkDj/NDNV0h8G11R0pdMEupfa9vUbqLjcDyTeaPPN3UcZZ36fD2O2t36
	 3qH1yziP+v47A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v8 1/7] mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint
Date: Mon, 16 Nov 2026 18:57:39 +0800
Message-ID: <2aa50a4b4f9ed4833a91e791918e02ec206876e0.1794826541.git.geliang@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794826541.git.geliang@kernel.org>
References: <cover.1794826541.git.geliang@kernel.org>
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

On passive TFO connections, the TFO skb has map_seq set to -skb->len,
causing mptcp_inq_hint() to compute "ack_seq - map_seq = iasn + len",
which overflows to INT_MAX. This breaks SIOCINQ/FIONREAD, TCP_CM_INQ,
and receive buffer autotuning.

Using mptcp_data_avail() avoids this overflow. To maintain TCP semantics,
the hint includes the FIN byte (adds 1) when DATA_FIN is pending
(RCV_SHUTDOWN set) or the connection is closed (TCP_CLOSE state). This
ensures SIOCINQ reports N+1 when N bytes are unread with DATA_FIN pending,
matching TCP behavior where FIN consumes a sequence number.

Fixes: f03afb3aeb9d ("mptcp: drop __mptcp_fastopen_gen_msk_ackseq()")
Co-developed-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 50de5cedfd0f..574eba9989a8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2404,22 +2404,15 @@ static bool mptcp_move_skbs(struct sock *sk)
 static unsigned int mptcp_inq_hint(const struct sock *sk)
 {
 	const struct mptcp_sock *msk = mptcp_sk(sk);
-	const struct sk_buff *skb;
+	u64 hint_val = mptcp_data_avail(msk);
 
-	skb = skb_peek(&sk->sk_receive_queue);
-	if (skb) {
-		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
-
-		if (hint_val >= INT_MAX)
-			return INT_MAX;
-
-		return (unsigned int)hint_val;
-	}
+	if (hint_val >= INT_MAX)
+		return INT_MAX;
 
 	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
-		return 1;
+		hint_val += 1;
 
-	return 0;
+	return (unsigned int)hint_val;
 }
 
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-- 
2.55.0

