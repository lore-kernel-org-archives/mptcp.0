Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE77B212B02
	for <mptcp@lists.linux.dev>; Wed, 22 Jan 2025 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547806; cv=none; b=Cjjx6f2IJzasJO2Zyj+z5N/WbMYbyEimmMNoDnF/y2vIDXL16h4VPGdXY575hvGqO7VMdIKfT+nFEogXJDsu6EqZxGRhcwGiFS3HbdMz6TdmsOeHhFxVTk8aM2yWla6FVhEBqKgtGp8EpXY4Mr0HdIgsV8NgRNwqH53DHLResVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547806; c=relaxed/simple;
	bh=539lQPpLKOegJWysqZUY7JNi2CwjPn+/shACUmtbl4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gewmp+gHEr0VYpQ2c0m8Hkvyo6kpw8iMQn0arRgF1CptJ9Cg+3BDS0Sbs0RVIQzEU0CpwmfY1Zpmw4klRJfW9e813tJyiu388y83vW106wxBRPKy0/cJUfV2Krgr7hx+bQAH2GT/zgWwEa0QZHzPGA54eF4hNzJey9pr3QA+qzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSs+EHpp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSs+EHpp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8291C4CED6;
	Wed, 22 Jan 2025 12:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737547805;
	bh=539lQPpLKOegJWysqZUY7JNi2CwjPn+/shACUmtbl4s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aSs+EHppngxdA40GS7XLFSTOMSrgKnnc8pEA1wOjxjFUYKICc+A+sgB9Z8cglgR45
	 XyP1N65STvRP2TBM3YmzObK0RpdsYA9Q8Kl4xaV+GjQy4aVK/NpMpVxVxhFYi+rA8m
	 pC9xWX/Rptp2iVaMgIW4tiYnvyQcURQYOY6eEq5vYUY0LczkmeggOtpbecdlz/HzrH
	 3AD4nFKegbTckIAbAHtShkzy9rcquVAo03bAl77hA2X+8HdOpYYaSQmB62tSa3PE0f
	 ZpICM16PgZ00qKrdqL1XsG8CyZDsw5NeqVZKLrdqnx7uwHJS2l5pE0IiBDTAcWWZkt
	 jFeLSBKmKqEkQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 Jan 2025 13:09:49 +0100
Subject: [PATCH mptcp-net v2 2/2] mptcp: blackhole: avoid checking the
 state twice
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-mpc-no-blackhole-v2-2-13e6670d512f@kernel.org>
References: <20250122-mpc-no-blackhole-v2-0-13e6670d512f@kernel.org>
In-Reply-To: <20250122-mpc-no-blackhole-v2-0-13e6670d512f@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2477; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=539lQPpLKOegJWysqZUY7JNi2CwjPn+/shACUmtbl4s=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnkOAaR13dzKZNxzEA9Ymmr7Ce6apQPW88N2zpL
 +NrPGaEqjCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ5DgGgAKCRD2t4JPQmmg
 c5vjD/9zeJpVJoT5CLARHvJZV4e/B5vFDJmhS9ob9bfhxrgXM+SdmnVfZud9QLaWksJdSmCFjjX
 Hmi9g1n0Gi5S5eFYlYBU8PU+qTAKve5oF0O7eLZLp1pkGbkgpTWfmzTGN0k/tHy3544NDulPKHx
 /kXUF5H+QrGI+C7TceWcI5uV5x6k2SmtP525ZB9Bdw/SK+B/atgX9AbOJp+nK4UGvDkJHFpCWhP
 uyDpm1O7BRJzmGSIS1qxqhuwPLlktdbZLbDJN6yNnCu84qCotGLdIdrmIgx3HkXpoOBr+gHMe9u
 9ITggL2mNP3J7thDtk5O+S4LgmRe4cOGPuT2gIai8/TCnbDsFIq8te3iPdjHs4bSycYm3r/RtBb
 SEDKF32rdEJmaXsRpTObsoI8n8IH8EcI/tdNrtsfRi9/pCBEo1w1ysSb7SF6r34qXQl7/H/o96J
 eBMyTzy93kKrxPSySE5kIjHMO8CXQ3i+m2vuRms1/28MTLfnlwBFR5TjE1KhoMevOOpQOa+J6gu
 z5zcOlZdbZnjTDtZsCA2dVL0hnQ9G6TvW5wHZH4PVGNNTxdlRrYWBpODVMIuVx68DKzSyUVHLPU
 KB7BIOUGDDIH0PgDKnhDOPvh5xVAUwfZJUkRJzCnPn5btJedlmRgS19ZRO/kPRo8UVH6TcqgAFS
 Rb9DxGB+ClQZwxg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A small cleanup, reordering the conditions to avoid checking things
twice.

The code here is called in case of timeout on a TCP connection, before
triggering a retransmission. But it only acts on SYN + MPC packets.

So the conditions can be re-order to exit early in case of non-MPTCP
SYN + MPC. This also reduce the indentation levels.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes: if it is easier, this patch can be squashed in the previous one,
and sent as a fix to -net. There will be conflicts with the previous
versions, but not complex to fix -- and the new sysctl could even be
backported if that's what the stable team prefers.
---
 net/mptcp/ctrl.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 2dd81e6c26bdb5220abed68e26d70d2dc3ab14fb..be6c0237e10bfd7520edd3c57ec43ce4377b97d5 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -401,26 +401,30 @@ void mptcp_active_enable(struct sock *sk)
 void mptcp_active_detect_blackhole(struct sock *ssk, bool expired)
 {
 	struct mptcp_subflow_context *subflow;
+	u8 timeouts, to_max;
+	struct net *net;
 
-	if (!sk_is_mptcp(ssk))
+	/* Only check MPTCP SYN ... */
+	if (likely(!sk_is_mptcp(ssk) || ssk->sk_state != TCP_SYN_SENT))
 		return;
 
 	subflow = mptcp_subflow_ctx(ssk);
 
-	if (subflow->request_mptcp && ssk->sk_state == TCP_SYN_SENT) {
-		struct net *net = sock_net(ssk);
-		u8 timeouts, to_max;
-
-		timeouts = inet_csk(ssk)->icsk_retransmits;
-		to_max = mptcp_get_pernet(net)->syn_retrans_before_tcp_fallback;
-
-		if (timeouts == to_max || (timeouts < to_max && expired)) {
-			MPTCP_INC_STATS(net, MPTCP_MIB_MPCAPABLEACTIVEDROP);
-			subflow->mpc_drop = 1;
-			mptcp_subflow_early_fallback(mptcp_sk(subflow->conn), subflow);
-		}
-	} else if (ssk->sk_state == TCP_SYN_SENT) {
+	/* ... + MP_CAPABLE */
+	if (!subflow->request_mptcp) {
+		/* Mark as blackhole iif the 1st non-MPTCP SYN is accepted */
 		subflow->mpc_drop = 0;
+		return;
+	}
+
+	net = sock_net(ssk);
+	timeouts = inet_csk(ssk)->icsk_retransmits;
+	to_max = mptcp_get_pernet(net)->syn_retrans_before_tcp_fallback;
+
+	if (timeouts == to_max || (timeouts < to_max && expired)) {
+		MPTCP_INC_STATS(net, MPTCP_MIB_MPCAPABLEACTIVEDROP);
+		subflow->mpc_drop = 1;
+		mptcp_subflow_early_fallback(mptcp_sk(subflow->conn), subflow);
 	}
 }
 

-- 
2.47.1

