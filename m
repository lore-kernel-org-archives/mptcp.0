Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811160;
	b=s+ejvJ1ffrA8ShGUzVllBo7Ae7bC0fZJ2o7x5AR5dDFZ4h/ABbQh7HH6dV9jEPWZmMQq
	 vqADs6aRwumA/3/77/miUZ2gEpCEEqEbtJUngtDZfBnZcq9b3JffJ5mOJbZDzIMys6mqR
	 o4Sxch5dfLkSoiqlvFcvmm5Jxq1Aiid8J+LzLXCYauysGCyuVhikDv8H2Y2SJ9W6dva5F
	 56fDLKhg1sL9VZemvaLYwzHGId5zCjLgRKgQBkztr0xOS38/DW1HKUr+IJaAtC7FyOCEd
	 MQymPc4Qhp5TVXktrqRIgcxKTAp/QQqVtQJpabqx8kIzs817NGr3HjeK8jlOEkq76EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811160;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9vVVWh4W//R54E9bqwoejQhuDGXSuv2Ba6w6xbgdSDc=;
	b=kKcg/qeWWQD/NnCFHGE4kKLUs2zgmr5cgM6utOzHkVqL1q2pYHsBPVovo69jFBbZwRhB
	 r6nD5A7EShAqIMUn0DInCtwxdNOS7Ayn45KeNPamo7NBVpXDQEBoFzEsuEzj4vtwvU4cb
	 2H3wmTbtE2ZeKjhkVf3BTFu/jy/k52YaDWJ0npJ/fbIncpmHyq/0Nh9rO/yP6WGQ+SlWs
	 9TiHD/3VnmdUxW2cdeqlEUtfcvMle96JBE5QxCNDbiKynwvoTKEbTws9MUl1XeQwpD7YF
	 cnBQYl/+TYuoZUUzO2d8J9wlKCXicyP2C5Np2gKn8B3kv6ex1uIxzHrpxIflIGJhKyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UDEEzAmb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844D4606A329
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 06:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UDEEzAmb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA601F000D0
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 06:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794811160;
	bh=9vVVWh4W//R54E9bqwoejQhuDGXSuv2Ba6w6xbgdSDc=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=UDEEzAmbl/stRNDT75rVfGYL5p96iMeMa8TcXcrfmfaCWNZMm8lNOwVDM/pdRZlhh
	 dHOj7tIwoUVIgDxHz5Vdsl2+rmUWrQFtDpQQ0Y4NJZY4XW+Xn+9YYsY3QSFa+FmNpC
	 s1Rr5UQ1NMQoQvDo8tl3fBU8rjAY500UvpSFcpvI/0McqZRw4qTVzsTAOVIwQM8fre
	 h2Yez7Y9Ap4FYs7PHyyCMQTGCmO0pcIif0tLGCCGbz1S2IoK6xvqBChEmM5w+BWOtx
	 wI5SXPakgbxg2wEOcT+mLfQQL1hjh7DvPgsSHGg5lMpq6TeTiI0uQ7W+0lKC3oSFU9
	 x2sxl/PTjhJfA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v28 09/11] mptcp: drop data after DATA_FIN before skb init
Date: Mon, 16 Nov 2026 14:39:02 +0800
Message-ID: <0b6321dafceaf638b198d43b6918ed87a58cf5f1.1794810809.git.tanggeliang@kylinos.cn>
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

After the previous commit, data arriving at or after DATA_FIN must be
explicitly dropped to prevent state corruption. Without this check, such
data could cause offset wraparound in __mptcp_recvmsg_mskq(), leading to
bytes_consumed exceeding bytes_received, mptcp_data_avail() wrapping to
U64_MAX, SIOCINQ reporting unread data after EOF, and improper connection
closure.

Add mptcp_seq_after_data_fin() helper that checks if a DSN range
[seq, seq+len) overlaps with or is beyond the DATA_FIN sequence number,
and call it in __mptcp_move_skbs_from_subflow() before mptcp_init_skb()
to avoid unnecessary skb initialization for data that will be discarded.
The helper uses memory barriers (smp_wmb/smp_rmb) to ensure proper
ordering between rcv_data_fin_seq and rcv_data_fin flag.

Also update the fin check condition in the else branch to only warn when
len == 0 (skb fully consumed) and no FIN flag is present, avoiding false
warnings when skbs are dropped due to DATA_FIN.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/options.c  |  1 +
 net/mptcp/protocol.c | 30 +++++++++++++++++++++++++-----
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 71579238a951..425a7fe94e0c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1177,6 +1177,7 @@ bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool us
 
 	WRITE_ONCE(msk->rcv_data_fin_seq,
 		   mptcp_expand_seq(READ_ONCE(msk->ack_seq), data_fin_seq, use_64bit));
+	smp_wmb(); /* ensure rcv_data_fin_seq is visible before rcv_data_fin */
 	WRITE_ONCE(msk->rcv_data_fin, 1);
 
 	return true;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ddc98497f0eb..78ca580c6d9c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -811,6 +811,25 @@ static void __mptcp_add_backlog(struct sock *sk,
 		msk->backlog_unaccounted += delta;
 }
 
+static bool mptcp_seq_after_data_fin(struct mptcp_sock *msk,
+				     struct sock *ssk, u32 len)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	struct sock *sk = (struct sock *)msk;
+
+	if (READ_ONCE(msk->rcv_data_fin) || (sk->sk_shutdown & RCV_SHUTDOWN)) {
+		u64 seq = mptcp_subflow_get_mapped_dsn(subflow);
+		u64 fin_seq;
+
+		smp_rmb(); /* ensure we see the updated rcv_data_fin_seq */
+		fin_seq = READ_ONCE(msk->rcv_data_fin_seq);
+		if (!before64(seq, fin_seq) ||
+		    !before64(seq + len, fin_seq + 1))
+			return true;
+	}
+	return false;
+}
+
 static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 					   struct sock *ssk, bool own_msk)
 {
@@ -826,7 +845,8 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		u32 map_remaining, offset;
 		u32 seq = tp->copied_seq;
 		struct sk_buff *skb;
-		bool fin;
+		bool fin, data_fin;
+		size_t len;
 
 		/* try to move as much data as available */
 		map_remaining = subflow->map_data_len -
@@ -850,9 +870,9 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		if (fin)
 			seq++;
 
-		if (offset < skb->len) {
-			size_t len = skb->len - offset;
-
+		len = skb->len - offset;
+		data_fin = mptcp_seq_after_data_fin(msk, ssk, len);
+		if (len > 0 && !data_fin) {
 			mptcp_init_skb(ssk, skb, offset, len);
 
 			if (own_msk) {
@@ -870,7 +890,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		} else {
 			sk_eat_skb(ssk, skb);
 
-			if (unlikely(!fin)) {
+			if (len == 0 && unlikely(!fin)) {
 				DEBUG_NET_WARN_ON_ONCE(1);
 				mptcp_dss_corruption(msk, ssk);
 			}
-- 
2.55.0

