Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482632DBF75;
	Sat, 26 Sep 2026 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790436653; cv=none; b=MEBkW7yECj8c4vORwjP1V2QInaklfqeJ/RrT5W8GKb4dDvCK5e4f3jddBXwHJJcVdhGRrVq5IHMN28cB+nB//8fjMZelY7ysh4J1KZLmL3R4QvKnYHy8L830DBMuxtFMrAc+r/XBRegl4kvWbm9ClVctb5+DeQfkCbLvc14Doxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790436653; c=relaxed/simple;
	bh=2LpqQ7QmQzukCZTydu4Qhzi/p0rOw9Lkni18IjLNkSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hUlWlRlYtQV1atHiDJDny9SbIS3kiKH9Bujefiga5UWanEWvlgr4CX23djRmzn0L3vdz5dqnRWWgO5cS270Tw3mhVkZ50UxEfbb5qwrPFr8qZow63ALDMik7HTEXyoJuDRylzHMycavbK6z2iAoNEmGu4zTNHAl0idQqAJxyRew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQgUIHV4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQgUIHV4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209F01F0089D;
	Sat, 26 Sep 2026 15:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790436651;
	bh=4XH8V9Su8JHaF3lOt0qHFhwovcLFv8tgWKpGaq+UFz4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gQgUIHV4lUfkk9f9bVPqwF/dFaDTZ7dSQgKBgyKJ1gbftBPl0yHH5NhhQLRB5XMpT
	 TvWtBhQBaHrffy3Uh+0R72aTFgEnRx9LQixnuEwjK8HB074lOCAKzEDMvTzTKW2VFQ
	 5f6w8ukeHRlV+tcqigHP7WAw2IG4SYptndbqZ7XV8JNGGbyXYLAQzI4duaf74nbhzT
	 dxCoBXpybqAXgsxdySSh3wk65QLSCUEHNh9MEs/yYz/bJ0jygBDdn7zsG3oQxqE5+j
	 mx3OljD5hEwqhI3h30pu/h0l7Vg2geA0YH88SmqAVX24M7gTDsxu/hZ+QvfX8vrNRD
	 nro2a+xgO1s6Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 26 Sep 2026 17:30:34 +0200
Subject: [PATCH net-next 1/5] mptcp: remove thmac from subflow ctx
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-net-next-mptcp-misc-feat-7-4-v1-1-67af4ab37406@kernel.org>
References: <20260926-net-next-mptcp-misc-feat-7-4-v1-0-67af4ab37406@kernel.org>
In-Reply-To: <20260926-net-next-mptcp-misc-feat-7-4-v1-0-67af4ab37406@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2814; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2LpqQ7QmQzukCZTydu4Qhzi/p0rOw9Lkni18IjLNkSw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK2P1VpblTYdn7903m2v/033HaKlIp8r/Vg7X7Z603tH
 ZO1zY9Gd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzkRjEjw5rJX9nZbDZdPjjn
 9aF/jit2KrHPm7h75pIJTpLZPw5u9HNlZLio0WQ950+v4KzSn53XTUpulPfNXSUU8Vlhn397uNi
 H4ywA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This entry is only used in subflow_finish_connect().

Instead, use the original value from mp_opt, and pass it to
subflow_thmac_valid() to do the validation with the given truncated
hmac.

While at it, rename the variables in subflow_thmac_valid() to avoid
confusions about the received one vs the expected one.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.h |  1 -
 net/mptcp/subflow.c  | 18 +++++++++---------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0384d6a023f9..dd9957d334b6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -593,7 +593,6 @@ struct mptcp_subflow_context {
 	bool	fully_established;  /* path validated */
 	u32	lent_mem_frag;
 	u32	remote_nonce;
-	u64	thmac;
 	u32	local_nonce;
 	u32	remote_token;
 	union {
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f0a6725d2c37..14aa82647c3d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -408,20 +408,21 @@ static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
 #endif
 
 /* validate received truncated hmac and create hmac for third ACK */
-static bool subflow_thmac_valid(struct mptcp_subflow_context *subflow)
+static bool subflow_thmac_valid(struct mptcp_subflow_context *subflow,
+				u64 thmac)
 {
 	u8 hmac[SHA256_DIGEST_SIZE];
-	u64 thmac;
+	u64 expected_thmac;
 
 	subflow_generate_hmac(subflow->remote_key, subflow->local_key,
 			      subflow->remote_nonce, subflow->local_nonce,
 			      hmac);
 
-	thmac = get_unaligned_be64(hmac);
-	pr_debug("subflow=%p, token=%u, thmac=%llu, subflow->thmac=%llu\n",
-		 subflow, subflow->token, thmac, subflow->thmac);
+	expected_thmac = get_unaligned_be64(hmac);
+	pr_debug("subflow=%p, token=%u, expected_thmac=%llu, thmac=%llu\n",
+		 subflow, subflow->token, expected_thmac, thmac);
 
-	return thmac == subflow->thmac;
+	return expected_thmac == thmac;
 }
 
 void mptcp_subflow_reset(struct sock *ssk)
@@ -575,14 +576,13 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		}
 
 		subflow->backup = mp_opt.backup;
-		subflow->thmac = mp_opt.thmac;
 		subflow->remote_nonce = mp_opt.nonce;
 		WRITE_ONCE(subflow->remote_id, mp_opt.join_id);
 		pr_debug("subflow=%p, thmac=%llu, remote_nonce=%u backup=%d\n",
-			 subflow, subflow->thmac, subflow->remote_nonce,
+			 subflow, mp_opt.thmac, subflow->remote_nonce,
 			 subflow->backup);
 
-		if (!subflow_thmac_valid(subflow)) {
+		if (!subflow_thmac_valid(subflow, mp_opt.thmac)) {
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKMAC);
 			subflow->reset_reason = MPTCP_RST_EMPTCP;
 			goto do_reset;

-- 
2.55.0

