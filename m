Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21F830FF36;
	Fri,  7 Aug 2026 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110647; cv=none; b=u7/OEiKmD7PCO/3r9GZYdBtixhSp9x+DqjcI9/CCj+lEDCX7MwzNutrjjFMtBXiR6oIS4dz2ls9naE8tXIrJCuMLmlABNSJ15T1Lmp1v0pL04yoXb62458lpbF+YKBdxEgYtGEajksuKlaW6MzZ5yLozhUc8Zu+lJkBdv26ZLe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110647; c=relaxed/simple;
	bh=1eiyJsGpZHXVZ4bb74ikO4gDWjHoZGmKm4vMNppG+U0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SN39Akq78+vOfVyT8g618uRUVXAyOca/FW8pOCX9MuUubP0E9Gfj4Pvfa/KpPvdfBtpdlWYoUYhZDnegYV02yzhHeR5wXCfBth/slFtdeLxqLo4kbiyHfCc8rzX2AWLYpjELXGq4boTHl927uvFlkZdsZ6ARF7GHhG95C2wfxwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEPTZ2u6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEPTZ2u6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C948B1F00A3F;
	Fri,  7 Aug 2026 13:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786110639;
	bh=bTTBL9ZnohPensATpDZ27YbIQmHvsuAQwXU3J5quaLc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KEPTZ2u6cipf1/m0JPnYnwnUj64eUM3aVP/4WYD2NDt0qYrRlo+w411zFMBu/2yyK
	 WojOblDQPCBEB7lLx9xNHSrY/blsF/PETKet6IhJee1XgYMFPOGw34gakcBp6DCfoZ
	 DnN2ZWxZmCa6WXrAzWFExbbKoJ/U0QdY3osOhoSc3AN/gTz4fkF3V2K/595laADKTW
	 FvH3lKVkBQKO2ixK8Wp9Q+qcyZZdMq+1svhubD9mB9AxmoxOIh/Jr+GxIoHJhr3d0F
	 9kdlhqxhJEB6mFYAiBXXxiG/SuFUX48ueNQQs7ANTDwTfa0bubO4PpBACN+HtSP0Sp
	 +3OBOcYfoT0HA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Aug 2026 15:49:06 +0200
Subject: [PATCH net-next v3 6/7] mptcp: avoid code duplication in
 __mptcp_move_skb()
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-net-next-mptcp-oooq-pruning-v3-6-dbc1eb853cc3@kernel.org>
References: <20260807-net-next-mptcp-oooq-pruning-v3-0-dbc1eb853cc3@kernel.org>
In-Reply-To: <20260807-net-next-mptcp-oooq-pruning-v3-0-dbc1eb853cc3@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2367; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=397Kd7gjPDDLnPSX5yVPxXg++ui+5efdW+wfQQ/dn8I=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJKH807/HPLfIWItAtb9h59ryB6JfXV1wCvqnqh1K2Zw
 gWTzq6f0FHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRhHSG/4kLVi+5bztXq3e1
 w/Jtk+7eePCmbKr1sfV77JRYubqq+A4zMsx8LPd+ioCCVGLo77+HFkUd89ylXXpC9PH6VZaiRzp
 /buQEAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Alike TCP, MPTCP handles in-sequence packets and partially overlapping
ones in a very similar way: we can use the same path to handle both,
avoiding some code duplication.

This will also make the next patch simpler.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v3: new
---
 net/mptcp/protocol.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d96fbdc34dbb..63f2c18bc01f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -399,6 +399,7 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
 		/* in sequence */
+insert:
 		msk->bytes_received += copy_len;
 		WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
 		tail = skb_peek_tail(&sk->sk_receive_queue);
@@ -413,26 +414,20 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 		return false;
 	}
 
-	/* Completely old data? */
-	if (!after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
-		mptcp_drop(sk, skb);
-		return false;
+	/* Partial packet */
+	if (after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
+		copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
+		MPTCP_SKB_CB(skb)->offset += msk->ack_seq -
+					     MPTCP_SKB_CB(skb)->map_seq;
+		MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq -
+					      MPTCP_SKB_CB(skb)->map_seq;
+		goto insert;
 	}
 
-	/* Partial packet: map_seq < ack_seq < end_seq.
-	 * Skip the already-acked bytes and enqueue the new data.
-	 */
-	copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
-	MPTCP_SKB_CB(skb)->offset += msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
-	MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq -
-				      MPTCP_SKB_CB(skb)->map_seq;
-	msk->bytes_received += copy_len;
-	WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
-
-	skb_set_owner_r(skb, sk);
-	__skb_queue_tail(&sk->sk_receive_queue, skb);
-	return true;
+	/* Completely old data */
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
+	mptcp_drop(sk, skb);
+	return false;
 }
 
 static void mptcp_stop_rtx_timer(struct sock *sk)

-- 
2.53.0

