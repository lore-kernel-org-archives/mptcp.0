Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1262D47AF65
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787075745; cv=none; b=pOwPzAxgVdy/tKVPOaN3Wp1qjVMPvBkulzD1H1cs59T85PjcISa9GULQODGBOaAfS/ftygC8M+NV32R9K/n+FfIkGNRdavyvHqV8bMtCYXMX+TknytLkvFyNe36nSwwmo4Fagae5877+qskJkVnn/w0PrhEb26J6OCYFaI+r3UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787075745; c=relaxed/simple;
	bh=qxRROWwQ8oc0NuQDC9w0xnYA4H0C9AKTQ5OiLXrfYzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Es+jpbqDEChuqv/2vmhpLSaLVNyky1TollFyBnHj/qjX7GFNxsG5XCqN8kxrVkviZCYO5IxgWY9rZS2nhuztLj6wR/m7klkBziQ8nQlnlSMyfjBHQuRomDvQXiXW8xe7O8bRASP1oX/1tufiH7l5xUPP31XcFiyzcHRXKv2T8TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=honBLWvb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="honBLWvb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E90E1F00A3D;
	Tue, 18 Aug 2026 17:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787075743;
	bh=lzaPrvpSMllT3wMTxBSlDgZsDrvZp4pmQbvozGfdawc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=honBLWvbiF7EgZygHONr7NkpGii5qVzZpusz6eALe7ez+mkzh1BjMMunDBzU+QzE2
	 idmXi1WHrTS+FreBFuGV1z3dWo4ysq0PITwcRhaaUL9mz0SdTPfDI71GSSr8a3ma2Z
	 +6Mq/lrRyLKRXs+9HY3rVW8Fe5etuUCoNHHJ+2JnV/hmLxcqsDpjxViH1OaDSmIjSp
	 dJReAIp3sUrtOInoZXTKHjCVprEA3wlWkPnSG/Vwu8Hu1masEYtVF+LcdHBGYPiKkP
	 oTbCJiyUrANtPsX3GLpflnu1TGEIU4Qj65TPg1+DTTShOJNeyGrSMfPygACO4QNg4N
	 6QlBFOXO8ZDMQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 18 Aug 2026 19:55:27 +0200
Subject: [PATCH next mptcp-net 3/3] mptcp: remove thmac from subflow ctx
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-mptcp-cook-reqb-v1-3-052dea9a7f20@kernel.org>
References: <20260818-mptcp-cook-reqb-v1-0-052dea9a7f20@kernel.org>
In-Reply-To: <20260818-mptcp-cook-reqb-v1-0-052dea9a7f20@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2766; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qxRROWwQ8oc0NuQDC9w0xnYA4H0C9AKTQ5OiLXrfYzA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJa5syRWBqWUMDWuiqFz6gsxrHu5hbbcvd7U47HK/68d
 6TvdM6VjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIkEazAyfLvBN/PVEu+OQ4v1
 w+XYPO7M1d+kUtbVIxR3vVp07YlpTxkZ5lx5dEPnlfUh5zwj5gKvZNGXsfecC7cy6RfNexv73Ni
 FGQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This entry is only used in subflow_finish_connect().

Instead, use the original value from mp_opt, and pass it to
subflow_thmac_valid() to do the validation with the given truncated
hmac.

While at it, rename the variables in subflow_thmac_valid() to avoid
confusions about the received one vs the expected one.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.h |  1 -
 net/mptcp/subflow.c  | 18 +++++++++---------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7e168e450fb0..d414065d1966 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -592,7 +592,6 @@ struct mptcp_subflow_context {
 	bool	fully_established;  /* path validated */
 	u32	lent_mem_frag;
 	u32	remote_nonce;
-	u64	thmac;
 	u32	local_nonce;
 	u32	remote_token;
 	union {
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 01db7edce18a..2d7ccb01d234 100644
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
@@ -571,14 +572,13 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
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
2.53.0

